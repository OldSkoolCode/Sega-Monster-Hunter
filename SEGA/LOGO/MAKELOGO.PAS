program makelogo;

	const	{*** constants ***}
	TitleStr		=	'MAKELOGO - source file converter - V0.0';
	AuthorStr	=	'Written by Andy Onions 1992';

	maxdefs		=	100;	{maximum number of #DEFINE's}

	InExt			=	'ANY';
	SnasmExt		=	'68K';
	MicrotecExt	=	'SRC';
	SierraExt	=	'S';

	space			=	' ';
	period		=	'.';
	hash			=	'#';
	switch		=	'/';
	semicolon	=	';';

	NOERROR		=	0;

	CMDERROR		=	-1;
	MaxLenKnown	=	7;
	CASEASM		=	1;
	ENDCASE		=	2;
	DEFINE		=	3;
	INCLUDE		=	4;
	MaxKnown		=	4;

	ASMERROR		=	-1;
	MaxLenAsm	=	8;
	SNASM			=	1;
	MICROTEC		=	2;
	SIERRA		=	3;
	MaxAsm		=	3;

	UNKNOWN		=	100;
	PARAMETER	=	101;
	FILENAME		=	102;
	DEFINERR		=	103;	

	type	{*** typed variables ***}
	string80		=	string[80];
	fullstring	=	string[255];
	KnownWords	=	array[1..MaxKnown] of string[MaxLenKnown];
	Assemblers	=	array[0..MaxAsm] of string[MaxLenAsm];


	var	{*** variables ***}
	StdOut,
	InFile,
	IncFile,
	OutFile		:	text;
	TextLine,
	InName,
	IncName,
	OutName		:	fullstring;
	KnownWord	:	KnownWords;
	Assembler	:	Assemblers;
	ErrorType,
	AsmType,
	IncLineNo,
	LineNo,
	DefQty		:	integer;
	EndOfFile,
	InINCLUDE	:	boolean;
	OldString	: array[1..maxdefs] of string80;
	NewString	: array[1..maxdefs] of string80;


	{*** procedures and functions ***}

	procedure Error(err:integer);
		begin
		if err=-1 then
			begin
			writeln(StdOut,'Usage:-');
			writeln(StdOut,'MAKELOGO /assembler infile[.ANY]');
			writeln(StdOut,'where assembler is one of:-');
			writeln(StdOut,'SNASM');
			writeln(StdOut,'MICROTEC');
			writeln(StdOut,'SIERRA');
			end;
		if err=-2 then
			writeln(StdOut,'Invalid assembler specified.');
		if err=-3 then
			writeln(StdOut,'Input and output cannot have same name.');
		if err=-4 then
			writeln(StdOut,'Cannot open input file.');
		if err=-5 then
			writeln(StdOut,'Cannot open output file.');
		if err=-6 then
			writeln(StdOut,'Cannot open INCLUDE file.');

		close(StdOut);
		halt;
		end;	{error}


	procedure InitWords;
		begin
		KnownWord[caseasm]	:= 'CASEASM';
		KnownWord[endcase]	:= 'ENDCASE';
		KnownWord[define]		:= 'DEFINE';
		KnownWord[include]	:= 'INCLUDE';

		Assembler[snasm]		:= 'SNASM';
		Assembler[microtec]	:= 'MICROTEC';
		Assembler[sierra]		:= 'SIERRA';
		end;


	procedure GetALine(var ALine:fullstring);
		var
		EndOfLine,
		MakeUpper	:	boolean;
		Len			:	integer;
		Ch				:	char;

		begin	{body of getaline}
		if InINCLUDE then
			EndOfLine := eoln(IncFile)
		else
			EndOfLine := eoln(InFile);
		if not EndOfLine then
			begin
			if InINCLUDE then
				begin
				read(IncFile,ALine[1]);
				EndOfLine := eoln(IncFile);
				end
			else
				begin
				read(InFile,ALine[1]);
				EndOfLine := eoln(InFile);
				end;
			MakeUpper := ALine[1]=hash;
			len := 1;
			while not EndOfLine and (len<255) do
				begin
				inc(len);
				if InINCLUDE then
					begin
					read(IncFile,ch);
					EndOfLine := eoln(IncFile);
					end
				else
					begin
					read(InFile,ch);
					EndOfLine := eoln(InFile);
					end;
				if ch=space then
					MakeUpper := false;
				if MakeUpper then
					ALine[len] := upcase(ch)
				else
					ALine[Len] := ch;
				end;
			ALine[0] := char(len);
			end
		else
			ALine[0] := #0;
		if InINCLUDE then
			begin
			readln(IncFile);
			inc(IncLineNo);
			if eof(IncFile) then
				begin
				close(IncFile);
				EndOfFile := eof(InFile);
				InINCLUDE := false;
				end
			else
				EndOfFile := false;
			end
		else
			begin
			readln(InFile);	{possibly discard end of very long line}
			inc(LineNo);
			EndOfFile := eof(InFile);
			end;
		end;	{getaline}


		function MatchWord(Str:fullstring):integer;
			var
			i,
			KnownLen,
			LineLen	:	integer;
			Found		:	boolean;

			begin	
			LineLen := length(Str);
			i := 0;
			Found := false;
			while (i<MaxKnown) and not Found do
				begin
				inc(i);
				knownlen := length(knownword[i]);
				if (linelen>knownlen) and (knownword[i]=copy(Str,2,knownlen)) then
					Found := true;
				end;
			if Found then
				MatchWord := i
			else
				MatchWord := CMDERROR;	{no match}
			end;


	function WhatAssembler(Str:fullstring;Pos:integer;ch:char):integer;
			var
			i,
			KnownLen,
			LineLen	:	integer;
			Found		:	boolean;

			begin	
			Found := false;
			LineLen := length(Str);
			if (Pos<=LineLen) and (Str[Pos]=ch) then
				begin
				i := 0;
				while (i<MaxAsm) and not Found do
					begin
					inc(i);
					knownlen := length(Assembler[i]);
					if (linelen-Pos>=knownlen) and (Assembler[i]=copy(Str,Pos+1,knownlen)) then
						Found := true;
					end;
				end;
			if Found then
				WhatAssembler := i
			else
				WhatAssembler := ASMERROR;	{no match}
			end;
			

	function GetFileName(Str:fullstring;Pos:integer):fullstring;
		begin
		if (length(str)>pos) and (str[pos]=space) then
			begin
			delete(Str,1,Pos);
			assign(IncFile,Str);
			{$I-}
			reset(IncFile);
			if ioresult <>0 then
				GetFileName := ''
			else
				begin
				IncLineNo := 0;
				GetFileName := Str;
				writeln(StdOut,'Including: ',Str);
				end;
			{$I+}
			end
		else
			GetFileName := '';
		end;	{getfilename}
		

	procedure AddDefList(Str1,Str2:fullstring);
		var
		i	: integer;

		begin
		if DefQty=0 then
			begin
			inc(DefQty);
			OldString[DefQty] := Str1;
			NewString[DefQty] := Str2;
			end
		else
			begin
			i := 1;
			while	(i<=DefQty) and (OldString[i]<>Str1) do
				inc(i);
			if i>DefQty then
				begin
				inc(DefQty);
				OldString[i] := Str1;
				end;
			NewString[i] := Str2;
			end;
		end;


	function GetDefine(Str:fullstring):integer;
		var
		l,i		: integer;
		actual	: fullstring;

		begin
		l := length(Str);
		if (l>0) and (Str[1]=space) then
			begin
			i := 2;
			while (i<=l) and (Str[i]<>space) do
				inc(i);
			if i>2 then
				begin
				actual := copy(Str,2,i-2);
				if i<=l then
					begin
					inc(i);
					if i<=l then
						AddDefList(actual,copy(Str,i,l-i+1));
					GetDefine := NOERROR;
					end
				else
					GetDefine := DEFINERR;
				end
			else
				GetDefine := DEFINERR;
			end
		else
			GetDefine := DEFINERR;
		end;


	procedure OutLine(Str:string);
	{output a commemt line or blank line as is}
	{output other lines with DEFINEd substitutions if any exist}
	{output line as is if no DEFINEs}
		var
		first,
		match,
		index,i	:	integer;

		begin
		if (DefQty=0) or (Str='') or ((Str<>'') and (Str[1]=';')) then
			write(OutFile,Str)
		else
			repeat
				first := maxint;
				for i := 1 to DefQty do
					begin
					match := pos(OldString[i],Str);
					if (match>0) and (match<first) then
						begin
						first := match;
						index := i;
						end;
					end;
				if first=maxint then
					begin
					write(OutFile,str);
					str :='';
					end
				else
					begin
					if first>1 then
						write(OutFile,copy(Str,1,first-1));
					write(OutFile,NewString[index]);
					delete(Str,1,first+length(OldString[index])-1);
					end;
			until Str='';
		writeln(OutFile);
		end;


	function ExtractFile:integer;
		var
		InCASE,
		Echo			:	boolean;
		IncFile		:	fullstring;
		KeyWord,
		AType,
		FatalError	:	integer;

		begin
		LineNo := 0;
		InCASE := false;
		Echo := true;
		InINCLUDE := false;
		FatalError := NOERROR;
		EndOfFile := eof(InFile);
		DefQty := 0;
		
		while not EndOfFile and (FatalError=NOERROR) do
			begin
			GetALine(TextLine);
			if (length(TextLine)>0) and (TextLine[1]=hash) then
				begin
				KeyWord := MatchWord(TextLine);
				case KeyWord of
				CMDERROR:
					FatalError := UNKNOWN;
				CASEASM:
					begin
					AType := WhatAssembler(TextLine,9,'=');
					if AType=ASMERROR then
						FatalError := PARAMETER
					else
						begin
						InCASE := true;
						Echo := AType=AsmType;
						end;
					end;
				ENDCASE:
					if not InCASE then
						FatalError := ENDCASE
					else
						begin
						InCASE := false;
						Echo := true;
						end;
				INCLUDE:
					if InINCLUDE then
						FatalError := INCLUDE
					else
						begin
						IncName := GetFileName(TextLine,9);
						if IncName='' then
							FatalError := FILENAME
						else
							InINCLUDE := true;
						end;
				DEFINE:
					FatalError := GetDefine(copy(TextLine,8,length(TextLine)-7));
					end;	{case}
				end
			else
				if echo then
					case	AsmType of
					SNASM:
						OutLine(TextLine);
					MICROTEC:					
						OutLine(TextLine);
					SIERRA:
						if TextLine[1]<>semicolon then
							OutLine(TextLine);		{strip comment lines}
						end;	{case}
			end;
		ExtractFile := FatalError;
		end;	{ExtractFile}


	function GetParam(param:integer):fullstring;
		var
		str	: fullstring;
		i		: integer;

		begin	{body of GetParam}
		str := paramstr(param);
		for i := 1 to length(str) do
			str[i] := upcase(str[i]);
		getparam := str;
		end;	{GetParam}



	begin	{body of makelogo}
	assign(StdOut,'');
	rewrite(StdOut);

	writeln(StdOut,TitleStr);
	writeln(StdOut,AuthorStr);

	InitWords;

	if paramcount<>2 then
		error(-1);	{usage}

	TextLine := getparam(1);
	AsmType := WhatAssembler(TextLine,1,switch);
	if AsmType=ASMERROR then
		error(-2);	{assembler}

	InName := getparam(2);
	if pos(period,InName)=0 then
		InName := InName+Period+InExt;

	OutName := InName;
	Delete(OutName,pos(period,OutName)+1,3);
	case AsmType of
	SNASM:
		OutName := OutName+SnasmExt;
	MICROTEC:
		OutName := OutName+MicrotecExt;
	SIERRA:
		OutName := OutName+SierraExt;
		end;	{case}

	if InName=OutName then
		error(-3);	{name conflict}

	assign(InFile,InName);
	{$I-}
	reset(InFile);
	if ioresult <>0 then
		{can't open input}
		error(-4);	{input}
	{$I+}

	assign(OutFile,OutName);
	{$I-}
	rewrite(OutFile);
	if ioresult <>0 then
		{can't open input}
		begin
		close(InFile);
		error(-5);	{output}
		end;
	{$I+}

	ErrorType := ExtractFile;

	if ErrorType=NOERROR then
		writeln(StdOut,'Assembler file has been created.')
	else
		begin
		write(StdOut,'FATAL ERROR in line:- ');
		if InINCLUDE then
			writeln(StdOut,IncLineNo,' of ',IncName)
		else
			writeln(StdOut,LineNo,' of ',InName);
		writeln(StdOut,TextLine);
		case ErrorType of
		UNKNOWN:
			writeln(StdOut,'Unknown command.');
		PARAMETER:
			writeln(StdOut,'Unknown assembler type.');
		ENDCASE:
			writeln(StdOut,'Not in a CASE structure.');
		FILENAME:
			writeln(StdOut,'Cannot find INCLUDE file.');
		DEFINERR:
			writeln(StdOut,'Invalid parameters in DEFINE');
		end;	{case}
		end;

	if InINCLUDE then
		close(IncFile);

	close(InFile);			
	close(OutFile); 
	close(StdOut);		

	end.	{makelogo}

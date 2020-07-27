
; $Log: equates.i_v $
;Revision 1.5  1993/06/14  20:25:16  KENH
;*** empty log message ***
;
;Revision 1.4  1993/06/14  20:25:06  KENH
;*** empty log message ***
;
;Revision 1.3  1993/06/07  19:57:44  KENH
;*** empty log message ***
;
;Revision 1.2  1993/05/13  23:09:26  KENH
;*** empty log message ***
;
;Revision 1.1  1993/04/29  13:50:16  KENH
;Initial revision
;

SNASM		equ	0		; snasm vectors?
TAD		equ	1		; snasm vectors?
SEGALOGO	equ	1
DEMO		equ	1

InitSP		equ	$ff2000

SNDADD          equ     $A04000
SNDDAT          equ     $A04001

CNTLA           equ     $A10008
CNTLB           equ     $A1000A
CNTLC           equ     $A1000C
                                        
CNTLAW          equ     $A10009
CNTLBW          equ     $A1000B
CNTLCW          equ     $A10009
                                        
PPCNTL          equ     $A1000D
PPDATA          equ     $A10007
                                        
BUSREQ          equ     $A11100
BUSRES          equ     $A11200
                                        
Z80RAM          equ     $A00000
                                        
VDATA           equ     $C00000
VCTRL           equ     $C00004

TPOINT          equ     $FF0004

CTRL1		equ	$A10009
CTRL2		equ	$A1000B
CTRL3		equ	$A1000D
SCTRL1		equ	$A10013
SCTRL2		equ	$A10019
SCTRL3		equ	$A1001F

;
; ----- animation sequence numbers
;
ANIM_FORWARD	equ	0
ANIM_BACKWARD	equ	1
ANIM_ATTACK	equ	2
ANIM_DEATH	equ	3
ANIM_RIGHT	equ	4

;
; ----- Z80 stuff
;

Z80BASE		equ	$A00000
Z80NoROM	equ	Z80BASE+4	;flag for disabling Z80 ROM accesses
Z80BUSREQ	equ	$A11100		; bit 8 (high=BusReq)
Z80RESET	equ	$A11200		; bit 8 (low=Reset)

;
; -----	Screen setting for game
;
HScroll		set	55*1024	;1K boundary
ScrollA		set	56*1024	;8K boundary
Window		set	56*1024	;4K boundary in 40CELL (2K in 32CELL)
ScrollB		set	56*1024	;8K boundary
SpriteAttr	set	63*1024	;1K boundary in 40CELL (1/2K in 32CELL)

;
; ----- Equates for the VDP Shadow Registers
;
VDP_MODESET1	equ	0
VDP_MODESET2	equ	1
VDP_PATTERNA	equ	2
VDP_WINDOW	equ	3
VDP_PATTERNB	equ	4
VDP_SPRITEATTR	equ	5
VDP_REG6	equ	6
VDP_BACKCOL	equ	7
VDP_REG8	equ	8
VDP_REG9	equ	9
VDP_HINTREG	equ	10
VDP_MODESET3	equ	11
VDP_MODESET4	equ	12
VDP_HSCROLL	equ	13
VDP_REG14	equ	14
VDP_AUTOINC	equ	15
VDP_SCROLLSIZE	equ	16
VDP_WINDOWHPOS	equ	17
VDP_WINDOWVPOS	equ	18
VDP_DMALENLO	equ	19
VDP_DMALENHI	equ	20
VDP_DMASRCLO	equ	21
VDP_DMASRCMID	equ	22
VDP_DMASRCHI	equ	23

;
;
;
CR		equ	13
LF		equ	10


;
; -----	Bits for the VDP registers
;
IE0		equ	%0000000000100000
IE1		equ	%0000000000010000
IE2		equ	%0000000000001000
M1		equ	%0000000000010000
M2		equ	%0000000000001000
M3		equ	%0000000000000010
DISP		equ	%0000000001000000
VSCR		equ	%0000000000000100
HSCR		equ	%0000000000000010
LSCR		equ	%0000000000000001
RS0		equ	%0000000010000000
RS1		equ	%0000000000000001
STE		equ	%0000000000001000
LSM1		equ	%0000000000000100
LSM0		equ	%0000000000000010
VSZ1		equ	%0000000000100000
VSZ0		equ	%0000000000010000
HSZ1		equ	%0000000000000010
HSZ0		equ	%0000000000000001
DMD1		equ	%0000000010000000
DMD0		equ	%0000000001000000
CD0		equ	%0100000000000000
CD1		equ	%1000000000000000
CD2		equ	%0000000000010000
CD3		equ	%0000000000100000
CD4		equ	%0000000001000000
CD5		equ	%0000000010000000
DMA		equ	%0000000000000010

;
; ----- Screen map width & height
;
MAPWIDTH	equ	64
MAPHEIGHT	equ	28
SCOREHCHARS	equ	2
VISIBLEMAPWIDTH	equ	40
SCREENWIDTH	equ	320
THEWALLYPOS	equ	24

LEFTBORDCHARS	equ	4
RIGHTBORDCHARS	equ	4
TOPBORDCHARS	equ	4
BOTTOMBORDCHARS	equ	1
;
; ----- Pov equates
;
SRCPOVWIDTH	equ	120			; 
MAXPOVWIDTH	equ	112			; maximum width/height for POV
MAXPOVHEIGHT	equ	200			; wall set
WALLWIDTH	equ	40
WALLHEIGHT	equ	72
;
;
;
SIDEFLOORHEIGHT	equ	72
SIDEFLOORWIDTH	equ	256
;
;
;
FLOORHEIGHT	equ	52
FLOORHCHAR	equ	(FLOORHEIGHT+7)/8
FLOORYCHAR	equ	(MAPHEIGHT-BOTTOMBORDCHARS)-FLOORHCHAR
FLOORWIDTH	equ	(184/8)
FLOORVISIBLE	equ	(VISIBLEMAPWIDTH-LEFTBORDCHARS-RIGHTBORDCHARS)
;
; -----	Character map bit definitions
;
CHARPRIORITY	equ	%1000000000000000
CHARCP1		equ	%0100000000000000
CHARCP0		equ	%0010000000000000
CHARVF		equ	%0001000000000000
CHARHF		equ	%0000100000000000
CHARHFBIT	equ	11
;
; ----- Dma queue equates
;
MAXDMAQUEUE	equ	20			; 20 per frame
MAXDMAXFERAFRAME equ	6*1024			; 6k per frame
;
; -----	Screen Movements
;
RIGHT		equ	%1
LEFT		equ	%10
FORWARD		equ	%100
BACK		equ	%1000
WAITTILLCLEAR	equ	-2
ENDOFLEVEL	equ	-1

;
; ----- AI movement types
;
WALKFORWARD	equ	1
WALKBACKWARD	equ	2
ATTACKING	equ	3
DIEING		equ	4
WALKSIDEWAYS	equ	5
OTHER		equ	6

;
; ----- Monster AI types or'ed with $80 means non-moving command 
;				so do instructions immediatly.
;
AI_NULL		equ	0
AI_WAIT		equ	1
AI_MOVEFORWARD	equ	2
AI_MOVEREL	equ	3
AI_MOVEBACK	equ	4
AI_MOVEABS	equ	5
AI_ATTACK	equ	6
AI_DIE		equ	7
AI_SPECIAL	equ	8		; special routine adjusts monsters
AI_GOTO		equ	9|$80		; goto ai structure
AI_STATIC	equ	10		; none-moving
AI_SUMMON	equ	11|$80		; add monsters
AI_ATTACK2	equ	12
AI_LOOP		equ	13|$80		; loop command
AI_SETANIM	equ	14|$80		; set animation/frame command
AI_IF		equ	15|$80		; if variable command
AI_SETVAR	equ	16|$80		; set variable = true/false
AI_SETSTRUCTURE equ	17|$80		; set structure variable

TRUE		equ	-1
FALSE		equ	0

;
; ----- system variables
;
MOVEMENTVAR	equ	15

;
; -----	Sub AI types for WAIT
;
AIWAIT_STATIC	equ	0		; wait static (still)
AIWAIT_ANIMATE	equ	1		; wait and animate in current position
AIWAIT_HIDDEN	equ	2		; wait hidden for timeout
AIWAIT_TILCLEAR	equ	3		; wait till no monsters
AIWAIT_FORNUM	equ	4		; wait until only xx monsters
AIWAIT_EXPOSE	equ	5		; expose hidden object
AIWAIT_STOPPED	equ	6		; wait until stopped
AIWAIT_COUNT	equ	7		; wait number of game frames
;
; ----- Sub AI types for move forward
;
AIMF_STATIC	equ	0
AIMF_ANIMATE	equ	1
;
; ----- Sub AI types for move relative
;
AIMR_STATIC	equ	0
AIMR_ANIMATE	equ	1
;
; ----- Sub AI types for move back
;
AIMB_STATIC	equ	0
AIMB_ANIMATE	equ	1
AIMB_TOPERCENT	equ	2
;
; ----- Sub AI types for move absolute
;
AIMA_STATIC	equ	0
AIMA_ANIMATE	equ	1
;
; ----- Sub AI types for attacks
;
AIATT_STATIC	equ	0
AIATT_ANIMATE	equ	1
;
; ----- Sub AI types for dieing
;
AIDI_ANIMATE	equ	0
AIDI_REDUCEHP	equ	1
AIDI_RETREAT	equ	2
AIDI_ADDPLAYERHP equ	3
AIDI_ADDAMMO	equ	4

;
; ----- Sub AI types for looping
;
AILP_START	equ	0
AILP_END	equ	1

;
; ----- Sub AI types for looping
;
AISU_ADD	equ	0
AISU_CALL	equ	1		; just call don't add as monsters to
					; kill
AISU_RELATIVE	equ	2		; just call don't add as monsters to
					; kill



;
; ----- Sub AI types for static objects
;
AIST_STATIC	equ	0
AIST_ANIMATE	equ	1
AIST_FIXEDST	equ	2		; fixed to wall position static
AIST_FIXEDANIM	equ	3		; fixed to wall position animating
AIST_FORNUM	equ	4		; wait for number of monsters

;
; -----	sub ai type for set structure variable
;
AISS_STORE	equ	0
AISS_OR		equ	1
AISS_AND	equ	2

	
;
; ----- sub AI types for special
;

;
;
;
MAXNMONSTERS	equ	35
WALLSONSCREEN	equ	8			; number of walls horizontal scr
POVWALLSONSCREEN equ	5			; number of pov walls on screen
;
; -----	General equates
;
SCORESIZE	equ	6
MAXSPRITES	equ	120
MAXSTATICSPRITES equ	20
;
; ----- static sprites # in array
;
STATICCROSSH	equ	0
STATICBLIP	equ	2
STATICAMMO	equ	4
STATICLEFTSIDE	equ	6
STATICRIGHTSIDE	equ	8
STATICDUMMY1	equ	10
STATICDUMMY2	equ	12
STATICDUMMY3	equ	14
STATICDUMMY4	equ	16
STATICREDCROSS1	equ	18
STATICREDCROSS2	equ	20
STATICAMMOCLIP1	equ	22
STATICAMMOCLIP2	equ	24


POVXCHARS	equ	40
POVYCHARS	equ	28
POVCENTERCHARS	equ	(POVXCHARS-((MAXPOVWIDTH/8)*2))-(LEFTBORDCHARS+RIGHTBORDCHARS)
;	Background Maps:
;		UWORD	Offset to Palette
;		UWORD	Offset to Map
;		UWORD	Offset to Character Definitions
;		???
;		Palette:
;			WORD	Color Register index
;			UWORD	Number of colors
;				UWORD	RGB Value (Sega format)
;				...
;			...Repeat...
;			-1		End of list
;		Map:
;			UWORD	Width of Map
;			UWORD	Height of Map
;			UWORD	Map[][]
;		???	Insert new blocks here.
;		Character Definitions:
;			UWORD 	Number of characters
;			BYTE	32 Bytes per character
BACKHEADER	rsreset

BHPALOFFSET	rs.w	1		; offset to palette
BHMAPOFFSET	rs.w	1		; offset to map
BHCHAROFFSET	rs.w	1		; offset to character definitions


;
; -----	Palette structure
;
PALSTRUCT	rsreset

BPCOLORINDEX	rs.w	1
BPNUMCOLORS	rs.w	1
BPRGBVALUES	rs.w	0


;
; ----- Map structure
;
BACKMAP		rsreset
BMWIDTH		rs.w	1
BMHEIGHT	rs.w	1
BMMAP		rs.w	0


;
; ----- parallax structure
;
PARASTRUCT	rsreset
PSDESTY		rs.w	1
PSWIDTH		rs.w	1
PSHEIGHT	rs.w	1
PSSRCY		rs.w	1
PSMAPFLAG	rs.w	1
PSSPEED		rs.w	1
PSPRIORITY	rs.w	1
PSSIZE		equ	__RS

;
; -----	Character structure
;
CHARSTRUCT	rsreset
BCNUMCHARS	rs.w	1
BCCHARBITMAPS	rs.w	0


;	Animation Files:
;		UWORD	Offset to Palette
;		UWORD	Offset to Animation list
;		UWORD	Offset to Animation to Frame catalog
;		UWORD	Offset to Frame to Sprite catalog
;		UWORD	Offset to Hotspot catalog
;		UWORD	Offset to Character Definitions
;		UWORD 	flags
;				bit 0 = Scaleable sprite format
;				bit 1 = bitmap sprite format
;		???
;		Palette:
;			WORD	Color Register index
;			UWORD	Number of colors
;				UWORD	RGB Value (Sega format)
;				...
;			...Repeat...
;			-1		End of list
;		Animation list:
;			UWORD	Number of frames
;			UWORD	Offset to first Animation to Frame offset
;			...
;		Animation to Frame catalog:
;			UWORD	Offset to first Frame to Sprite structure
;			...
;		Frame to Sprite catalog:
;			UWORD	Number of sprites in frame
;			UWORD	Hotspot catalog offset
;				WORD	Y Position on screen (0..n)
;				WORD	H size, V Size, Link
;				UWORD	Priority, Palette, VFlip, HFlip, Char number
;				WORD	X Position on screen (0..n)
;			...
;		Hotspot catalog:
;			UWORD	Number of X,Y pairs
;				WORD	X Position
;				WORD	Y Position
;				...
;			...
;		???	Insert new blocks here.
;		Character Definitions:
;			UWORD	Number of characters
;			BYTE	32 Bytes per character
;
;		*****	Dependant on flags settings *****		
;		Character Definitions:
;			UBYTE	32 Bytes per character
;
;		Scaleable sprite Definitions
;			UBYTE (w * h)/2 Bytes per character
;			 format is stored in Y then X sega format.
;

ANIMHEADER	rsreset
AHPALOFFSET	rs.w	1		; offset to palette
AHALISTOFFSET	rs.w	1		; offset to animation list
AHFLISTOFFSET	rs.w	1		; offset to frame list
AHSPRITEOFFSET	rs.w	1		; offset to sprite info list
AHHOTSPOTOFFSET	rs.w	1		; offset to hotspot information
AHCHAROFFSET	rs.w	1		; offset to charoffset
AHFLAGS		rs.w	1		; flags for type of animation
AHHEADSIZE	equ	__RS

;
; ----- Animation List Structure
;
ANIMLIST	rsreset
ALNUMFRAMES	rs.w	1		; Number of frames 
ALANIMOFFSET	rs.w	1		; animation list offset

;
; -----	Animation frame structure
;
FRAMELIST	rsreset
FLSPRATTROFFSET	rs.w	1		; Sprite attribute pointer

;
; -----	Sprite Attribute structure
;
SPRITEATTRLIST	rsreset
SANUMSPRITES	rs.w	1		; Number of sprites
SAHOTOFFSET	rs.w	1		; Hot spot offset
SAHEADSIZE	equ	__RS
		rsreset
SAYPOS		rs.w	1		; y position of sprite
SAHVLINK	rs.w	1		; h size, vsize and link
SAATTRIBUTES	rs.w	1		; Priority, palette, vflip, hflip charnum
SAXPOS		rs.w	1		; x position of sprite
SASIZE		equ	__RS

;
; ----- Hot spot structure
;
HOTSPOTLIST	rsreset
HLNUMHS		rs.w	1		; number of x,y pairs
HLXPOS		rs.w	1		; x position
HLYPOS		rs.w	1		; y position


;
; -----	Sprite list structure
;
SPRLIST		rsreset
SLY		rs.w	1		; y position of sprite
SLLINK		rs.w	1		; link for sprite
SLCHR		rs.w	1		; starting character for sprite
SLX		rs.w	1		; x position of sprite
SPRLISTSIZE	equ	__RS


;
; ----- level map structure
;
MAPLEVEL	rsreset
WALLANIM 	rs.w	1		; animation # for wall
WALLFRAME	rs.w	1		; frame # for wall
SPRITELISTPTR	rs.l	1		; sprite list pointer
MOVEMENT	rs.w	1		; direction moves
MAPWAIT		rs.w	1		; wait length
FLOORANIM	rs.w	1		; floor animation #
FLOORFRAME	rs.w	1		; and frame #
MUSICNUM	rs.w	1		; music # to start
RESERVED	rs.w	1		; ??
SETUPPTR	rs.l	1		; if MOVEMENT == ENDOFLEVEL
MAPLEVELSIZE	equ	__RS		; size = 24

;
; ----- Decoration List format
;
DECOLIST	rsreset
NDECOS		rs.w	1		; # of decorations
		rsreset
XPOS		rs.w	1		; x relative to wall
YPOS		rs.w	1		; y relative to wall
BITMAPPTR	rs.l	1		; pointer to bitmap
BITMAPANIM	rs.w	1		; animation #
BITMAPFRAME	rs.w	1		; frame #
BITMAPSTORE	rs.w	1		; draw action 0 = and-or
DECOLISTSIZE	equ	__RS

;
; -----	Walls on screen list
;
WALLLIST	rsreset
STARTCHAR	rs.w	1		; starting character for sceen wall
INFOADDRESS	rs.l	1		; information for wall address
WALLLISTSIZE	equ	__RS

;
; ----- Monster lists 
;
MONSTERLIST	rsreset
MONSTERX	rs.w	1		; monsters current x position
MONSTERY	rs.w	1		; monsters current y position
MONSTERANIM	rs.w	1		; animation running currently
MONSTERFRAME	rs.w	1		; frame number
MONSTERMOVETAB	rs.l	1		; table to monster move animations
MONSTERHITTAB	rs.l	1		; table for player hit monster
MONSTERSCALE	rs.w	1		; scale factor
MONSTERFLAGS	rs.w	1		; flags for monster 
MONSTERFILEPTR	rs.l	1		; pointer to animation file
MONSTERCOUNTER	rs.w	1		; counter before updates
MONSTERTCOUNTER	rs.w	1		; temporary counter
MONSTERHP	rs.w	1		; monsters hitpoints
MONSTERAIFLAGS	rs.w	1		; ai/drawing flags
					; -----	bits ------
					; 0 = centered x
					; 1 = centered y
					; 2 = not killable 
					; 3 = hidden
					; 4 = currently looping
					; 5 = x flip
					; 6 = goody bit
					; 7 = is explosion
					; 8 = static (not scaleable)
					; 9 = first time logic change
					; 10 = priority of sprite
					; 11 = animations -> end then static
MONSTERINISCALE	rs.w	1		; orginal scale factor
MONSTERSFXPTR	rs.l	1		; sound effects pointer
MONSTERLOOPCNT	rs.w	1		; current loop counter
MONSTERLISTSIZE	equ	__RS


;
; ----- DMA queue structure
;
DMASTRUCT	rsreset
VRAMADDRESS	rs.w	1		; address in vram
VRAMLENGTH	rs.w	1		; length to dma in bytes
SRCADDR		rs.l	1		; source address
SIZEDMASTRUCT	equ	__RS

;
; ----- AI structure(s)
;
AI_PARMS	rsreset
AI_TYPE		rs.b	1		; type of ai
AI_SUBTYPE	rs.b	1		; sub type of ai
AIPARMHEADER	equ	__RS
		rs.b	6
AI_PARMS_SIZE	equ	__RS		; should be 8 for now

AIWAIT_PARMS	rsset	AIPARMHEADER
AIWAIT_LENGTH	rs.w	1		; wait length/number of monsters

AIMF_PARMS	rsset	AIPARMHEADER
AIMF_FLAGS	rs.w	1		; 0 = on floor adjust
AIMF_TOSCALE	rs.w	1		; up to scale before going on
AIMF_SCALEADD	rs.w	1		; what to add to scale facter (fixp)

AIMR_PARMS	rsset	AIPARMHEADER
AIMR_XPOS	rs.w	1		; x relative to current
AIMR_YPOS	rs.w	1		; y relative to current
AIMR_SPEED	rs.w	1		; speed of movement

AIMB_PARMS	rsset	AIPARMHEADER
AIMB_SPEED	rs.w	1		; speed to move backward
AIMB_TOSCALE	rs.w	1		; down to this scale before next AI
AIMB_SCALEADD	rs.w	1		; what to add to scale facter (fixp)

AIMA_PARMS	rsset	AIPARMHEADER
AIMA_XPOS	rs.w	1		; x relative to current
AIMA_YPOS	rs.w	1		; y relative to current
AIMA_SPEED	rs.w	1		; speed of movement

AIAT_PARMS	rsset	AIPARMHEADER
AIAT_LOOPS	rs.w	1		; number of times to attack
AIAT_TIME	rs.w	1		; or time on screen
AIAT_DAMAGE	rs.w	1		; damage to player

AIDI_PARMS	rsset	AIPARMHEADER
AIDI_HPSUB	rs.w	1		; # hit points to reduce or time
AIDI_SCORE	rs.w	1		; score for monster (BCD) format

AIGO_PARMS	rsset	AIPARMHEADER
AIGO_PTR	rs.l	1		; goto ai structure

AILP_PARMS	rsset	AIPARMHEADER
AILP_PTR	rs.l	1		; loop ai structure
AILP_CNT	rs.w	1		; loop counter

AISP_PARMS	rsset	AIPARMHEADER	; special routines structure
AISP_ROUTINE	rs.l	1		; pointer to routine to call

AISU_PARMS	rsset	AIPARMHEADER
AISU_LISTPTR	rs.l	1		; pointer to list of monsters
AISU_MAXNUM	rs.w	1

AIST_PARMS	rsset	AIPARMHEADER
AIST_TOFRAME	rs.w	1		; wait till frame #
AIST_ATSCALE	rs.w	1		; at scale
AIST_PASSES	rs.w	1		; number of passes

AIRT_TABLE	rsreset
AIRT_GOTO	rs.l	1		; goto if in bounds
AIRT_LOWBOUND	rs.l	1		; lower bounds
AIRT_HIGHBOUND	rs.l	1		; upper bounds
AIRT_SIZE	equ	__RS

AISA_PARMS	rsset	AIPARMHEADER
AISA_ANIM	rs.w	1		; animation #
AISA_FRAME	rs.w	1		; frame #

AIIF_PARMS	rsset	AIPARMHEADER
AIIF_VARNUM	rs.w	1
AIIF_GOTO	rs.l	1

AISS_PARMS	rsset	AIPARMHEADER
AISS_STRUCTOFF	rs.w	1		; structure offset
AISS_VALUE	rs.w	1		; and value


;
; ----- Sound effects structure
;
SFX_TABLE	rsreset
SFXNUMBER	rs.l	1		; sound effect to play
SFXANIM		rs.w	1		; at what animation #
SFXFRAME	rs.w	1		; and what frame #
SFXAITYPE	rs.b	1		; and ai type to match
SFXAISUBTYPE	rs.b	1		; and ai sub type also

;
; ----- Display Equates TSD
;
maxRadarPoints	equ	5


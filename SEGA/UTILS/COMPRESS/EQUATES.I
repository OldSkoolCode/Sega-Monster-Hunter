

SNASM		equ	1		; snasm vectors?
TAD		equ	0		; snasm vectors?
SEGALOGO	equ	0

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
TOPBORDCHARS	equ	2
BOTTOMBORDCHARS	equ	7
;
; ----- Pov equates
;
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
FLOORHEIGHT	equ	(48/8)
FLOORYCHAR	equ	(MAPHEIGHT-BOTTOMBORDCHARS)-FLOORHEIGHT
FLOORWIDTH	equ	(MAXPOVHEIGHT/8)
FLOORVISIBLE	equ	(VISIBLEMAPWIDTH-LEFTBORDCHARS-RIGHTBORDCHARS)
;
; -----	Character map bit definitions
;
CHARPRIORITY	equ	%1000000000000000
CHARCP1		equ	%0100000000000000
CHARCP0		equ	%0010000000000000
CHARVF		equ	%0001000000000000
CHARHF		equ	%0000100000000000

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
; ----- walking sub-routine types
;
WALKFORWARD	equ	0
WALKRIGHT	equ	1
WALKLEFT	equ	2
WALKTOCENTER	equ	3

;
; ----- AI movement types
;
DISABLED	equ	0
WALKING		equ	1
ATTACKING	equ	2
DIEING		equ	3
WAITING		equ	4
RETREATING	equ	5


;
; ----- Monster AI types
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
AI_GOTO		equ	9		; goto ai structure
;
; -----	Sub AI types for WAIT
;
AIWAIT_STATIC	equ	0		; wait static (still)
AIWAIT_ANIMATE	equ	1		; wait and animate in current position
AIWAIT_HIDDEN	equ	2		; wait hidden for timeout
AIWAIT_TILCLEAR	equ	3		; wait till no monsters
AIWAIT_FORNUM	equ	4		; wait until only xx monsters
;
; ----- Sub AI types for move forward
;
AIMF_STATIC	equ	0
AIMF_ANIMATE	equ	1
AIMF_TOPERCENT	equ	2
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
AIATT_ANIMATE	equ	0
;
; ----- Sub AI types for dieing
;
AIDIE_ANIMATE	equ	0
;
; ----- sub AI types for special
;


;
;
;
MAXNMONSTERS	equ	20
WALLSONSCREEN	equ	8			; number of walls horizontal scr
POVWALLSONSCREEN equ	5			; number of pov walls on screen
;
; -----	General equates
;
SCORESIZE	equ	6
MAXSPRITES	equ	120
MAXSTATICSPRITES equ	10

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
		rsreset
SAYPOS		rs.w	1		; y position of sprite
SAHVLINK	rs.w	1		; h size, vsize and link
SAATTRIBUTES	rs.w	1		; Priority, palette, vflip, hflip charnum
SAXPOS		rs.w	1		; x position of sprite

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
WALLPTR		rs.l	1		; pointer to wall at location
WALLANIM 	rs.w	1		; animation # for wall
WALLFRAME	rs.w	1		; frame # for wall
SPRITELISTPTR	rs.l	1		; sprite list pointer
MOVEMENT	rs.w	1		; direction moves
MAPWAIT		rs.w	1		; wait length
FLOORPTR	rs.l	1		; floor pointer
FLOORANIM	rs.w	1		; floor animation #
FLOORFRAME	rs.w	1		; and frame #
GOODIESPTR	rs.l	1		; power-ups ammuniton etc.
SETUPPTR	rs.l	1		; if MOVEMENT == ENDOFLEVEL
MAPLEVELSIZE	equ	__RS		; size = 32

; ----- Goodies List format TSD
;
GOODIELIST	rsreset
NUMGOODIES	rs.w	1		; # of goodies
		rsreset
GOOD_FLAGS	rs.w	1		; bit 0 = 0=hidden/1=visible
					; bit 1
					; bit 2 = kind 0=none/1=powerup/
					;              2=ammunition
GOOD_XPOS	rs.w	1		; X offset from wall section
GOOD_YPOS	rs.w	1		; Y offset from wall section
GOOD_BMPTR	rs.l	1		; pointer to bitmap
GOOD_BMANIM	rs.w	1		; animation #
GOOD_BMFRAME	rs.w	1		; frame #
GOOD_AMOUNT	rs.w	1		; health add to health, if
					; ammunition, add to clip

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
MONSTERTABLE	rs.l	1		; table to monster animations
MONSTERSCALE	rs.w	1		; scale factor
MONSTERFLAGS	rs.w	1		; flags for monster
					;
MONSTERAIPTR	rs.l	1		; routine for AI
MONSTERCOUNTER	rs.w	1		; counter before updates
MONSTERTCOUNTER	rs.w	1		; temporary counter
MONSTERAISUB	rs.w	1		; ai sub-routine type
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
AIMF_SPEED	rs.w	1		; speed of forward momentum
AIMF_TOSCALE	rs.w	1		; up to scale before going on

AIMR_PARMS	rsset	AIPARMHEADER
AIMR_XPOS	rs.w	1		; x relative to current
AIMR_YPOS	rs.w	1		; y relative to current
AIMR_SPEED	rs.w	1		; speed of movement

AIMB_PARMS	rsset	AIPARMHEADER
AIMB_SPEED	rs.w	1		; speed to move backward
AIMB_TOSCALE	rs.w	1		; down to this scale before next AI

AIMA_PARMS	rsset	AIPARMHEADER
AIMA_XPOS	rs.w	1		; x relative to current
AIMA_YPOS	rs.w	1		; y relative to current
AIMA_SPEED	rs.w	1		; speed of movement

AIAT_PARMS	rsset	AIPARMHEADER
AIAT_LOOPS	rs.w	1		; number of times to attack
AIAT_TIME	rs.w	1		; or time on screen

AIDI_PARMS	rsset	AIPARMHEADER
AIDI_TIME	rs.w	1		; or time on screen

AIGO_PARMS	rsset	AIPARMHEADER
AIGO_PTR	rs.l	1		; goto ai structure

AISP_PARMS	rsset	AIPARMHEADER	; special routines structure
AISP_ROUTINE	rs.l	1		; pointer to routine to call

;
; ----- Display Equates TSD
;
maxRadarPoints	equ	12


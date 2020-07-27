

SNASM		equ	0		; snasm vectors?

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

DATA1		equ	$A10003
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
HScroll		set	54*1024	;1K boundary
SpriteAttr	set	55*1024	;1K boundary in 40CELL (1/2K in 32CELL)
ScrollA		set	56*1024	;8K boundary
Window		set	56*1024	;4K boundary in 40CELL (2K in 32CELL)
ScrollB		set	56*1024	;8K boundary

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
; -----	bits for joysticks
;
UPBUTTON	equ	0
DNBUTTON	equ	1
LFBUTTON	equ	2
RTBUTTON	equ	3
B_BUTTON	equ	4
C_BUTTON	equ	5
A_BUTTON	equ	6
START_BUTTON	equ	7

;
; ----- Screen map width & height
;
MAPWIDTH	equ	64
MAPHEIGHT	equ	32
SCOREHCHARS	equ	2
VISIBLEMAPWIDTH	equ	40
SCREENWIDTH	equ	320
VISIBLEWIDTH	equ	40
VISIBLEHEIGHT	equ	28

;
;
;
CENTERMAPX	equ	160
CENTERMAPY	equ	112
;
;
LOGOXPOS	equ	157
LOGOYPOS	equ	109
;
MAXENEMIES	equ	10
;
; ----- obstacle map #
;
FLOOROBSTACLE	equ	1
WALLOBSTACLE	equ	1
RIGHTSTAIRDOWN	equ	2
LEFTSTAIRDOWN	equ	3
STAIROBSTACLE	equ	4
LEFTSTAIRUP	equ	5
RIGHTSTAIRUP	equ	6


;
;
;
; -----	Character map bit definitions
;
CHARPRIORITY	equ	%1000000000000000
CHARCP1		equ	%0100000000000000
CHARCP0		equ	%0010000000000000
CHARVF		equ	%0001000000000000
CHARHF		equ	%0000100000000000

CHARPRIORITYBIT	equ	15
CHARVFBIT	equ	12
CHARHFBIT	equ	11
USERDISABLED	equ	%0000000000000001
USERONSTAIRS	equ	%0000000000000010


;
; ----- Dma queue equates
;
MAXDMAQUEUE	equ	20			; 20 per frame
MAXDMAXFERAFRAME equ	6*1024			; 6k per frame

;
; ----- AI movement types
;
DISABLED	equ	0
FADEIN		equ	1
WALKING		equ	2
RUNNING		equ	3
DIEING		equ	4
WAITING		equ	5
FALLING		equ	6
JUMPING		equ	7
ATTACKING	equ	8
CLIMBUP		equ	9
CLIMBDOWN	equ	10


;
;
;
MAXNMONSTERS	equ	20
;
; -----	General equates
;
SCORESIZE	equ	6
MAXSPRITES	equ	120
MAXSTATICSPRITES equ	10

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
; -----	Player Structure
;
PLAYER		rsreset
PLRXPOS		rs.w	1		; x position
PLRYPOS		rs.w	1		; y position
PLRMOVEMENT	rs.w	1		; current movement (anim)
PLRFRAME	rs.w	1		; current frame in animation
PLRCOUNTER	rs.w	1		; counter for changes
PLRFLAGS	rs.w	1		; bit 11 = 0 = right
					; 	   1 = left
					; bit 0 = hit stairs or not
PLRFILEPTR	rs.l	1		; file pointer
PLAYERSIZE	equ	__RS

;
; -----	Enemy Structure
;
ENEMY		rsreset
ENMYXPOS	rs.w	1		; x position
ENMYYPOS	rs.w	1		; y position
ENMYMOVEMENT	rs.w	1		; current movement (anim)
ENMYFRAME	rs.w	1		; current frame in animation
ENMYCOUNTER	rs.w	1		; counter for changes
ENMYFLAGS	rs.w	1		; bit 11 = 0 = right
					; 	   1 = left
ENMYFILEPTR	rs.l	1		; file pointer
ENMYAIPTR	rs.l	1		; ai routine
ENEMYSIZE	equ	__RS


;
; ----- DMA queue structure
;
DMASTRUCT	rsreset
VRAMADDRESS	rs.w	1		; address in vram
VRAMLENGTH	rs.w	1		; length to dma in bytes
SRCADDR		rs.l	1		; source address
SIZEDMASTRUCT	equ	__RS


; Service equates
; $Log: scaler.i_v $
;Revision 1.6  1993/06/14  20:25:19  KENH
;*** empty log message ***
;
;Revision 1.5  1993/06/07  19:57:48  KENH
;*** empty log message ***
;
;Revision 1.4  1993/06/07  19:57:31  KENH
;*** empty log message ***
;
;Revision 1.3  1993/05/13  23:09:19  KENH
;*** empty log message ***
;
;Revision 1.2  1993/04/29  13:50:15  KENH
;*** empty log message ***
;
;Revision 1.1  1993/04/29  13:50:10  KENH
;Initial revision
;

	rsreset
SSC_Init	rs.b	1
SSC_Convert	rs.b	1
SSC_MakeGrid	rs.b	1
SSC_Scale	rs.b	1
SSC_Resume	rs.b	1

	rsreset
; These are the interface variables see interface documentation for
; information on these variables
SrcWidth	rs.w	1
SrcHeight	rs.w	1
SrcXPos	rs.w	1
SrcYPos	rs.w	1
SrcXSize	rs.w	1
SrcYSize	rs.w	1
DestWidth	rs.w	1
DestHeight	rs.w	1
DestXSize	rs.w	1
DestYSize	rs.w	1
FillAction	rs.w	1
OutputType	rs.w	1
SrcDataPtr	rs.l	1
DestDataPtr	rs.l	1
; Flip variables
XFlip	rs.b	1
YFlip	rs.b	1
DFlip	rs.b	1
; Autoconvert variables
AutoConvert	rs.b	1
; Autosend variables
AutoSend	rs.b	1
VRAMAddr	rs.w	1
DMARoutine	rs.l	1
DMAOn	rs.w	1
DMAOff	rs.w	1
; Multi-Pass variables
LinesPerRun	rs.w	1
; Trapezium variables
DestIsRect	rs.b	1
DestXSize1	rs.w	1
DestXSize2	rs.w	1
DestXPos1	rs.w	1
DestXPos2	rs.w	1

; These are the scalers internal scratch variables
LinesThisRun	rs.w	1	; How many lines to do this run
StopRegs	rs.l	14	; d0-d7/a0-a5
StopPC	rs.l	1	; address for Resume
SrcBytes	rs.w	1	; Bytes across of source data
XAddChange	rs.w	1	; How many lines until XAdd changes
LinesLeft	rs.w	1	; How many destination lines left
LinesDone	rs.w	1	; Lines scaled in this block
DMAWord	rs.w	1	; Last word to trigger DMA
DMADest	rs.w	1	; Dest for DMA
FillXQty	rs.w	1	; Used when FillAction=2
FillYQty	rs.w	1	; Used when FillAction=2
TempSrcPtr	rs.l	1
TempDestPtr	rs.l	1
TrapLPos	rs.l	1
TrapLDelta	rs.l	1
TrapRPos	rs.l	1
TrapRDelta	rs.l	1
OldOutputType	rs.w	1	; \
OldDestHeight	rs.w	1	;  |
OldDestWidth	rs.w	1	;  | - Optimisation
Old4Tab	rs.w	1 ; only a byte	;  |
OldXChange	rs.w	1	; /
XAddSrc	rs.w	320
YAddSrc	rs.w	320
XAddDest	rs.w	320
XAddDest2	rs.w	320
YAddDest	rs.w	200
SrcBuffer	rs.b	320	; used by autoconvert
SizeOf_ScaleVars equ	__RS




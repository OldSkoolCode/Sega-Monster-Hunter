*
* Patch Offset Table
*

	dc.b	$1C,$00		; Offset to patch #0: 28
	dc.b	$43,$00		; Offset to patch #1: 67
	dc.b	$6A,$00		; Offset to patch #2: 106
	dc.b	$91,$00		; Offset to patch #3: 145
	dc.b	$B8,$00		; Offset to patch #4: 184
	dc.b	$DF,$00		; Offset to patch #5: 223
	dc.b	$06,$01		; Offset to patch #6: 262
	dc.b	$2D,$01		; Offset to patch #7: 301
	dc.b	$54,$01		; Offset to patch #8: 340
	dc.b	$7B,$01		; Offset to patch #9: 379
	dc.b	$7D,$01		; Offset to patch #10: 381
	dc.b	$84,$01		; Offset to patch #11: 388
	dc.b	$AB,$01		; Offset to patch #12: 427
	dc.b	$D2,$01		; Offset to patch #13: 466
*
* Patch Data
*

* Patch 0 "kickdrum.fm": FM
	dc.b	0
	dc.b	$0A,$00,$22,$C0,$00,$14,$1F,$18
	dc.b	$09,$0F,$00,$14,$1F,$9F,$0D,$08
	dc.b	$00,$00,$1F,$15,$1F,$20,$00,$00
	dc.b	$1F,$13,$1F,$D2,$1F,$FF,$1F,$FF
	dc.b	$1F,$FF,$1F,$FF,$0D,$00
* Patch 1 "defsnare.fm": FM
	dc.b	0
	dc.b	$00,$00,$34,$C0,$01,$02,$1F,$00
	dc.b	$08,$00,$00,$04,$1F,$13,$14,$08
	dc.b	$02,$00,$1F,$0F,$1F,$F8,$01,$00
	dc.b	$1F,$13,$1F,$FA,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$0F,$00
* Patch 2 "bass.fm": FM
	dc.b	0
	dc.b	$02,$00,$04,$C0,$30,$16,$1A,$0F
	dc.b	$09,$21,$70,$16,$1A,$0F,$09,$21
	dc.b	$30,$00,$1F,$08,$09,$29,$70,$00
	dc.b	$1F,$08,$09,$29,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$0F,$00
* Patch 3 "guitar.fm": FM
	dc.b	0
	dc.b	$02,$00,$3B,$C0,$30,$18,$1F,$0E
	dc.b	$09,$21,$70,$05,$1F,$0F,$09,$21
	dc.b	$30,$00,$1F,$08,$09,$29,$70,$00
	dc.b	$1F,$08,$09,$29,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$0F,$00
* Patch 4 "organ.fm": FM
	dc.b	0
	dc.b	$08,$00,$17,$E4,$33,$0C,$5F,$8B
	dc.b	$01,$8B,$33,$0F,$1D,$9D,$00,$3A
	dc.b	$71,$11,$1F,$1F,$00,$3A,$71,$0F
	dc.b	$5B,$9C,$00,$3A,$1F,$FF,$1F,$FF
	dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 5 "bass2.fm": FM
	dc.b	0
	dc.b	$00,$00,$25,$D3,$00,$13,$1F,$00
	dc.b	$00,$05,$00,$04,$1F,$1F,$0C,$08
	dc.b	$00,$11,$1F,$11,$10,$28,$00,$00
	dc.b	$1E,$11,$13,$2B,$1F,$FF,$1F,$FF
	dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 6 "sax.fm": FM
	dc.b	0
	dc.b	$08,$00,$22,$D0,$50,$0F,$0E,$00
	dc.b	$00,$08,$00,$14,$11,$80,$00,$08
	dc.b	$37,$28,$0E,$00,$00,$20,$30,$00
	dc.b	$10,$00,$00,$09,$1F,$FF,$1F,$FF
	dc.b	$1F,$FF,$1F,$FF,$0F,$00
* Patch 7 "synthstr.fm": FM
	dc.b	0
	dc.b	$00,$00,$2C,$C2,$21,$0A,$57,$0C
	dc.b	$00,$00,$31,$08,$55,$0C,$00,$00
	dc.b	$53,$00,$48,$1F,$00,$05,$03,$00
	dc.b	$49,$1F,$00,$05,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$0F,$00
* Patch 8 "hihat.fm": FM
	dc.b	0
	dc.b	$00,$00,$02,$C0,$0D,$00,$14,$0A
	dc.b	$1C,$54,$0D,$00,$1D,$13,$1D,$A1
	dc.b	$0F,$00,$1F,$0D,$15,$66,$0F,$00
	dc.b	$1D,$13,$1D,$A8,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$0D,$00
* Patch 9 "Game Samples": DIG
	dc.b	1
	dc.b	$04
* Patch 10 "Tandy Piano.PSG": PSG Tone
	dc.b	2
	dc.b	$0A,$FF,$26,$D3,$0B,$04
* Patch 11 "Timpani": FM
	dc.b	0
	dc.b	$07,$09,$3B,$C8,$05,$28,$1F,$14
	dc.b	$03,$85,$01,$19,$1D,$02,$0D,$26
	dc.b	$01,$1E,$1F,$00,$05,$D4,$00,$00
	dc.b	$1F,$0D,$0D,$F6,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$0F,$00
* Patch 12 "Electric Piano": FM
	dc.b	0
	dc.b	$00,$00,$3D,$D1,$0E,$2D,$1C,$0F
	dc.b	$0A,$AB,$3E,$14,$1C,$0F,$0A,$A6
	dc.b	$01,$14,$1D,$06,$06,$A9,$71,$00
	dc.b	$1D,$06,$0E,$A6,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$0C,$00
* Patch 13 "Flame Thrower": FM
	dc.b	0
	dc.b	$00,$00,$3A,$C0,$01,$00,$09,$00
	dc.b	$0B,$06,$00,$00,$0B,$00,$0C,$06
	dc.b	$00,$00,$1F,$00,$0A,$06,$00,$00
	dc.b	$1F,$00,$00,$06,$00,$00,$00,$00
	dc.b	$00,$00,$00,$00,$0F,$00

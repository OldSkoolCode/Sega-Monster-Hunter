*
* Modulator Offset Table
*

	dc.b	$02,$00		; Offset to modulator #0: 2
*
* Modulator Data
*

* Modulator 0 "bend down fast": Pitch
	dc.b	$03,$00			; initial value = 3
	dc.b	$18,$CE,$FF		; len = 24, slope = -50
	dc.b	0

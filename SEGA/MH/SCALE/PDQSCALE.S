
;{----------------------------------------------------------------------}
;{ Function:	_PDQS_Scale(UWORD *anm_file, UWORD anm, UWORD frm,	}
;{				WORD xp, WORD yp, UWORD sf);		}
;{ Description:	Scale a bitmap into a buffer				}
;{ Parameters:	anm_file = pointer animation data (FPA scale format)	}
;{		anm = animation # in file				}
;{		frm = frame # in file					}
;{		xp = x screen position					}
;{		yp = y screen position					}
;{		sf = scale factor 					}
;{		(256 is 1:1, 1 is the smallest 65535 is the largest)	}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
_PDQS_Scale:

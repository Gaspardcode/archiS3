				org 		$4
vector_001		dc.l		Main
				org			$550

Main			;movea.l		#SO,a0
				;jsr			StrLen
				;jsr			IsMaxError
				
				movea.l		#SN,a0
				jsr			StrLen
				jsr			IsMaxError
				
				illegal
				
StrLen			clr.l 		d0
				move.l 		a0,-(a7)
\loop			tst.b		(a0)+
				beq			\quit
				addq.w		#1,d0
				bra			\loop
				
\quit			movea		(a7)+,a0

IsMaxError		movem		a0-d1,-(a7)
				movea		#E,a1
				
\loop			move.b		(a1)+,d1
				move.b		(a0)+,d0
				beq			\no_error
				cmp			d1,d0
				bhi			\error
				blo			\no_error
				bra			\loop

\no_error		andi.b		#%11111011,ccr	;false
				movem		(a7)+,a0-d1
				rts

\error			ori.b		#%00000100,ccr ;true
				movem		(a7)+,a0-d1
				rts

SO				dc.b		"12345",0
SN				dc.b		"345678",0
E				dc.b		"32767",0

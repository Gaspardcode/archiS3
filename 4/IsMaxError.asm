				org 		$4
vector_001		dc.l		Main
				org			$550
				
;				org			$4
;vector_001		dc.l		Main
;				org			$550

Main			movea.l		#SO,a0
				;jsr		StrLen
				jsr			ISM2
				
				movea.l		#SN,a0
				;jsr 		StrLen
				jsr			ISM2
				
				movea.l		#F,a0
				jsr			StrLen
				jsr			IsMaxError
				
				illegal

StrLen			clr.l 		d0
				move.l 		a0,-(a7)
\loop			tst.b		(a0)+
				beq			\quit
				addq.w		#1,d0
				bra			\loop
				
\quit			movea.l		(a7)+,a0

IsMaxError		movem.l		a0/a1/d0/d1,-(a7)
				movea.l		#E,a1
				
\loop			move.b		(a1)+,d1
				move.b		(a0)+,d0
				beq			\no_error
				cmp			d1,d0
				bhi			\error
				blo			\no_error
				bra			\loop ; d0 vaut d1

\no_error		movem.l		(a7)+,a0/a1/d0/d1
				andi.b		#%11111011,ccr ; false
				rts

\error			movem.l		(a7)+,a0/a1/d0/d1
				ori.b		#%00000100,ccr ;true
				rts
				
ISM2			clr.l		d0
				movem.l		a0/a1/d0,-(a7)
				movea.l		#E,a1

\loop			cmpi		#5,d0
				bhi			\error
				
				cmpm.b		(a1)+,(a0)+
				bhi			\error
				blo			\no_error
				
				addq		#1,d0
				bra			\loop

\error			movem.l		(a7)+,a0/a1/d0
				ori.b		#%00000100,ccr ; true
				rts

\no_error		movem.l		(a7)+,a0/a1/d0
				andi.b		#%11111011,ccr ; false
				rts

SO				dc.b		"12345",0
SN				dc.b		"345678",0
E				dc.b		"32767",0
F				dc.b		"32768",0
;G				dc.b		"327678",0

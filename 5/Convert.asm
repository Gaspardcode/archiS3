				org 		$4
vector_001		dc.l		Main
				org			$550
				
Main			movea.l		#SO,a0
				jsr			Convert
				illegal

Convert			tst.b		(a0)
				beq			\error
				jsr			IsDigit
				beq			\error
				jsr			IsMaxError
				beq			\error
				jsr 		Atoui
				bra			\quit

\quit			ori.b		#%00000100,ccr
				rts

\error			andi.b 		#%11111011,ccr
				rts
				
IsDigit			movem.l	a0/d0,-(a7)

\loop			move.b	(a0)+,d0
				beq		\error
				
				cmpi	#'0',d0
				blo		\loop
				
				cmpi	#'9',d0
				bhi		\loop
				
				bra		\no_error
				
\no_error		movem.l (a7)+,a0/d0
				andi.b	#%11111011,ccr
				rts
				
\error			movem.l	(a7)+,a0/d0
				ori.b	#%00000100,ccr
				rts

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

Atoui			movem.l		a0/d1,-(a7)

\loop			move.b		(a0)+,d1
				beq			\quit
				
				subi.b		#'0',d1
				mulu.w		#$0010,d0
				add.l		d1,d0
				bra			\loop
				
\quit			movem.l		(a7)+,a0/d1
				rts

SO				dc.b		"12345",0
SN				dc.b		"notval1d",0
E				dc.b		"32767",0

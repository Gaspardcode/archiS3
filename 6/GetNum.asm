				org 		$4
vector_001	 	dc.l 		Main
				org 		$550
				
Main			movea.l		#S,a0
				jsr			GetNum
				illegal

GetNum			movem.l		a0/a1/a2/d1/d2,-(a7)
				movea.l		a0,a1
				jsr 		NextOp
				move.b		(a0),d2
				movea.l		a0,a2
				move.b 		#0,(a0)
				movea.l		a1,a0
				jsr 		Convert
				beq			\error
	
				move.b		d2,(a2)
				bra 		\quit
				
\quit 			movea.l		a2,a0
				movem.l 	(a7)+,d1/d2
				movea.l		(a7)+,a2
				movem.l 	(a7)+,a1/a2
				rts
\error			movem.l 	(a7)+,a0/a1/a2/d1/d2
				andi.b 		#%11111011,ccr
				rts

NextOp			move.l		d0,-(a7)

\loop			move.b		(a0)+,d0
				beq			\quit
				
				cmpi		#'+',d0
				beq			\quit
				
				cmpi		#'-',d0
				beq			\quit
				
				cmpi		#'*',d0
				beq			\quit
				
			;	cmpi		#'/',d0
			;	beq			\quit
				bra			\loop

\quit			move.l		(a7)+,d0
				tst.b		-(a0)
				rts

Convert			tst.b		(a0)
				beq			\error
				jsr			IsDigit
				beq			\error
				jsr			IsMaxError
				beq			\error
				clr.l		d0
				jsr 		Atoui
				bra			\quit

\quit			andi.b 		#%11111011,ccr
				rts

\error			ori.b		#%00000100,ccr
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

E				dc.b		"32767",0
S				dc.b	 	"104+9*2-30",0
SN				dc.b		"5r",0

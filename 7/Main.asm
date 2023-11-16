				org 	$0
vector_000 		dc.l 	$ffb500
vector_001 		dc.l	Main
 
 				org 	$500
Main 			
				clr.b 	d1
				clr.b 	d2
				move.l #60000,d3
				move.l #8000,d4
				
				lea		P1,a0
				jsr 	Print
				add.l	#1,d2
				
				movea.l #sBuffer,a0
				jsr 	GetInput
				add.l	#1,d2
				
				move.l	a0,-(a7)
				lea		P2,a0
				jsr		Print
				add.l	#1,d2
				movea.l (a7)+,a0
				jsr		GetExpr
				jsr		Itoa
				jsr		Print
				
				illegal
				
GetInput 		incbin "GetInput.bin"

Print			movem.l		d0/d1/d2/a0,-(a7)

\loop			move.b		(a0)+,d0
				beq			\quit
				addq		#1,d1
				jsr			PrintChar
				bra			\loop

\quit			movem.l		(a7)+,d0/d1/d2/a0
				rts

PrintChar		incbin		"PrintChar.bin"

Itoa			tst.l	d0
				bmi		\negatif
				;else
				jsr		Uitoa
				bra		\quit

\negatif		move.b	#'-',(a0)+
				muls.l	#-1,d0
				jsr 	Uitoa
				tst.b	-(a0)
				bra		\quit

\quit			rts

Uitoa				movem.l			d0/a1/a0,-(a7)
					movea.l			a0,a1
					move.b			#0,-(a7)
\pre_loop			tst.b			d0
					beq				\loop

					divu.w			#10,d0			
					swap.w			d0
					move.b			d0,-(a7)
					add.b			#'0',(a7)
					swap.w			d0
					andi.l			#$0000FFFF,d0
					bra				\pre_loop

\loop				move.b			(a7)+,(a0)+
					beq				\quit
					bra				\loop

\quit				movea.l			a1,a0
					movem.l			(a7)+,d0/a1/a0
					rts

GetExpr			movem.l		a0/a1/a2/d1/d2,-(a7)
				jsr			GetNum
				move.l		d0,d1
				move.b		(a0)+,d2
				bra			\loop

\loop			clr.l		d0
				jsr			GetNum
				bne			\error
				
				cmpi		#'+',d2
				beq			\plus
				
				cmpi		#'-',d2
				beq			\minus
				
				cmpi		#'*',d2
				beq			\times
				
				cmpi 		#'/',d2
				beq 		\divide
				
				bra			\quit

\plus			add.l		d0,d1
				move.b		(a0)+,d2
				beq			\quit
				bra			\loop
				
\minus			sub.l		d0,d1
				move.b		(a0)+,d2
				beq			\quit
				bra			\loop

\times			mulu.l		d0,d1
				move.b		(a0)+,d2
				beq			\quit
				bra			\loop
				
\divide 		tst.b		d0
				beq			\error
				divs.w		d0,d1
				andi.l		#$0000FFFF,d1
				move.b		(a0)+,d2
				beq			\quit
				bra			\loop
				
\error			movem.l 	(a7)+,a0/a1/a2/d1/d2
				andi.b 		#%11111011,ccr
				rts

\quit			move.l		d1,d0
				movem.l 	(a7)+,a0/a1/a2/d1/d2
				ori.b		#%00000100,ccr
				rts
				
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
				ori.b		#%00000100,ccr
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
				
				cmpi		#'/',d0
				beq			\quit
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

IsMaxError		clr.l		d0
				movem.l		a0/a1/a2/d0,-(a7)
				movea.l		#E,a1
				movea.l		a0,a2

\pre_loop		cmpi		#5,d0
				bhi			\error
				tst.b		(a2)+
				beq	 		\no_error
				addq		#1,d0
				bra			\pre_loop
				
				clr.l		d0
\loop			cmpi		#5,d0
				beq			\no_error
				
				cmpm.b		(a1)+,(a0)+
				bhi			\error
				blo			\no_error
				
				addq		#1,d0
				bra			\loop

\error			movem.l		(a7)+,a0/a1/a2/d0
				ori.b		#%00000100,ccr ; true
				rts

\no_error		movem.l		(a7)+,a0/a1/a2/d0
				andi.b		#%11111011,ccr ; false
				rts

Atoui			movem.l		a0/d1,-(a7)
				clr.l		d1

\loop			move.b		(a0)+,d1
				beq			\quit
				
				subi.b		#'0',d1
				mulu.w		#$000A,d0
				add.l		d1,d0
				bra			\loop
				
\quit			movem.l		(a7)+,a0/d1
				movea.l		a2,a0
				rts

sBuffer 		ds.b 		60
E				dc.b		"32767",0
SN				dc.b		"Erreur",0
S				dc.b		"104+9*2-3",0
S1				dc.b		"104+2+5-113/0",0
P1				dc.b		"Veuillez saisir une expression :",0
P2				dc.b		"Resultat :",0

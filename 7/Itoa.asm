; ==============================
; Initialisation des vecteurs
; ==============================
				org 	$4
vector_001 		dc.l	Main
; ==============================
; Programme principal
; ==============================
				org 	$550
Main 			movea.l #sBuffer,a0
				move.l	#-10234,d0
				jsr		Itoa
				illegal
				
				
; ==============================
; Sous-programmes
; ==============================

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
					
sBuffer 		ds.b 	60

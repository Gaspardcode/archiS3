					org				$4
vextor_001			dc.l			Main
					org 			$550

Main				move.l			#12345,d0
					jsr				Uitoa
					illegal

Uitoa				movea.l			a0,a1
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
					rts

;S					dc.b		"12334",0

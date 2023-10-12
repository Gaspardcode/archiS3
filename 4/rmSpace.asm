				org		$4
vector_001		dc.l	Main
				org		$550

Main			movea.l #S,a0
				jsr		RemoveSpace
				illegal

RemoveSpace		movea  a0,a1		

\loop			move.b	(a0)+,d0
				beq		\quit
				
				cmpi.b	#' ',d0
				beq		\loop
				
				move.b	d0,(a1)+
				bra		\loop
				
\quit			move.b	d0,(a1)
				rts

S				dc.b	" 5     +     12    ",0

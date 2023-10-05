			org		$4
Vector_001	dc.l	Main

			org		$500

Main		movea.l	#STRING,a0

SpaceCount	clr.l	d0
loop		move.b	(a0)+,d1
			;tst.b	d1
			beq		quit
			
			sub.b 	#' ',d1
			;tst.b	d1
			bne		loop
			
			addq.l #1,d0	
			jmp		loop

quit		illegal

STRING		dc.b	"Cette chaine comporte 4 espaces.",0

			org		$4
Vector_001	dc.L	Main

			org 	$500

Main	movea.l #STRING,a0
loop	tst.b	(a0)+
		bne		loop
		move.l	a0,d0
		sub.l	#STRING,d0
		sub.l 	#1,d0
		bra		quit
		
		
quit	illegal

		org 	$550
		
STRING	dc.b 	"Cette chaine comporte 36 caracteres.",0

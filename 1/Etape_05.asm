			org		$4
Vector_001	dc.l	Main

			org		$500

Main		move.b 	N1,d0 ; adding bytes
			add.b	N2,d0
			move.b 	d0,SUM
			
			move.w 	#$B4,d1 ; adding words
			add.w	#$4C,d1
			
			move.l 	#$4AC9,d2 ; adding longs
			add.l	#$D841,d2
			
			illegal
			
			org 	$550
			
N1			dc.b	$B4
N2			dc.b	$4C
SUM			ds.b	1

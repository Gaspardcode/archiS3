			org		$4
Vector_001	dc.l	Main
			org 	$500
			
Main		move.w N1,d0 ; N1 -> DO.W
			add.w N2,d0
			move.w d0,SUM
			
			illegal
			
			org 	$550

N1 			dc.w	$2222
N2 			dc.w	$5555
SUM 		ds.w	1

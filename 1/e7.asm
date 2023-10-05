				org 	$4
Vector_001		dc.l	Main
				org 	$50
				
Main			move.l #1,d0
				move.l #1,d1
				move.l #1,d2
				move.l #1,d4
				add.l	d4,d0
				addx.l	d5,d1
				addx.l	d6,d2
				addx.l	d7,d3
				illegal

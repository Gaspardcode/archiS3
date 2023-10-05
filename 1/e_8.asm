				org 	$4
Vector_001		dc.l	Main
				org 	$50
				
Main			move.l #$76543210,d1
				ror.w  #4,d1
				ror.b	#4,d1
				rol.w	#4,d1
				jmp		M1
M1				move.l #$76543210,d1
				rol.l	#8,d1
				rol.l	#4,d1
				ror.b	#4,d1
				ror.l	#8,d1
				ror.l	#4,d1
				rol.w  #4,d1
				ror.b	#4,d1
				ror.w	#4,d1
				illegal

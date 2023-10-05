				org 		$4
Vector_001 		dc.l 		Main
				org 		$500
Main 			move.l		#-18,d0 ; Initialise D0.
Abs 			bmi			negate
				bra			quit; ... ; Programme Abs à développer.
negate			muls.l		#-1,d0
				bra			quit
quit			illegal

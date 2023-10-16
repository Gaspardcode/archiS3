				org			$4
vector_001		dc.l		Main
				org			$550
				
Main			lea			S,a0
				jsr			NextOp
				illegal

NextOp			move.l		d0,-(a7)

\loop			move.b		(a0)+,d0
				beq			\quit
				
				cmpi		#'+',d0
				beq			\quit
				
				cmpi		#'-',d0
				beq			\quit
				
				cmpi		#'*',d0
				beq			\quit
				
			;	cmpi		#'/',d0
			;	beq			\quit
				bra			\loop

\quit			move.l		(a7)+,d0
				tst.b		-(a0)
				rts

S				dc.b		"Test + chain",0

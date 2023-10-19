				org 		$0
vector_000		dc.l		$ffb500
vector_001		dc.l		Main
				org 		$500
				
Main			lea			T,a0
				move.b		#24,d1 ;column ; max = 60
				move.b		#20,d2
				jsr			Print
				illegal
				
Print			movem.l		d0/d1/d2/a0,-(a7)

\loop			move.b		(a0)+,d0
				beq			\quit
				addq		#1,d1
				jsr			PrintChar
				bra			\loop

\quit			movem.l		(a7)+,d0/d1/d2/a0
				rts

PrintChar		incbin		"PrintChar.bin"
S				dc.b		"Test chain",0
T				dc.b		"Long phrase meant to go out of the screen",0

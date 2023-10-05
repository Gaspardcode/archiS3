				org			$4
vector_001		dc.l		Main

				org			$500
				
Main			movea.l		#string1,a0
				jsr			Atoui
				
Atoui			movem.l		a0/d1,-(a7)

\loop			move.b		(a0)+,d1
				beq			\quit
				
				subi.b		#'0',d1
				mulu.w		#$0010,d0
				add.l		d1,d0
				bra			\loop
				
\quit			movem.l		(a7)+,a0/d1
				rts

string1			dc.b		"134567890",0

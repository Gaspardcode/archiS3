			org		$4
vector_001	dc.l	Main

			org		$500
			
Main		movea.l		#String1,a0
			jsr			LowerCount
			
			movea.l		#String2,a0
			jsr			LowerCount
			
			illegal
			
LowerCount	movem.l		d1/a0,-(a7)
			
\loop		move.b		(a0)+,d1

			tst.b		d1
			beq			\quit
			
			cmpi		#'a',d1
			blo			\loop
			
			cmpi		#'z',d1
			bhi			\loop
			
			addq		#1,d0
			bra			\loop

\quit		movem.l		(a7)+,d1/a0
			rts

String1		dc.b	"Cette chaine comporte 28 minuscules.",0
String2		dc.b	"Celle-ci en comporte 16.",0

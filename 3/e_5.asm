					org		$4
vector_001			dc.l	Main

					org		$500
					
Main				movea.l #String1,a0
					jsr		AlphaCount
					
					movea.l	#String2,a0
					jsr		AlphaCount
					
					illegal
					
LowerCount			movem.l		d1/a0,-(a7)
			
\loop				move.b		(a0)+,d1

					tst.b		d1
					beq			\quit
			
					cmpi		#'a',d1
					blo			\loop
			
					cmpi		#'z',d1
					bhi			\loop
			
					addq		#1,d0
					bra			\loop

\quit				movem.l		(a7)+,d1/a0
					rts

UpperCount			movem.l		d1/a0,-(a7)

\loop				move.b		(a0)+,d1
					beq			\quit
					
					cmpi		#'A',d1
					blo			\loop

					cmpi		#'Z',d1
					bhi			\loop
					
					addq.l		#1,d2
					bra			\loop
	
\quit				movem.l		(a7)+,d1/a0
					rts

DigitCount			movem.l		d1/a0,-(a7)

\loop				move.b		(a0)+,d1
					beq			\quit
					
					cmpi		#'0',d1
					blo			\loop
					
					cmpi		#'9',d1
					bhi			\loop
					
					addq.l		#1,d3
					bra			\loop

\quit				movem.l		(a7)+,d1/a0
					rts

AlphaCount			clr.l		d0
					movem.l 	d1-d3,-(a7)
					jsr			LowerCount
					jsr			UpperCount
					jsr			DigitCount
					add.l		d2,d0
					add.l		d3,d0
					movem.l		(a7)+,d1-d3
					

String1				dc.b	"Cette chaine comporte 46 caracteres alphanumeriques.",0
String2				dc.b	"Celle-ci en comporte 19.",0

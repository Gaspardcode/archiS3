				org			$4
vector_001		dc.l		Main

				org			$550

Main			movea.l		#SO,a0
				jsr			IsCharError
				
				movea.l		#SN,a0
				jsr			IsCharError
				illegal		
				
IsCharError		

\loop			move.b	(a0)+,d0
				beq		\no_error
				
				cmpi	#'0',d0
				blo		\error
				
				cmpi	#'9',d0
				bhi		\error
				
				bra		\loop
				
\no_error		andi.b	#%11111011,ccr
				rts
				
\error			ori.b	#%00000100,ccr
				rts

SN				dc.b		"chaine not OK",0
SO				dc.b		"0123456789",0

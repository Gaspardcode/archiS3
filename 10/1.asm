; ==============================
; Définition des constantes
; ==============================
; Mémoire vidéo
; ------------------------------
VIDEO_START 		equ 		$ffb500 ; Adresse de départ
VIDEO_WIDTH 		equ 		480 ; Largeur en pixels
VIDEO_HEIGHT		equ 		320 ; Hauteur en pixels
VIDEO_SIZE 			equ 		(VIDEO_WIDTH*VIDEO_HEIGHT/8) ; Taille en octets
BYTE_PER_LINE 		equ 		(VIDEO_WIDTH/8) ; Nombre d'octets par ligne
; ==============================
; Initialisation des vecteurs
; ==============================
					org 		$0
vector_000 			dc.l 		VIDEO_START ; Valeur initiale de A7
vector_001 			dc.l		 Main ; Valeur initiale du PC
; ==============================
; Programme principal
; ==============================
					org 		$500
Main 				; Test 1
					move.l #$ffffffff,d0
			;		jsr 	FillScreen
					; Test 2
					move.l #$f0f0f0f0,d0
			;		jsr 	FillScreen
					; Test 3
					move.l #$fff0fff0,d0
			;		jsr 	FillScreen
					; Test 4
					moveq.l #$0,d0
					jsr 	FillScreen
					; TEST 5
			;		jsr		HLines
					; TEST 6
			;		jsr		WhiteSquare32
					; TEST 7
			;		jsr		WhiteSquare128
					; TEST 8
			;		movea.l		#CENTER,a0
			;		move.l		#60,d0
			;		jsr			WhiteLine
					; TEST 9
					move.l		#8,d0
					jsr			WhiteSquare
					; TEST 10
					move.l		#32,d0
					jsr			WhiteSquare
; ...		
; ...
					illegal
; ==============================
; Sous-programmes
FillScreen			movem.l		a0/d1,-(a7)
					movea.l		#VIDEO_START,a0
					move.l		#VIDEO_SIZE,d1
\loop				tst.l		d1
					beq			\quit
					move.l		d0,(a0)+
					subi.l		#4,d1
					bra			\loop
\quit				movem.l		(a7)+,d1/a0
					rts

HLines				movem.l		a0/d0/d1,-(a7)
					movea.l		#VIDEO_START,a0
					move.l		#VIDEO_SIZE,d1
					move.l		#$ffffffff,d0
\main_loop			tst.l		d1
					beq			\quit
					move.l		d3,-(a7)
					move.l		#VIDEO_WIDTH,d3
					bra			\loop
\end_				move.l		(a7)+,d3
					subi.l		#$120,d1
					add.l		#VIDEO_WIDTH,a0
					bra			\main_loop
\loop				tst.w		d3
					beq			\end_
					move.l		d0,(a0)+
					subi.l		#4,d3
					bra			\loop
\quit				movem.l		(a7)+,d1/d0/a0
					rts

WhiteLine			movem.l		a0/d0,-(a7)
\loop				tst.w		d0
					beq			\quit
					move.l		#$ffffffff,(a0)+
					subi.l		#4,d0
					bra			\loop
\quit				movem.l		(a7)+,d0/a0
					rts

WhiteSquare32		movem.l		a0/d1,-(a7)
					movea.l		#START_32,a0
					move.w		#SIZE_32,d1
\loop				tst.w		d1
					bmi			\quit
					move.l		d0,-(a7)
					move.l		#4,d0
					jsr			WhiteLine
					move.l		(a7)+,d0
					subi.w		#4,d1
					add.l		#60,a0
					bra			\loop
\quit				movem.l		(a7)+,d1/a0
					rts
					
WhiteSquare128  	movem.l		a0/d1,-(a7)
					movea.l		#START_128,a0
					move.w		#SIZE_128,d1
\loop				tst.w		d1
					bmi			\quit
					move.l		d0,-(a7)
					move.l		#16,d0
					jsr			WhiteLine
					move.l		(a7)+,d0
					subi.w		#4,d1
					add.l		#60,a0
					bra			\loop
\quit				movem.l		(a7)+,d1/a0
					rts	

WhiteSquare			movem.l		a0/d0/d1/d2,-(a7)
					move.l		d0,d1
					move.l		d0,d2
					divu.W		#4,d2
					mulu.W		#120,d1
					lea.l		CENTER,a0
					sub.l		d2,a0
					sub.l		d1,a0
					move.l		d0,d2
					mulu.W		#4,d2
					divu.w		#2,d0
\loop				tst.w		d2
					bmi			\quit
					jsr			WhiteLine
					subi 		#1,d2
					add.l		#60,a0
					bra			\loop
\quit				movem.l		(a7)+,d2/d1/d0/a0
					rts
					
					
					
; ...
; ...
; ==============================
; Données
; ==============================
CENTER			equ		(VIDEO_START+60*160+30)
START_32		equ		(CENTER-2-(15*60))
END_32			equ		(CENTER+2+(16*60))
START_128		equ		(CENTER-8-(63*60))
END_128			equ		(CENTER+8+(64*60))
SIZE_32			equ		((END_32-START_32)/16)
SIZE_128		equ		((END_128-START_128)/16)

; ...
; ...

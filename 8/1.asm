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
					jsr 	FillScreen
					; Test 2
					move.l #$f0f0f0f0,d0
					jsr 	FillScreen
					; Test 3
					move.l #$fff0fff0,d0
					jsr 	FillScreen
					; Test 4
					moveq.l #$0,d0
					jsr 	FillScreen
					; TEST 5
					jsr		HLines
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
					
					
					
					
; ...
; ...
; ==============================
; Données
; ==============================
; ...
; ...
; ...

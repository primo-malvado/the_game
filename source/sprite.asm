
;org 32768			;we can ORG (or assemble) this code anywhere really
				;a beginner's, unoptimised sprite routine
main:	
        halt			;this stops the program until the Spectrum is about to refresh the TV screen
				;the HALT is important to avoid sprite flicker, and it slows down the program
	call deletesprite	;we need to delete the old position of the sprite
	call movesprite		;move the sprite! Could be based on player key input or baddy AI
	call drawsprite		;get correct preshifted graphic, and draw it on the screen
	jr main			;loop!
	;
deletesprite:			;we need to delete the old sprite before we draw the new one.  The sprite is 3 bytes wide & 17 pixels high
	ld a,(x_coordinate)		;make C=xcor and B=ycor
	ld c,a
	ld a,(y_coordinate)
	ld b,a
	call yx2pix		;point DE at the corresponding screen address
	ld b,17			;sprite is 17 lines high
deleteloop:
	ld a,0			;empty A to delete
	ld (de),a		;repeat a total of 3 times
	inc e			;next column along
	ld (de),a
	inc e
	ld (de),a
	dec e
	dec e			;move DE back to start of line
	call nextlinedown	;move DE down one line
	djnz deleteloop		;repeat 17 times
	ret
	;
movesprite:			;very simple routine that just increases the x coordinate
	ld a,(x_coordinate)
	inc a
	ld (x_coordinate),a
	cp 232			;check if the sprite has moved all the way to the right (256-24)
	ret c			;return if not
	ld a,0			;if yes then back to left
	ld (x_coordinate),a
	ret
	;
drawsprite:

	ld a,(x_coordinate)		;make C=xcor and B=ycor
	ld c,a
	ld a,(y_coordinate)
	ld b,a
	call yx2pix		;point DE at corresponding screen position
	ld a,(x_coordinate)	;but we still need to find which preshifted sprite to draw
	and 00000111b		;we have 8 preshifted graphics to choose from, cycled 0-7 in the right hand 3 bits of the x coordinate
	call getsprite_alternativemethod		;point HL at the correct graphic
	ld b,17			;sprite is 17 lines high
drawloop:
	ld a,(hl)		;take a byte of graphic
	ld (de),a		;and put it on the screen
	inc hl			;next byte of graphic
	inc e			;next column on screen
	ld a,(hl)		;repeat for 3 bytes across
	ld (de),a
	inc hl
	inc e
	ld a,(hl)
	ld (de),a
	inc hl
	dec e
	dec e			;move DE back to left hand side of sprite
	call nextlinedown
	djnz drawloop		;repeat for all 17 lines
	ret
	;
x_coordinate:	db	0
y_coordinate:	db	0
	;
nextlinedown:			;don't worry about how this works yet!
	inc d			;just arrive with DE in the display file
	ld a,d			;and it gets moved down one line
	and 7
	ret nz
	ld a,e
	add a,32
	ld e,a
	ret c
	ld a,d
	sub 8
	ld d,a
	ret
	;
yx2pix:		;don't worry about how this works yet! just arrive with arrive with B=y 0-192, C=x 0-255
	ld a,b	;return with DE at corresponding place on the screen
	rra
	rra
	rra
	and 24
	or 64
	ld d,a
	ld a,b
	and 7
	or d
	ld d,a
	ld a,b
	rla
	rla
	and 224
	ld e,a
	ld a,c
	rra
	rra
	rra
	and 31
	or e
	ld e,a
	ret
	;
 
getsprite_alternativemethod:	
			;arrive A holding which sprite position 0 - 7
			;this method uses a table to find the correct graphic
	add a,a		;multiplay a by 2, this converts a single byte number 0-7 into a 2 byte table entry
	ld h,0
	ld l,a
	ld bc,sprite_table_addresses
	add hl,bc	;HL is now pointing at the correct table entry
	ld c,(hl)
	inc hl
	ld b,(hl)	;get table address spritegraphic0, spritegraphic1 etc in BC
	ld l,c
	ld h,b		;now HL is pointing at the correct sprite graphic
	ret
	;
sprite_table_addresses:
	dw	spritegraphic0
	dw	spritegraphic1
	dw	spritegraphic2
	dw	spritegraphic3
	dw	spritegraphic4
	dw	spritegraphic5
	dw	spritegraphic6
	dw	spritegraphic7
	;
spritegraphic0:		;8 preshifted graphics, each one 3 bytes wide and 17 pixels high, this one a simple square
                    ;frame 0
    db %00000000, %00000000, %00000000		
    db %00000000, %00000000, %00000000		
    db %00000111, %11100000, %00000000
    db %00011111, %11111000, %00000000
    db %01111111, %11111110, %00000000
    db %01111111, %11010110, %00000000
    db %11111111, %11010111, %00000000
    db %11111111, %11111111, %00000000
    db %11111111, 11111111, %00000000
    db %11111111, %10111011, %00000000
    db %01111111, %11000110, %00000000
    db %01111111, %11111110, %00000000
    db %00011111, %11111000, %00000000
    db %00000111, %11100000, %00000000
    db %00000000, %00000000, %00000000
    db %00000111, %01100000, %00000000
    db %00001111, %10110000, %00000000
    ;
spritegraphic1:
    db %00000000, %00000000, %00000000		
    db %00000000, %00000000, %00000000		
    db %00000011, %11110000, %00000000
    db %00001111, %11111100, %00000000
    db %00111111, %11111111, %00000000
    db %00111111, %11101011, %00000000
    db %01111111, %11101011, %10000000
    db %01111111, %11111111, %10000000
    db %01111111, %11111111, %10000000
    db %01111111, %11011101, %10000000
    db %00111111, %11100011, %00000000
    db %00111111, %11111111, %00000000
    db %00001111, %11111100, %00000000
    db %00000011, %11110000, %00000000
    db %00000000, %00000000, %00000000
    db %00000011, %10110000, %00000000
    db %00000111, %11011000, %00000000
	;
spritegraphic2:
    db %00000000, %00000000, %00000000		
    db %00000000, %00000000, %00000000		
    db %00000001, %11111000, %00000000
    db %00000111, %11111110, %00000000
    db %00011111, %11111111, %10000000
    db %00011111, %11110101, %10000000
    db %00111111, %11110101, %11000000
    db %00111111, %11111111, %11000000
    db %00111111, %11111111, %11000000
    db %00111111, %11101110, %11000000
    db %00011111, %11110001, %10000000
    db %00011111, %11111111, %10000000
    db %00000111, %11111110, %00000000
    db %00000001, %11111000, %00000000
    db %00000000, %00000000, %00000000
    db %00000111, %10011110, %00000000
    db %00000011, %11001100, %00000000
	;
spritegraphic3:
    db %00000000, %00000000, %00000000		
    db %00000000, %00000000, %00000000		;frame 3
    db %00000000, %11111100, %00000000
    db %00000011, %11111111, %00000000
    db %00001111, %11111111, %11000000
    db %00001111, %11101010, %11000000
    db %00011111, %11101010, %11100000
    db %00011111, %11111111, %11100000
    db %00011111, %11111111, %11100000
    db %00011111, %11100111, %01100000
    db %00001111, %11100001, %10000000
    db %00001111, %11111111, %11000000
    db %00000011, %11111111, %00000000
    db %00000000, %11111100, %00000000
    db %00000000, %00000000, %00000000
    db %00000011, %11001111, %00000000
    db %00000001, %11100110, %00000000
	;
spritegraphic4:
    db %00000000, %00000000, %00000000		
	db 0, 126, 0		;frame 4
	db 1, 255, 128
	db 7, 255, 224
	db 7, 253, 96
	db 15, 253, 112
	db 15, 255, 240
	db 15, 255, 240
	db 15, 251, 176
	db 7, 252, 96
	db 7, 255, 224
	db 1, 255, 128
	db 0, 126, 0
	db 1, 128, 192
	db 1, 195, 192
	db 0, 225, 128
	db 0, 0, 0
	;
spritegraphic5:
    db %00000000, %00000000, %00000000		
	db 0, 63, 0		;frame 5
	db 0, 255, 192
	db 3, 255, 240
	db 3, 254, 176
	db 7, 254, 184
	db 7, 255, 248
	db 7, 255, 248	
	db 7, 253, 216
	db 3, 254, 48
	db 3, 255, 240
	db 0, 255, 192
	db 0, 63, 0
	db 0, 192, 96
	db 0, 225, 224
	db 0, 112, 192
	db 0, 0, 0
	;
spritegraphic6:
    db %00000000, %00000000, %00000000		
	db 0, 0, 0		;frame 6
	db 0, 31, 128
	db 0, 127, 224
	db 1, 255, 248
	db 1, 255, 88
	db 3, 255, 92
	db 3, 255, 252
	db 3, 255, 252
	db 3, 254, 236
	db 1, 255, 24
	db 1, 255, 248
	db 0, 127, 224
	db 0, 31, 128
	db 0, 0, 0
	db 0, 14, 128
	db 0, 31, 64
	;
spritegraphic7:
    db %00000000, %00000000, %00000000		
	db 0, 0, 0		;frame 7
	db 0, 15, 192
	db 0, 63, 240
	db 0, 255, 252
	db 0, 255, 172
	db 1, 255, 174
	db 1, 255, 254
	db 1, 255, 254
	db 1, 255, 118
	db 0, 255, 140
	db 0, 255, 252
	db 0, 63, 240
	db 0, 15, 192
	db 0, 0, 0
	db 0, 7, 64
	db 0, 15, 160
	;



; Get screen address
;  b = Y pixel position
; Returns address in HL
;
Get_Pixel_Address:      
        ld d, b
        ld a,d          ; calculate y2,y1,y0
        and %00000111   ; mask out unwanted bits
        or %01000000    ; set base address of screen
        ld h,a          ; store in h
        ld a,d          ; calculate y7,y6
        rra             ; shift to position
        rra
        rra
        and %00011000   ; mask out unwanted bits
        or h            ; or with y2,y1,y0
        ld h,a          ; store in h
        ld a,d          ; calculate y5,y4,y3
        rla             ; shift to position
        rla
        and %11100000   ; mask out unwanted bits
        ld l,a          ; store in l
  
        ret


getPixelAddress:
    ld hl, row_memory

    ld a, l
    add b
    _if_not NC
        inc h
    _end_if
    add b

    _if_not NC
        inc h
    _end_if
    ld l, a


    push bc
    ld c,(hl)
    inc hl
    ld b,(hl)
    ld l,c
    ld h,b	
    pop bc


    ld a, l
    add c
    ld l, a
    
    ret


nextLineDown:			;don't worry about how this works yet!
	inc h			;just arrive with DE in the display file
	ld a,h			;and it gets moved down one line
	and 7
	ret nz
	ld a,l
	add a,32
	ld l,a
	ret c
	ld a,h
	sub 8
	ld h,a
	ret
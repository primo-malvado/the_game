
 

OLD_getPixelAddress:
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
getPixelAddress:
    ld de, row_memory

    ld a, e
    add b
    _if_not NC
        inc d
    _end_if
    add b

    _if_not NC
        inc d
    _end_if
    ld e, a


    push bc
    ld a,(de)
    ld c,a
    inc de
    ld a,(de)
    ld b,a
    ld e,c
    ld d,b	
    pop bc


    ld a, e
    add c
    ld e, a
    
    ret

 

nextLineDown:
	inc d	
	ld a,d	
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
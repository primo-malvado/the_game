
 

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
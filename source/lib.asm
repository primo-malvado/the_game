
 

getPixelAddress:
    ld de, row_memory

    ld a, e
    add a, b
    jr nc, no_carry
    inc d
no_carry:
    add a, b
    jr nc, no_carry2
    inc d
no_carry2:
    ld e, a

    push bc
    ld a, (de)
    ld c, a
    inc de
    ld a, (de)
    ld b, a
    ld e, c
    ld d, b
    pop bc

    ld a, e
    add a, c
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
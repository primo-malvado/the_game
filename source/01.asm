
buffer_screen equ $f000


 

Stack_Top:              EQU $5dc0                             ; Stack at top of RAM
 
        org $5dc0

rom_01_start:
start:

        di
        ld sp, Stack_Top


		ld a, $47;
		ld hl, $5800
		ld (hl), a
		ld de, $5801
		ldir

_mega_loop:
                


				LD BC,$Fdfe
				IN A,(C)   
				AND %00000001 
				_if_not nz
					;tecla "a"

					ld a, (map_delta_y)
					cp 3
					_if_not nz
						xor a
						ld  (map_delta_y), a

						ld bc, 80 
						ld hl , (map_show)
						add hl, bc
						ld (map_show), hl
					_else
						inc a
						ld  (map_delta_y), a

					_end_if

				_end_if



				LD BC,$Fbfe
				IN A,(C)   
				AND %00000001 
				_if_not nz
					;tecla "q"
					ld a, (map_delta_y)
					cp 0
					_if_not nz
						ld a, 3
						ld  (map_delta_y), a

						ld bc, 80 
						ld hl , (map_show)
						sub hl, bc
						ld (map_show), hl
					_else
						dec a
						ld  (map_delta_y), a

					_end_if
		

				_end_if



				LD BC,$dffe
				IN A,(C)   
				AND %00000001 
				_if_not nz
					;tecla "p"
					ld a, (map_delta_x)
					cp 3
					_if_not nz
						xor a
						ld  (map_delta_x), a

		 
						ld hl , (map_show)
						inc hl
						ld (map_show), hl
					_else
						inc a
						ld  (map_delta_x), a

					_end_if
				_end_if

				LD BC,$dffe
				IN A,(C)   
				AND %00000010 
				_if_not nz
					;tecla "o"


					ld a, (map_delta_x)
					cp 0
					_if_not nz
						ld a, 3
						ld  (map_delta_x), a

						
						ld hl , (map_show)
						dec hl
						ld (map_show), hl
					_else
						dec a
						ld  (map_delta_x), a

					_end_if



				_end_if



				ld a, $f0
				ld (drawTiles+2), a
				ld a, (map_delta_x)

				cp 0
				jr nz, cp1
                	ld a, $03
					ld (drawTiles+1), a
					jr cp_exit
cp1:

				cp 1
				jr nz, cp2
						ld a, $02
						ld (drawTiles+1), a
						jr cp_exit
cp2:

						cp 2
						jr nz, cp3
							ld a, $02
							ld (drawTiles+1), a
							jr cp_exit
cp3:						

						cp 3
						jr nz, cp_exit
							ld a, $01
							ld (drawTiles+1), a

cp_exit:


 







         
 

                call drawTiles


				ld a, (map_delta_x)
				bit 0, a
				_if_not z
						call move_a_nibble
				_end_if


 		        ei
                HALT 
 
    
				di

                ;HALT 
                ;HALT 
                call copy_to_screen


                ;ld a, $02
                ;ld (drawTiles+1), a
                ;ld a, $f0
                ;ld (drawTiles+2), a

                ;call drawTiles


                ;call move_a_nibble
 
 		        ;ei
                ;HALT 
                ;HALT 
 
				;di
        
                ;call copy_to_screen



        jp _mega_loop




drawTiles:



        ld hl, $f003
        EXX
        LD DE, 50+96-80

        ld hl , (map_show)

        ld c, $08
        ld (old_sp_operator+1), sp
 

draw_row:
        ld b, $0e

        _do

                ld a, (hl)
                exx 

                ld c, $00
                srl a
                rr c
                srl a
                rr c
                srl a
                rr c
                ld b, a
                
                ld ix, tiles
                add ix, bc
                ld sp, ix
                ld bc, $1f
                
                rept 15
                        pop de 
                        ld (hl), e
                        inc l
                        ld (hl), d
                        add hl, bc

                endr


                pop de 
                ld (hl), e
                inc l
                ld (hl), d

                ld bc, $fe21
                add hl, bc
                exx

                inc hl 
        _djnz

        add hl, de
        exx 
        ld bc, $01e4
        add hl , bc

        exx 
        dec c
        jp nz,  draw_row


 
old_sp_operator:
        ld sp, $0000

        ret



copy_to_screen: ;8586


        ld c, $48
        ld hl, $401d 
        ld (operator_0001+1), hl
        ld ix, $f011

 
        call function_85b5
        ld c, $50
        ld hl, $481d
        ld (operator_0001+1), hl

function_85b5:
        ld b, $40
        ld (operator_0002+1), sp
        ld sp, ix


		_do


			pop af
			pop de 
			pop hl
			exx
			pop bc
			pop de
			pop hl

operator_0001:
			ld sp, $0000
			push hl
			push de
			push bc

			exx

			push hl
			push de
			push af

			ld (operator_0003+1), sp

			ld sp, $fff2
			add ix, sp 
			ld sp, ix
			pop af
			pop de 
			pop hl

			exx 
			ex af, af'

			pop af
			pop bc
			pop de
			pop hl 
operator_0003:        
			ld sp, $4ff1

			push hl
			push de 
			push bc 
			push af
			exx
			ex af, af'
			push hl
			push de 
			push af 

			ld hl, $011a
			add hl, sp
			ld a, h
			cp c
			
			_if_not c
				ld de, $f820
				add hl, de 
			_end_if

			ld (operator_0001+1), hl
			ld sp, $002e
			add ix, sp
			ld sp, ix

        _djnz
operator_0002:        
        ld sp , $7b0e
        ret



move_a_nibble:
	LD   HL,$F002
	LD   DE,$0006
	LD   B,$80
	_do
		LD   A,(HL)
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		INC  L
		RRD
		ADD  HL,DE
	_djnz
	RET 







map_show: 
        dw map

map_delta_x:
		db $00
map_delta_y:
		db $00



        org $7000

        include "map.asm"
        org $aa00
        include "tiles16.asm"

rom_01_end:

        
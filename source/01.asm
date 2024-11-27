
buffer_screen equ $f000

map_width equ 60
ROM_CLS                 EQU  0x0DAF  
ROM_PRINT               EQU  0x203C  
INK                     EQU 0x10
PAPER                   EQU 0x11
FLASH                   EQU 0x12
BRIGHT                  EQU 0x13
INVERSE                 EQU 0x14
OVER                    EQU 0x15
AT                      EQU 0x16
TAB                     EQU 0x17
CR                      EQU 0x0C
Stack_Top:              EQU $5dc0                             ; Stack at top of RAM
 
        org $5dc0

rom_01_start:
start:

        di
		ld a, 0
		ld(23606), a
		ld a, 249
		ld(23607), a



        ld sp, Stack_Top
		CALL ROM_CLS            

		ld bc, 32*24
		ld a, %01000111
		ld hl, $5800
		ld de, $5801
		ld (hl), a
		ldir



		LD DE, TEXT
		CALL MY_PRINT
 
 

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

						ld bc, map_width 
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

						ld bc, map_width
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


 		        ;ei
                ;HALT 
 
    
				;di
 
                call copy_to_screen
 


        jp _mega_loop




drawTiles:



        ld hl, $f003 ; buffer
        EXX
        LD DE, map_width-14

        ld hl , (map_show); mapposition

        ld c, $08
        ld (old_sp_operator+1), sp
 

draw_row:
        ld b, $0e

        _do

                ld a, (hl); mapposition
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
                add hl, bc ; buffer
                exx

                inc hl ; mapposition
        _djnz

        add hl, de ; mapposition
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



		ld a, (map_delta_y)
		cp 0
		_if_not nz

        	ld ix, $f011

		_end_if

		cp 1
		_if_not nz

        	ld ix, $f011+4*32

		_end_if
		cp 2
		_if_not nz

        	ld ix, $f011+32*8

		_end_if
		cp 3
		_if_not nz

        	ld ix, $f011+32*12

		_end_if



 
        ld b, $40
        call function_85b5
        ld b, $40-16
        ld c, $50
        ld hl, $481d
        ld (operator_0001+1), hl

function_85b5:
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

                rept 26

		INC  L
		RRD
                endr

 
		ADD  HL,DE
	_djnz
	RET 


MY_PRINT:               LD A, (DE)              ; Get the character
                        CP 0                    ; CP with 0
                        RET Z                   ; Ret if it is zero
                        RST 0x10                ; Otherwise print the character
                        INC DE                  ; Inc to the next character in the string
                        JR MY_PRINT 


TEXT:                   DB AT, 20, 2, INK, 1, PAPER, 6, BRIGHT, 1, "Tiago Monge, usa as teclas q, a, o e p para mover o mundo!", 0

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


		org $fa00
        include "font.asm"

rom_01_end:

        

game_screen_top equ $40a1 


screen_pixels equ $4000 
row_memory equ $5b00

Stack_Top:              EQU 0x0000                              ; Stack at top of RAM
 
        org $5dc0


rom_01_start:
        di
        ld sp, Stack_Top
 
        ld ix, $4000
        ld de, $1B00
        call $0562
 
        ld ix, $AD00
        ld de, rom_03_end-rom_03_start
        call $0562
 
        jp start
 
rom_01_end:



        org        $ad00


rom_03_start:




start:
 


        di

        ld sp, Stack_Top

        xor a

        call init_lookup


 

        call Initialise_Interrupt

        call clear_game_area


       ; jp main
        
        _do

              ;  call clear_game_area


                call main_loop

        _while_true



clear_game_area:

        ld b, 40
        _do 

                ld c, 1
                _do

                        call getPixelAddress
                        xor a
                        ld (de), a
                        inc c

                        ld a, c
                        cp 25

                _while nz

                inc b


                ld a, b
                cp 185

        _while nz



        ld de, $58a1
        ld b, 5
        _do 

                ld c, 1
                _do

                        ld a, $07
                        ld (de), a
                        inc de
                        inc c

                        ld a, c
                        cp 25

                _while nz

                inc b

                inc de
                inc de
                inc de
                inc de
                inc de
                inc de
                inc de
                inc de
                ; inc de

                ld a, b
                cp 23

        _while nz



 
        ret 


actual_level: 
        db $00

actual_player_position:
        db $00, $00 ; x, y


level_lookup:
        dw level_00

level_00:
        db $36; player position x=3, y=6
        db $92; goal position x=9, y=2
        db $81  ; posicao obstaculos
        db $34
        db $95
        db $ff ; lim da lista de obstaculos















        include "main.asm"
        
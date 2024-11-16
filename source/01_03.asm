
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

        ld a, $00
        ld (actual_level), a

        call get_level_config
        call copy_level_to_buffer
        call draw_level



       ; jp main
        
        _do


        _while_true

get_level_config:
        ld hl, level_00
        ret

; hl    level config 
; level_buffer - 
copy_level_to_buffer:

        ld a, (hl)
        ld (actual_player_position), a

        inc hl
        ld a, (hl)
        ld (actual_player_position+1), a


        inc hl; goal x
        ld b, a 
        inc hl; goal y
        ld c, a 
        call put_goal_in_buffer

        ;ld de, level_buffer

        inc hl

        ld a, (hl)
        cp $ff
        ret z

        _do

                ld b, a 
                inc hl
                ld a, (hl)
                ld c, a
                inc hl

                call put_obstacle_in_buffer



 
                push hl

                




                ld a, (hl)
                cp $ff
        _while nz

        ret

put_goal_in_buffer:
        push hl
        ld a , b

        ld b, c
        _do
                add 12
        _djnz
        
        ld hl, level_buffer
        ld d, 0
        ld e, a
        add hl, de

        ld a, 1 
        ld (hl), a

        pop hl
        ret
put_obstacle_in_buffer:
        push hl
        ld a , b

        ld b, c
        _do
                add 12
        _djnz
        
        ld hl, level_buffer
        ld d, 0
        ld e, a
        add hl, de

        ld a, 2
        ld (hl), a

        pop hl
        ret

draw_level:

        



        ret

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

level_buffer:
        db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00


level_lookup:
        dw level_00

level_00:
        db $03, $06; player position x=3, y=6
        db $09, $02; goal position x=9, y=2
        db $08, $01  ; posicao obstaculos
        db $03, $04
        db $09, $05

        db $ff ; lim da lista de obstaculos















        include "main.asm"
        
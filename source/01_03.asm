
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


        ld sp, row_memory+191*2

        ld b, 191


        _do
                dec b
                call Get_Pixel_Address
                push hl


                xor a 
                or b 
        _while nz
 

        ld sp, Stack_Top






        ;call clear_screen

        call Initialise_Interrupt
        jp main
        
        _do




        _while_true



Initialise_Interrupt:   
                DI
                LD A, $fe
                LD I, a
                IM 2   
                EI     
                RET


clear_screen:
        ret 
        xor a
        ld hl, screen_pixels
        ld de, screen_pixels +1 
        ld (hl), a
        ld bc, 192*32-1
        ldir

        ld a, $07
        ld hl, $5800
        ld de, $5800 +1 
        ld (hl), a
        ld bc, 32*24-1
        ldir
        ret 

desenho_00:
        db %00000000, %00000000
        db %00000000, %00000000
        db %00011111, %11111100
        db %00111111, %11111110
        db %01110000, %00000000
        db %01111111, %11111100
        db %01111001, %11100100
        db %01111001, %11100110
        db %01111001, %11100110
        db %01111111, %00111110
        db %01111111, %11111110
        db %00111111, %11111100
        db %00000000, %00000000
        db %01101111, %11110110
        db %01111111, %11110110
        db %00011110, %01110000
        db %00011100, %01111000
 
desenho_01:
        db %00000000, %00011110
        db %00011111, %11111110
        db %00111111, %11111100
        db %01110000, %00000000
        db %01111111, %11111100
        db %01111100, %11110000
        db %01111100, %11110010
        db %01111100, %11110010
        db %01111111, %10011110
        db %01111111, %11111110
        db %00111111, %11111100
        db %01100000, %00000000
        db %01100111, %11101100
        db %00011111, %11111100
        db %00011111, %11111100
        db %00011000, %00000000
        db %00000000, %00000000


desenho_02:
        db %00000000, %00011110
        db %00011111, %11111110
        db %00111111, %11111100
        db %01110000, %00000000
        db %01111111, %11111100
        db %01110011, %11001100
        db %01110011, %11001110
        db %01110011, %11001110
        db %01111110, %01111110
        db %01111111, %11111110
        db %00111111, %11111100
        db %00110000, %00000110
        db %00111111, %11110110
        db %00001111, %11110000
        db %00001111, %01110000
        db %00001111, %11100000
        db %00000000, %00000000        

desenho_03:
        db %00000000, %00000000
        db %01111111, %11111110
        db %01111111, %11111110
        db %01101111, %11110110
        db %01111111, %11111110
        db %01111111, %11111110
        db %01111111, %11111110
        db %01111111, %11111110
        db %01111111, %11111110
        db %01111111, %11111110
        db %01111111, %11111110
        db %01111111, %11111110
        db %01111111, %11111110
        db %01101111, %11110110
        db %01111111, %11111110
        db %01111111, %11111110

desenho_04:
        db %00000000, %00000000
        db %01111111, %11111110
        db %00111111, %11111100
        db %01011111, %11111100
        db %01100000, %00000000
        db %01110111, %11100000
        db %01110111, %11100000
        db %01110111, %11100000
        db %01110111, %11100000
        db %01110111, %11100000
        db %01110111, %11100000
        db %11100000, %00000000
        db %11100000, %00000000
        db %11000000, %00000000
        db %10000000, %00000000
        db %00000000, %00000000









; b: line from top
; c: byte from left
draw:

        ld a, b
        add 17
        ld(op_01+1), a

        ld a, c
        ld(op_03+1), a
        add 2
        ld(op_00+1), a

        _do
op_03:          
                ld c, 1
        
                _do

                        call getPixelAddress
                       


                        ld a, (de)
                        ld (hl), a 
                        inc de
                        
                        inc c
                        ld a, c
op_00:                        
                        cp 0
                _while nz
                inc b
                ld a, b
op_01:                        
                cp  0
        _while nz


 
 
        ret                   ; Return from the function



game_started: 
        db $00
loop_counter:
        db $00 
 

        include './lib.asm'


interrupt_handler: 
        DI                                      ; Disable interrupts 
        ; PUSH AF                                 ; Save all the registers on the stack
        ; PUSH BC                                 ; This is probably not necessary unless
        ; PUSH DE                                 ; we're looking at returning cleanly
        ; PUSH HL                                 ; back to BASIC at some point
        ; PUSH IX
        ; EXX
        ; EX AF,AF'
        ; PUSH AF
        ; PUSH BC
        ; PUSH DE
        ; PUSH HL
        ; PUSH IY
        

        ld a, (game_started)
        cp 1
        _if_not nz
        


                
                ld a, (loop_counter)
                inc a
                
                cp 40
                _if_not nz
                        xor a
                _end_if
                ld (loop_counter), a




                cp 10
                
                _if_not nz

                        ;call clear_screen
                        ld bc, $5f08
                        ld de, desenho_00 
                        call draw
                _else
                        cp 20
                        _if_not nz
                                ;call clear_screen
                                ld bc, $5f09
                                ld de, desenho_01 
                                call draw

                        _else
                                cp 30
                                _if_not nz
                                
                                        ;call clear_screen
                                        ld bc, $5f0a
                                        ld de, desenho_00 
                                        call draw
                                _else
                                        cp 0
                                        _if_not nz
                                                ;call clear_screen
                                                ld bc, $5f07
                                                ld de, desenho_02 
                                                call draw

                                        _end_if
                                _end_if
                        _end_if
                _end_if

        _else


                ;         ld a, (game_started)
                ; bit 0, a
                ; _if_not nz
                        ; ei
                        ; halt
                        ; di

                        ld a, $7f
                        in a, ($fe)
        
                        bit 0, a
                        _if_not nz
                                ld a, 1
                                ld (game_started), a

                                call clear_screen
                        _end_if
                        ; ei
                ; _end_if



        _end_if




        ; POP IY                                  ; Restore all the registers
        ; POP HL
        ; POP DE
        ; POP BC
        ; POP AF
        ; EXX
        ; EX AF,AF'
        ; POP IX
        ; POP HL
        ; POP DE
        ; POP BC
        ; POP AF
        EI                                      ; Enable interrupts
        RET  

        include '../source/sprite.asm'


        org $fdfd
IM2_JP:
        jp interrupt_handler

IM2_Table:
        db $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd
        db $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd
        db $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd
        db $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd
        db $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd
        db $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd
        db $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd
        db $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd
        db $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd
        db $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd
        db $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd
        db $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd
        db $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd
        db $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd
        db $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd
        db $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd, $fd
        db $fd


rom_03_end:
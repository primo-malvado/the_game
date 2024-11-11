
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
       ; jp main
        
        _do



        ld a, (game_started)
        cp 1
        _if_not nz
        
                halt

                
                ld a, (loop_counter)
                inc a
                
                cp 20
                _if_not nz
                        xor a
                _end_if
                ld (loop_counter), a




                cp 5
                
                _if_not nz
                         
                        ;call clear_screen
                        ld bc, $5f08
                        ld de, desenho_00 
                        call drawBoneco
                _else
                        cp 10
                        _if_not nz
                         
                                ;call clear_screen
                                ld bc, $5f09
                                ld de, desenho_01 
                                call drawBoneco

                        _else
                                cp 15
                                _if_not nz
                                 
                                        ;call clear_screen
                                        ld bc, $5f0a
                                        ld de, desenho_00 
                                        call drawBoneco
                                _else
                                        cp 0
                                        _if_not nz
                                        
                                                ;call clear_screen
                                                ld bc, $5f07
                                                ld de, desenho_02 
                                                call drawBoneco

                                        _end_if
                                _end_if
                        _end_if
                _end_if

        _else


 

                        ld a, $7f
                        in a, ($fe)
        
                        bit 0, a
                        _if_not nz
                                ld a, 1
                                ld (game_started), a

                                halt


    
                                call clear_screen


 
                                ld b, 0
                                _do 

                                        ld c, 0
                                        _do


                                                ld de, desenho_04 
                                                call draw16x16


                                                inc c
                                                inc c

                                                ld a, c
                                                cp 32

                                         _while nz

                                        ld a, b
                                        add 16

                                        ld b, a
                                        cp 192

                                _while nz




                        _end_if
 


        _end_if



        _while_true





Initialise_Interrupt:   
                DI
                LD A, $fe
                LD I, a
                IM 2   
                EI     
                RET


clear_screen: 
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

 
 

walk: 
        dw desenho_00
        dw desenho_01
        dw desenho_00
        dw desenho_02
 


init_lookup:

        ld de, row_memory

        ld b, 191
        ld hl, $4000

        _do
                ld a, l
                ld (de), a

                inc de 
                ld a, h
                ld (de), a

                call nextLineDown

                inc de 
        _djnz
 

        ret 


        include "bonecos.asm"
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
        db %01110000, %00000000
        db %01110000, %00000000
        db %01100000, %00000000
        db %01000000, %00000000
        db %00000000, %00000000







last_boneco:
        db $02
last_boneco_pos:
        db $00
        db $00
boneco_pos:
        db $00
        db $5f



clear_boneco
        push de

        ld bc, (last_boneco_pos)
        ld de, desenho_mask
        ld a, b
        add 17
        ld(op_05+1), a

        ld a, c
        ld(op_07+1), a
        add 2
        ld(op_06+1), a

        _do
op_07:          
                ld c, 0
        
                _do

                        call getPixelAddress
                       
                        ld a, (de)
                        ;xor  (hl)
                        ld (hl), a
 

                        inc de
                        inc c
                        ld a, c
op_06:                        
                        cp 0
                _while nz
                inc b
                ld a, b
op_05:                        
                cp  0
        _while nz


        pop de
 
        ret   



; b: line from top
; c: byte from left
drawBoneco:

        call clear_boneco


        ld ix, desenho_mask
        ld bc, (boneco_pos)
        ld a, b
        add 17
        ld(op_01+1), a

        ld a, c
        ld(op_03+1), a
        add 2
        ld(op_00+1), a

        _do
op_03:          
                ld c, 0
        
                _do

                        call getPixelAddress
                       
                       push hl 
                       push de 
                       pop hl 
                       pop de

                        
                        ld a, (de)

                        ld (ix), a
                        inc ix

                        and  (hl)
                        ld (de), a

                        inc hl 

                        ld a, (de)
                        or (hl)
                        ld (de), a

                        inc hl
                        inc c
                        ld a, c

                       push hl 
                       push de 
                       pop hl 
                       pop de

 
op_00:                        
                        cp 0
                _while nz
                inc b
                ld a, b
op_01:                        
                cp  0
        _while nz


        ld bc, (boneco_pos)
        ld a,(boneco_pos)
        ld (last_boneco_pos), a
        ld a,(boneco_pos+1)
        ld (last_boneco_pos+1), a

        inc bc
        ld (boneco_pos), bc
        
 
        ret                   ; Return from the function


; b: line from top
; c: byte from left
draw16x16:
        push bc
        call getPixelAddress
        ld b,16

        _do
                ld a, (de)
                ld (hl), a 
                inc de 
                inc hl

                ld a, (de)
                ld (hl), a  
                inc de   

                dec hl 
                call nextLineDown

        _djnz
        pop bc
        ret


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
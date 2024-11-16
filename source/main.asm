main_loop:

    ld a, (game_started)
    cp 1
    _if_not nz
    
            halt
            halt
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
                    ld hl, desenho_00 
                    call drawBoneco
            _else
                    cp 10
                    _if_not nz
                        
                            ;call clear_screen
                            ld bc, $5f09
                            ld hl, desenho_01 
                            call drawBoneco

                    _else
                            cp 15
                            _if_not nz
                                
                                    ;call clear_screen
                                    ld bc, $5f0a
                                    ld hl, desenho_00 
                                    call drawBoneco
                            _else
                                    cp 0
                                    _if_not nz
                                    
                                            ;call clear_screen
                                            ld bc, $5f07
                                            ld hl, desenho_02 
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


                                            ld hl, desenho_04 
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


    ret



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

        ld hl, row_memory

        ld b, 191
        ld de, $4000

        _do
                ld a, e
                ld (hl), a

                inc hl 
                ld a, d
                ld (hl), a

                call nextLineDown

                inc hl 
        _djnz
 

        ret 


        include "bonecos.asm"
desenho_03:
        db %00000000, %00000000
        db %11111110, %01111111
        db %01111111, %11111110
        db %11110110, %01101111
        db %01111111, %11111110
        db %11111110, %01111111
        db %01111111, %11111110
        db %11111110, %01111111
        db %01111111, %11111110
        db %11111110, %01111111
        db %01111111, %11111110
        db %11111110, %01111111
        db %01111111, %11111110
        db %11110110, %01101111
        db %01111111, %11111110
        db %11111110, %01111111

desenho_04:
        db %00000000, %00000000
        db %11111110, %01111111
        db %00111111, %11111100
        db %11111100, %01011111
        db %01100000, %00000000
        db %11100000, %01110111
        db %01110111, %11100000
        db %11100000, %01110111
        db %01110111, %11100000
        db %11100000, %01110111
        db %01110111, %11100000
        db %00000000, %01110000
        db %01110000, %00000000
        db %00000000, %01100000
        db %01000000, %00000000
        db %00000000, %00000000


obstacle_00:
        db %00000000, %00000000
        db %11111100, %00111111

        db %01100000, %00000110
        db %11111110, %01011111

        db %01011111, %11111010
        db %11111010, %01011111

        db %01011111, %11111010
        db %11111010, %01011111

        db %01011111, %11111010
        db %11111010, %01011111

        db %01011111, %11111010
        db %11111010, %01011111

        db %01011111, %11111010
        db %00000110, %01110000
        
        db %00111111, %11111100
        db %00000000, %00000000



coin_00:
        





last_boneco:
        db $02
last_boneco_pos:
        db $00
        db $00
boneco_pos:
        db $00
        db $5f



clear_boneco
        push hl
        push de

        ld bc, (last_boneco_pos)
        ld hl, desenho_mask
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
                       
                        ld a, (hl)
                        ld (de), a
 

                        inc hl
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


        pop hl
        pop de
 
        ret   



; b: line from top
; c: byte from left
drawBoneco:
        push hl
        call clear_boneco
        pop hl

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

                       call  getPixelAddress
                       
 

                        
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
        ld b,8

        _do
                ld a, (hl)
                ld (de), a 
                inc hl 
                inc de

                ld a, (hl)
                ld (de), a  
                inc hl   

                call nextLineDown
                
                ld a, (hl)
                ld (de), a 
                inc hl 
                dec de


                ld a, (hl)
                ld (de), a  
                inc hl   

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
 
        EI                                      ; Enable interrupts
        RET  

        ; include '../source/sprite.asm'
        org $fa00

        include '../source/font.asm'



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
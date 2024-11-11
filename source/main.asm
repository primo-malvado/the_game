main_loop:

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


    ret
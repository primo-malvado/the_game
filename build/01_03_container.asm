        DEVICE ZXSPECTRUM48
        include "../source/macro/elegant.asm"
        
 

        include "../source/01_03.asm"
 


        SAVEBIN "../dist/01.bin",rom_01_start,rom_01_end - rom_01_start
        SAVEBIN "../dist/03.bin",rom_03_start,rom_03_end - rom_03_start



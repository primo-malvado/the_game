rm dist/*.tap
rm dist/*.bin




sjasmplus build/01_03_container.asm || { echo "\e[31mError: Failed to assemble build/01_03_container.asm\e[0m"; exit 1; }

wine bin/bas2tap -a -s"the_game" source/00.bas  #|| { echo "\e[31mError: erro ao gerar o basic\e[0m"; exit 1; } 

mv source/00.tap dist/the_game.tap

wine bin/taput.exe add -o 63488 -n "LOADER"   dist/01.bin  dist/the_game.tap  || { echo "\e[31mError: erro ao acrescebtar 01.bin a tape \e[0m"; exit 1; }

#screen
wine bin/taput.exe add  source/screen.bin  dist/the_game.tap   || { echo "\e[31mError: erro ao acrescebtar screen.bin a tape \e[0m"; exit 1; }
wine bin/taput.exe add  dist/03.bin  dist/the_game.tap  || { echo "\e[31mError: erro ao acrescebtar 03.bin a tape \e[0m"; exit 1; } 

cp dist/the_game.tap /home/rcosta/Downloads/SpectrumAnalyser/SpectrumGames/the_game.tap

echo "\e[42;37mSucesso\e[0m"
exit 0
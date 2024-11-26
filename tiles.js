import { createCanvas, loadImage } from 'canvas'; 
import fs from 'fs';

const TILE_SIZE = 16; // Defina o tamanho do tile
const imagePath = './mapa.png'; // Defina o caminho da imagem
//const imagePath = '/home/rcosta/Desktop/the_map_game/Koholint Island2.png'; // Defina o caminho da imagem

let idx = 0;

async function splitImageIntoTiles() {
    const image = await loadImage(imagePath);
    const canvas = createCanvas(image.width, image.height);
    const ctx = canvas.getContext('2d');
    ctx.drawImage(image, 0, 0);

    const tilesDir = '/home/rcosta/Desktop/the_map_game/tiles';
    if (!fs.existsSync(tilesDir)) {
        fs.mkdirSync(tilesDir);
    }

    const tiles = new Map();

    let map = [];

    for (let y = 0; y < image.height; y += TILE_SIZE) {

        let rowData = [];
        for (let x = 0; x < image.width; x += TILE_SIZE) {
            const tileCanvas = createCanvas(TILE_SIZE, TILE_SIZE);
            const tileCtx = tileCanvas.getContext('2d');
            tileCtx.drawImage(canvas, x, y, TILE_SIZE, TILE_SIZE, 0, 0, TILE_SIZE, TILE_SIZE);

            const tileBuffer = tileCanvas.toBuffer('image/png');
            const tileKey = tileBuffer.toString('base64');

            if (!tiles.has(tileKey)) {
                let actualIdx = idx++;

                tiles.set(tileKey, { id: actualIdx });

                rowData.push(actualIdx);
                const tilePath = `${tilesDir}/tile_${x}_${y}.png`;
                fs.writeFileSync(tilePath, tileBuffer);

                const altImagePath = 'mapa.png';
                const altImage = await loadImage(altImagePath);
                const altCanvas = createCanvas(altImage.width, altImage.height);
                const altCtx = altCanvas.getContext('2d');
                altCtx.drawImage(altImage, 0, 0);

                const altTileCanvas = createCanvas(TILE_SIZE, TILE_SIZE);
                const altTileCtx = altTileCanvas.getContext('2d');
                altTileCtx.drawImage(altCanvas, x, y, TILE_SIZE, TILE_SIZE, 0, 0, TILE_SIZE, TILE_SIZE);

                const altTileData = altTileCtx.getImageData(0, 0, TILE_SIZE, TILE_SIZE).data;
                let tileAsmData = '';

                for (let i = 0; i < altTileData.length; i += 4 * TILE_SIZE) {
                    let byteStr = '%';
                    for (let j = 0; j < TILE_SIZE; j++) {
                        const alpha = altTileData[i + j * 4 + 0];
                        byteStr += alpha > 128 ? '1' : '0';
                    }
                    tileAsmData += `        db ${byteStr}\n`;
                }

                fs.appendFileSync('./tiles16.asm', tileAsmData);
                
            }else{


                let tile = tiles.get(tileKey);
    
                rowData.push(tile.id);


            }
        }

        map.push("db " + rowData.join(", ")) ;
    }

    fs.appendFileSync('/home/rcosta/Desktop/the_map_game/map.asm', map.join("\n"));
    
    console.log(`Identified ${tiles.size} unique tiles.`);
}

splitImageIntoTiles().catch(console.error);
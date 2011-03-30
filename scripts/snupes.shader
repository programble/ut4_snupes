textures/snupes/sky1
{
	qer_editorimage textures/eagle/sky1.tga
	surfaceparm noimpact
	surfaceparm nolightmap
	surfaceparm sky
//BELOW - TEXTURE BRIGHT CORRECTED - SUN CORRECT
	q3map_sun .5 .37 .19 1 225 55
	//altered x 2.5 for r_overbrightbits 0 and r_mapoverbrightbits 0
	q3map_surfacelight 52
	//q3map_sun <red> <green> <blue> <intensity> <degrees> <elevation>
      skyparms env/sw_txts/eagle 128 -
}

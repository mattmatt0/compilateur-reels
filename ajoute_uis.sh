add_ui()
{
	reel_noui=$1.mp4
	ui=../uis/$1.png
	out=../reels_cropped_with_ui/$1.mp4
	ffmpeg -y -i $reel_noui -i $ui -filter_complex "[0:v][1:v] overlay=0:0" -c:a copy $out
	ffplay $out -y 1080
}


cd reels_cropped
for file in *.mp4
do
	add_ui $(echo $file | sed 's/\.[^. ]*$//')
done

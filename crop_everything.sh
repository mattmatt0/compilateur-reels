crop ()
{
	ffmpeg -y -i ../raw_reels/"$1" -filter:v "crop=ih*(9/16):ih, scale=1080:1920, fps=25" -c:a copy ../reels_cropped/"$1"
}


cd raw_reels
for file in *
do
	crop "$file"
done

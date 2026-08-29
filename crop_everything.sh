crop ()
{
	if [-f $1.srt]
	then
		ffmpeg -y -i ../raw_reels/"$1" -filter:v "crop=ih*(9/16):ih, scale=1080:1920, fps=25, subtitles=$1.srt" -c:a copy ../reels_cropped/"$1"
	else
		echo "ATTENTION : Pas de sous-titres trouvés pour $1 !"
		ffmpeg -y -i ../raw_reels/"$1" -filter:v "crop=ih*(9/16):ih, scale=1080:1920, fps=25" -c:a copy ../reels_cropped/"$1"
	fi


}


cd raw_reels
for file in *.mp4 
do
	echo $file
	crop "$file"
done

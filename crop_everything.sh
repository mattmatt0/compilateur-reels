crop ()
{
	if test -f $1.srt
	then
		set -o xtrace
		ffmpeg -y -i ../raw_reels/"$1" -filter:v "crop=ih*(9/16):ih, scale=1080:1920, fps=25, subtitles=$1.srt" -filter:a "loudnorm=tp=-3" ../reels_cropped/"$1"
	else
		set -o xtrace
		echo "ATTENTION : Pas de sous-titres trouvés pour $1 !"
		ffmpeg -y -i ../raw_reels/"$1" -filter:v "crop=ih*(9/16):ih, scale=1080:1920, fps=25" -filter:a "loudnorm=tp=-3"  ../reels_cropped/"$1"
	fi


}


cd raw_reels
for file in *.mp4 
do
	echo $file
	crop "$file"
done

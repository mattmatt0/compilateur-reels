filter_command="[1:v]null[vtr1];[1:a]anull[atr1];"
id_video=1
id_next_video=2
offset=0
nb_videos=$(ls -1q *.mp4 | wc -l)
echo $nb_videos

for id_video in $(seq $(($nb_videos - 1)))
do
	id_next_video=$(($id_video + 1))
	video=$id_video.mp4
	echo $video
	duree_video=$(ffprobe -v 0 -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 ${video} | tr -d '\r')
	offset=$(echo "$offset + $duree_video - 1" | bc)
	filter_command="${filter_command}[vtr${id_video}][${id_next_video}:v]xfade=transition=slideup:duration=1:offset=${offset}[vtr${id_next_video}];"
	filter_command="${filter_command}[atr${id_video}][$id_next_video:a]acrossfade=d=1[atr$id_next_video];"
done

filter_command="${filter_command}[vtr${id_next_video}][0:v]overlay=0:0[v_final];"
filter_command="${filter_command}[atr${id_next_video}]anull[a_final]"

inputs=""
for id_video in $(seq $nb_videos)
do
	inputs="$inputs -i $id_video.mp4"

done

	
final_command="ffmpeg -y -i ../template_fixe.png $inputs -filter_complex $filter_command -map [v_final] -map [a_final] ../compil_portaits.mp4"
set -o xtrace

$final_command

#ffplay -y 1080 ../compil_portrait.mp4

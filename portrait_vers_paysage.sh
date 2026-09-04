duree_video=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 compil_portrait.mp4 | tr -d '\r')
temps_final=$(echo "$duree_video - 0.5" | bc)
echo $temps_final

ffmpeg -i compil_portrait.mp4 -filter_complex "[0:v]scale=1920:1080,boxblur=20,setsar=1[bg];[0:v]scale=-1:1080[fg];[bg][fg]overlay=(W-w)/2:(H-h)/2[paysage];[paysage]fade=t=in:st=0:d=0.5,fade=t=out:st=$temps_final:d=0.5[vid_ras];[0:a]afade=t=in:st=0:d=0.5,afade=t=out:st=$temps_final:d=0.5[aud_ras]" -map "[vid_ras]" -map "[aud_ras]" final.mp4


 ffmpeg -i compil_portrait.mp4 -filter_complex "[0:v]scale=1920:1080,boxblur=20,setsar=1[bg];[0:v]scale=-1:1080[fg];[bg][fg]overlay=(W-w)/2:(H-h)/2" final.mp4

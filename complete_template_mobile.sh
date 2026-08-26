NB_LIKES=67
NB_COMMENTS=84
DESCRIPTION="Une description un peu longue mais pas trop"
NOM_COMPTE="Arch Linux Fan"

# Redimensionnement de la pdp
magick profile_picture.png \
	-resize 64x64 \
	-gravity center \
	-extent 84x84 \
	pdp.png

# Bordures rondes
magick pdp.png \
        -gravity Center \
        \( -size 84x84 \
           xc:Black \
           -fill White \
           -draw 'circle 42 42 42 1' \
           -alpha Copy \
        \) -compose CopyOpacity -composite \
        -trim pdp_ronde.png

# On insère sur le template
magick composite -geometry +95+1622 pdp_ronde.png template_mobile.png mobile_avec_pdp.png

# Ajout du nom d'utilisateur
magick mobile_avec_pdp.png -draw "font \"fonts/Instagram Sans.ttf\" font-size 40 fill white text 210,1675 '$NOM_COMPTE'" avec_username.png

magick avec_username.png -gravity center -font "fonts/Instagram Sans.ttf" -pointsize 30 -fill white -annotate +415+500 "$NB_LIKES" avec_nb_commentaires.png 

magick avec_nb_commentaires.png -gravity center -font "fonts/Instagram Sans.ttf" -pointsize 30 -fill white -annotate +415+310 "$NB_COMMENTS" avec_nb_commentaires.png 


magick avec_nb_commentaires.png -font "fonts/Instagram Sans.ttf" -pointsize 35 -fill white -annotate +95+1770 "$DESCRIPTION" reel_ui.png

ffmpeg -y -i reel_noui_scaled.mp4 -i reel_ui.png -filter_complex "[0:v][1:v] overlay=0:0" -c:a copy output.mp4

ffplay output.mp4 -y 1080

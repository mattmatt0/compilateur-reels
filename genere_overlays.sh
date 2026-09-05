UI_FONT="../fonts/Instagram Sans.ttf"
genere_overlay ()
{
	file=$1
	NOM_COMPTE=$(sed '1q;d' $file.txt)	
	DESCRIPTION=$(sed '2q;d' $file.txt)
	NB_LIKES=$(sed '3q;d' $file.txt)
	NB_COMS=$(sed '4q;d' $file.txt)	
	PP=$file.png
	# Redimensionnement de la pdp
	magick $PP\
		-gravity center \
		-extent "%[fx:h<w?h:w]x%[fx:h<w?h:w]" \
		-resize 84x84 \
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
	magick composite -geometry +95+1622 pdp_ronde.png ../template_mobile.png mobile_avec_pdp.png

	# Ajout du nom d'utilisateur
	magick mobile_avec_pdp.png -draw "font \"../fonts/Instagram Sans.ttf\" font-size 40 fill white text 210,1675 '$NOM_COMPTE'" avec_username.png

	magick avec_username.png -gravity center -font "../fonts/Instagram Sans.ttf" -pointsize 30 -fill white -annotate +415+500 "$NB_LIKES" avec_nb_commentaires.png 

	magick avec_nb_commentaires.png -gravity center -font "$UI_FONT" -pointsize 30 -fill white -annotate +415+310 "$NB_COMS" avec_nb_commentaires.png 


	magick avec_nb_commentaires.png -font "$UI_FONT" -pointsize 35 -fill white -annotate +95+1770 "$DESCRIPTION" ../uis/$file.png

	

}

cd info_uis
for file in *.txt
do
	genere_overlay $(echo $file | sed 's/\.[^.]*$//')
done

# Redimensionnement de la pdp
magick arch.png \
	-resize 64x64 \
	-gravity center \
	-extent 84x84 \
	pdp.png

# Bordures rondes
magick convert pdp.png \
        -gravity Center \
        \( -size 84x84 \
           xc:Black \
           -fill White \
           -draw 'circle 42 42 42 1' \
           -alpha Copy \
        \) -compose CopyOpacity -composite \
        -trim pdp_ronde.png

# On insère sur le template

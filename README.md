# Compilateur de réels
Une suite de scripts shell avec ffmpeg / imagemagick pour automatiser le montage des réels

## Installation
Dépendances : bc ffmpeg imagemagick
Sous Windows, je recommande d'utiliser msys2 pour tout gérer.

## Utilisation
### Première étape : conversions
- Mettre les réels (tels quels) dans le dossier raw_reels
- Les renommer dans l'ordre (1.mp4, 2.mp4, etc...)
- Renommer les sous-titres en 1.mp4.srt, 2.mp4.srt etc...
- Lancer le script `crop_everything.sh` *depuis la source*. Ce script va rogner les clips s'il y a des bandes sur le côté, les convertir à la taille 1080x1920, et les mettre à 25fps, avant de les écrire dans le dossier `reels_croppped`. Il applique également une normalisation à -3dB (qui a tendance à tout rendre un peu silencieux).
- Vérifier que tous les reels sont correctement adaptés
- Mettre les reels avec une interface déjà gravée dans `reels_cropped_with_ui` 
### Deuxième étape : génération des interfaces (si nécéssaire)
- Si des interfaces sont déjà créées séparément, les mettre directement dans le dossier `uis`, avec le nom correspondant : `<numero du reel>.png`
- Pour les autres, on peut générer une interface, créer dans le dossier `info_uis` un fichier `1.txt` (pour le reel 1 ; pour le reel 2 on créera le fichier `2.txt`, etc.), en suivant le template dans `info_uis/templates/template.txt`.
- Pour la photo de profil, celle-ci doit s'appeler 1.png (pour le 1er reel, 2.png pour le 2e etc.).
- On génère tous les png avec la commande `./genere_overlays.sh` (depuis la racine)
- Enfin, on grave les interfaces avec la commande `./ajoute_uis.sh` (toujours depuis la racine)
- Tous les reels, avec interface gravée, se trouvent alors dans le dossier `reels_cropped_with_ui`
### Troisième étape : compilation
- Dans le dossier `reels_cropped_with_ui` (`cd reels_cropped_with_ui`), lancer la commande `./compile_reels.sh`. Cela va créer un fichier `compil_portait.mp4` au format portrait (sans les bandes sur les côtés, ni les fondus au noir / audio).
- Pour générer la compilation finale, revenir dans le dossier principal `cd ..` et lancer la commande `./portrait_vers_paysage.sh`

15/02/18 Creation du Script

02/03/18 Copie de Linux vers PC. Tout fonctionne, besoin d'ajouter un Tutoriel interactif
05/03/18 Ajout des << Jaune sur le SYSMON + le catch du Joystick
14/03/18 Nouvelle difficulte, reparation des COMM, flux differents selon difficulte
15/03/18 Nouveau Generateur d'evenements etc.

13/05/18 Multiple clavier avec KbQueueCheck revoir dans l'Updtae Keyboard et l'INIT MATB
00/06/18 Une fenetre pour feedback
00/06/18 Chargement des sons à l'avance
00/06/18 Message HIT ENTER a chaque fois

TO DO/CHECK : Pas de comm à T0, pas laisser descendre les value des comm trop bas pour le log

%% REPLIQUE DE LA NASA MATB
On est sur code très très sale pour l'instant, 
95% des variables ont des noms illisibles 
Certains script sont codé directement avec le cul
Certaines choses fonctionne sans vraiment que je sache pourquoi :)

Après ça marche ! et bien :) Ca affiche quasi en temps réel, ca stream,  
et ça tolère en plus quelque oublie de toolbox, de branchements de joystick
Après ca peut crasher si on fait pas exactement ce que je faisais :)

Le fichier pricipale c'est le script MATB, juste à faire PLAY :)
Les paramètres à config sont directement dans le script
Nombre de scénario, duree etc...
Tout est modifiable (avec plus ou moins de difficultés)
Le script était prévu pour 2 joueurs donc ça impliquait 2 claviers
2 eye tracker et le stream en double etc... 
et du coup la difficulté est assez élevé tel quel pour 1 seul joueur. 

Dans le dossier AUDIO y'a juste les fichiers audio de la MATB original que je reutilise
Dans le dossier DATA les data seront sauvegardés (en .mat)
Dans le dossier LOG, le log en txt (ce qui y'a de plus robuste comme infos) 
et le diary (le journal de console matlab) seront stockées avec la date et l'here en titre

-- Si besoin : 
J'ai des scripts de visualisation en live de Double biosemi, des offsets et des spectre
des ECG et des eyetracker si besoin 
Je faisais ça via un pc sur le réseau via le LSL. Parceque quand un biosmi stream via l'app LSL
Actiview ne peut pas être en route en meme temps et du coup on voit pas les signaux

J'ai des script qui relise les log.txt et qui regenere des .mat pour quand ça a crashé.
J'ai des script qui font des rapport pdf sur le comportement et l'eyetrack, 
exemple dans le dossier log si ça peut vous interessé

J'ai essayé de commenter, j'ai essayé d'expliquer la ou je me suis dit que vous voudriez modifier. 
J'ai tout codé à la main de A à Z donc si vous avez des questions n'hésitez pas
Je suis content que ce code servent à quelqu'un :)

# Killers

Killers est un projet de jeu multijoueur en 3D à la première personne : des chasseurs poursuivent des survivants dans un labyrinthe rempli de cachettes, de pièges et de passages secrets. Les survivants disposent aussi d'équipements de fuite, dont la course sur les murs et une grenade fumigène.

## État du projet

Prototype local réalisé le 11 octobre 2026 dans `../killers-game` : une arène 3D avec sol, murs, passages, collisions, déplacement à la première personne et entraînement contre un personnage contrôlé par le jeu. La branche, les trois vies du survivant et les 30 secondes de cachette sont jouables. Le multijoueur, les autres équipements, le dash et la poursuite chronométrée de quatre minutes restent à réaliser.

La base technique est Godot, avec GDScript pour le développement prévu. Le projet est initialisé pour Godot 4.7 avec le rendu Compatibility. Les plateformes visées sont les ordinateurs, avec publication possible sur Steam, et les mobiles Android et iOS.

Le chronomètre de combat est commun à tous les joueurs. Tous les réglages d'équilibrage doivent être faciles à modifier ; les recharges de départ sont de 120 secondes pour le dash et de 60 secondes pour la lance, avec des délais indépendants par joueur et par arme.

Le prototype commence avec Joueur 1 à Joueur 4, sans comptes ni base de données. Une version suivante ajoutera les comptes, les pseudonymes, les scores sauvegardés et un classement des joueurs qui gagnent le plus, avec des vues de type top 5 ou top 200 configurables.

## Lancer le mode contre IA

1. Ouvrir [killers-game/project.godot](../killers-game/project.godot) dans Godot. Si le projet était déjà ouvert, accepter le rechargement des fichiers modifiés si demandé.
2. Cliquer sur **Lancer le projet ▶** ou utiliser **F5** (éventuellement **Fn + F5** sur Mac). La scène principale est déjà configurée.
3. Choisir **Survivant** ou **Chasseur**. L'adversaire reçoit le rôle opposé ; les 30 secondes de cachette commencent et la souris est capturée pour jouer.

L'adversaire porte une tenue orange en chasseur, turquoise en survivant. Son nom est masqué par les murs. Dans les deux rôles, il choisit des destinations aléatoires et contourne les obstacles. Il ne traque pas encore le joueur et ne prend pas de décisions de fuite. En chasseur, il se tourne vers vous et tente un coup de branche lorsque vous passez à portée, sans obstacle entre vous.

| Commande | Action |
| --- | --- |
| ZQSD, WASD ou flèches | Se déplacer |
| Souris | Regarder autour de soi |
| Maj maintenue | Marcher plus lentement |
| Clic gauche, en chasseur | Frapper avec la branche |
| R | Revenir au point de départ, sans récupérer de vie |
| Échap | Ouvrir le menu et libérer la souris ; appuyer à nouveau pour reprendre |

Le survivant commence avec **trois vies**. Il dispose de **30 secondes pour se cacher**, pendant lesquelles le chasseur attend et ne peut pas attaquer. En chasseur, approchez-vous du survivant, visez-le et faites un clic gauche : la branche retire une vie à portée de 1,8 m, après une préparation de 0,25 seconde. Un mur bloque le coup et le survivant peut esquiver. La recharge est de 1 seconde dès l'activation.

Après une touche, les deux personnages sont replacés et le survivant conserve ses vies restantes ; il dispose à nouveau de 30 secondes pour se cacher. À zéro vie, l'entraînement s'arrête et propose de recommencer. Ce retour des deux personnages concerne seulement l'entraînement 1 contre 1 ; le futur 2 contre 2 conservera la réapparition individuelle. Le compte à rebours de quatre minutes n'est pas encore ajouté.

Le menu et la perte de focus arrêtent aussi l'IA, les attaques et les délais. **Reprendre** continue l'entraînement ; choisir un rôle ou cliquer sur **Recommencer l'entraînement** replace les deux personnages au départ et restaure les trois vies. La touche **R** replace uniquement le joueur, sans le soigner ; elle est désactivée pour le chasseur pendant la cachette. Utiliser le bouton d'arrêt de Godot pour terminer l'essai.

## Modifier les premiers réglages

Dans le panneau **Système de fichiers** de Godot, sélectionner [config/player_settings.tres](../killers-game/config/player_settings.tres). L'inspecteur permet de modifier les vitesses de course du survivant (`Run Speed`) et du chasseur (`Hunter Run Speed`), la vitesse de marche, l'accélération, la gravité, la sensibilité de la souris, le champ de vision et la limite verticale du regard. Ces vitesses de rôle servent au joueur et à l'IA. Enregistrer puis relancer le jeu pour comparer les valeurs.

Les valeurs initiales de déplacement sont des réglages d'essai : survivant à 5 m/s, chasseur à 5,2 m/s et marche à 2,5 m/s. La recharge du dash et les autres armes ne sont pas encore implémentées.

Dans [config/ai_settings.tres](../killers-game/config/ai_settings.tres), régler `Speed Multiplier` pour ralentir ou accélérer uniquement l'IA, `Destination Pause` pour son arrêt entre deux destinations, `Minimum Trip Distance` pour la longueur minimale visée et `Stuck Timeout` pour le délai avant de changer de trajet lorsqu'elle est bloquée. Par exemple, un multiplicateur de 0,7 facilite la poursuite.

Dans [config/combat_settings.tres](../killers-game/config/combat_settings.tres), modifier `Starting Lives` (vies), `Hiding Seconds` (cachette), `Branch Range` (portée), `Branch Half Angle` (tolérance de visée), `Branch Windup` (préparation) et `Branch Cooldown` (recharge). Ces réglages sont communs au joueur et au chasseur IA. Pour tester rapidement les coups, mettre temporairement `Hiding Seconds` à 0, enregistrer et relancer. Les réglages de la branche sont des valeurs d’essai.

La carte se modifie dans [scenes/practice_arena.tscn](../killers-game/scenes/practice_arena.tscn). Sous `Geometry`, chaque mur possède un maillage visible et une forme de collision ; modifier leurs dimensions ensemble. Le personnage est une scène séparée : [scenes/player.tscn](../killers-game/scenes/player.tscn).

L'IA utilise [scenes/wandering_bot.tscn](../killers-game/scenes/wandering_bot.tscn), avec un corps et des membres animés simples. Le nœud `Navigation` calcule au démarrage une grille de chemins à partir des collisions du décor sur la couche 1. Les personnages utilisent la couche 2. Cette navigation est destinée à l'arène actuelle, plate et fermée : si le sol est agrandi, adapter `Grid Region` ; une carte avec étages, trous ou obstacles mobiles demandera une évolution de la navigation.

## Validation locale

Vérifié localement avec Godot 4.7.2 sur Mac : import du projet, lancement sans interface, puis lancement graphique Compatibility et inspection des captures du menu et de l'arène. Les contrôles automatisés ont validé le sol, les collisions, la vitesse et sa configuration, la normalisation des diagonales, la direction du déplacement, la limite du regard, l'arrêt au menu et le retour au départ.

Pour le mode IA, les contrôles valident les deux choix de rôle, les vitesses correspondantes, le contournement du mur central, la pause et le redémarrage. Une simulation déterministe de deux minutes vérifie les changements de destination et le respect du sol, des murs et des limites de l'arène. Les vues des deux rôles et les menus ont été inspectés en lancement graphique sur Mac.

Les tests de combat vérifient les trois vies, le clic gauche, la préparation et la recharge, la portée, les murs, l’esquive, les phases de cachette, la pause, la fin à zéro vie, le redémarrage, les deux rôles et la configuration. Les captures graphiques permettent aussi de vérifier la branche et les indications de vie.

Pour reproduire les contrôles depuis le dossier `games`, avec le binaire Godot disponible sous le nom `godot` :

```sh
godot --headless --path killers-game --editor --import --quit
godot --headless --fixed-fps 60 --path killers-game --script res://tests/test_first_step.gd
godot --headless --fixed-fps 60 --path killers-game --script res://tests/test_ai_training.gd
godot --headless --fixed-fps 60 --path killers-game --script res://tests/test_branch_combat.gd
```

Les commandes tactiles, les performances mobiles et une partie sur deux appareils ne sont pas encore validées.

## Reprendre le travail

Dans Godot, ouvrir le projet existant ou importer [killers-game/project.godot](../killers-game/project.godot). Le code, les scènes, les ressources et les réglages du jeu seront dans `killers-game`. Ce dossier `killers` conserve la documentation. Les deux appartiennent au même dépôt Git `games`.

Lire d'abord [la fiche de conception](GAME_DESIGN.md). Elle distingue les règles demandées, les propositions à tester et les décisions encore ouvertes. Les [consignes de reprise](AGENTS.md) permettent de conserver cette distinction pendant le développement.

Le mode IA permet maintenant de tester une poursuite localement. Le chronomètre de quatre minutes, les autres équipements, les réactions de poursuite ou de fuite de l'IA et le mode à deux joueurs en réseau seront les évolutions suivantes à choisir.

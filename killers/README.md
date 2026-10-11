# Killers

Killers est un projet de jeu multijoueur en 3D à la première personne : des chasseurs poursuivent des survivants dans un labyrinthe rempli de cachettes, de pièges et de passages secrets. Les survivants disposent aussi d'équipements de fuite, dont la course sur les murs et une grenade fumigène.

## État du projet

Prototype local réalisé le 11 octobre 2026 dans `../killers-game` : une arène 3D avec sol, murs, passages, collisions, déplacement à la première personne et entraînement contre un personnage contrôlé par le jeu. Le multijoueur, les armes, le dash et les manches chronométrées restent à réaliser.

La base technique est Godot, avec GDScript pour le développement prévu. Le projet est initialisé pour Godot 4.7 avec le rendu Compatibility. Les plateformes visées sont les ordinateurs, avec publication possible sur Steam, et les mobiles Android et iOS.

Le chronomètre de combat est commun à tous les joueurs. Tous les réglages d'équilibrage doivent être faciles à modifier ; les recharges de départ sont de 120 secondes pour le dash et de 60 secondes pour la lance, avec des délais indépendants par joueur et par arme.

Le prototype commence avec Joueur 1 à Joueur 4, sans comptes ni base de données. Une version suivante ajoutera les comptes, les pseudonymes, les scores sauvegardés et un classement des joueurs qui gagnent le plus, avec des vues de type top 5 ou top 200 configurables.

## Lancer le mode contre IA

1. Ouvrir [killers-game/project.godot](../killers-game/project.godot) dans Godot. Si le projet était déjà ouvert, accepter le rechargement des fichiers modifiés si demandé.
2. Cliquer sur **Lancer le projet ▶** ou utiliser **F5** (éventuellement **Fn + F5** sur Mac). La scène principale est déjà configurée.
3. Choisir **Survivant** ou **Chasseur**. L'adversaire reçoit le rôle opposé et commence à se déplacer au hasard ; la souris est capturée pour jouer.

L'adversaire porte une tenue orange en chasseur, turquoise en survivant. Son nom est masqué par les murs. Dans les deux rôles, il choisit des destinations aléatoires et contourne les obstacles. Il ne traque pas encore le joueur et ne prend pas de décisions de fuite : cette étape sert à essayer les déplacements et la poursuite d'une cible mobile.

| Commande | Action |
| --- | --- |
| ZQSD, WASD ou flèches | Se déplacer |
| Souris | Regarder autour de soi |
| Maj maintenue | Marcher plus lentement |
| R | Revenir au point de départ |
| Échap | Ouvrir le menu et libérer la souris ; appuyer à nouveau pour reprendre |

Le menu et la perte de focus arrêtent aussi l'IA. **Reprendre** continue l'entraînement ; choisir un rôle ou cliquer sur **Recommencer l'entraînement** replace les deux personnages au départ. La touche **R** replace uniquement le joueur. Utiliser le bouton d'arrêt de Godot pour terminer l'essai.

## Modifier les premiers réglages

Dans le panneau **Système de fichiers** de Godot, sélectionner [config/player_settings.tres](../killers-game/config/player_settings.tres). L'inspecteur permet de modifier les vitesses de course du survivant (`Run Speed`) et du chasseur (`Hunter Run Speed`), la vitesse de marche, l'accélération, la gravité, la sensibilité de la souris, le champ de vision et la limite verticale du regard. Ces vitesses de rôle servent au joueur et à l'IA. Enregistrer puis relancer le jeu pour comparer les valeurs.

Les valeurs initiales de déplacement sont des réglages d'essai : survivant à 5 m/s, chasseur à 5,2 m/s et marche à 2,5 m/s. Les futures recharges du dash et des armes ne sont pas encore implémentées.

Dans [config/ai_settings.tres](../killers-game/config/ai_settings.tres), régler `Speed Multiplier` pour ralentir ou accélérer uniquement l'IA, `Destination Pause` pour son arrêt entre deux destinations, `Minimum Trip Distance` pour la longueur minimale visée et `Stuck Timeout` pour le délai avant de changer de trajet lorsqu'elle est bloquée. Par exemple, un multiplicateur de 0,7 facilite la poursuite.

La carte se modifie dans [scenes/practice_arena.tscn](../killers-game/scenes/practice_arena.tscn). Sous `Geometry`, chaque mur possède un maillage visible et une forme de collision ; modifier leurs dimensions ensemble. Le personnage est une scène séparée : [scenes/player.tscn](../killers-game/scenes/player.tscn).

L'IA utilise [scenes/wandering_bot.tscn](../killers-game/scenes/wandering_bot.tscn), avec un corps et des membres animés simples. Le nœud `Navigation` calcule au démarrage une grille de chemins à partir des collisions du décor sur la couche 1. Les personnages utilisent la couche 2. Cette navigation est destinée à l'arène actuelle, plate et fermée : si le sol est agrandi, adapter `Grid Region` ; une carte avec étages, trous ou obstacles mobiles demandera une évolution de la navigation.

## Validation locale

Vérifié localement avec Godot 4.7.2 sur Mac : import du projet, lancement sans interface, puis lancement graphique Compatibility et inspection des captures du menu et de l'arène. Les contrôles automatisés ont validé le sol, les collisions, la vitesse et sa configuration, la normalisation des diagonales, la direction du déplacement, la limite du regard, l'arrêt au menu et le retour au départ.

Pour le mode IA, les contrôles valident les deux choix de rôle, les vitesses correspondantes, le contournement du mur central, la pause et le redémarrage. Une simulation déterministe de deux minutes vérifie les changements de destination et le respect du sol, des murs et des limites de l'arène. Les vues des deux rôles et les menus ont été inspectés en lancement graphique sur Mac.

Pour reproduire les contrôles depuis le dossier `games`, avec le binaire Godot disponible sous le nom `godot` :

```sh
godot --headless --path killers-game --editor --import --quit
godot --headless --fixed-fps 60 --path killers-game --script res://tests/test_first_step.gd
godot --headless --fixed-fps 60 --path killers-game --script res://tests/test_ai_training.gd
```

Les commandes tactiles, les performances mobiles et une partie sur deux appareils ne sont pas encore validées.

## Reprendre le travail

Dans Godot, ouvrir le projet existant ou importer [killers-game/project.godot](../killers-game/project.godot). Le code, les scènes, les ressources et les réglages du jeu seront dans `killers-game`. Ce dossier `killers` conserve la documentation. Les deux appartiennent au même dépôt Git `games`.

Lire d'abord [la fiche de conception](GAME_DESIGN.md). Elle distingue les règles demandées, les propositions à tester et les décisions encore ouvertes. Les [consignes de reprise](AGENTS.md) permettent de conserver cette distinction pendant le développement.

Le mode IA permet maintenant de tester une poursuite localement. Les armes, les réactions de poursuite ou de fuite de l'IA et le mode à deux joueurs en réseau seront les évolutions suivantes à choisir.

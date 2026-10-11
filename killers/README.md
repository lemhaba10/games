# Killers

Killers est un projet de jeu multijoueur en 3D à la première personne : des chasseurs poursuivent des survivants dans un labyrinthe rempli de cachettes, de pièges et de passages secrets. Les survivants disposent aussi d'équipements de fuite, dont la course sur les murs et une grenade fumigène.

## État du projet

Conception initiale du 11 octobre 2026. Aucun prototype jouable n'est encore implémenté.

La base technique proposée est Godot avec GDScript. Les plateformes visées sont les ordinateurs, avec publication possible sur Steam, et les mobiles Android et iOS.

Le chronomètre de combat est commun à tous les joueurs. Tous les réglages d'équilibrage doivent être faciles à modifier ; les recharges de départ sont de 120 secondes pour le dash et de 60 secondes pour la lance, avec des délais indépendants par joueur et par arme.

Le prototype commence avec Joueur 1 à Joueur 4, sans comptes ni base de données. Une version suivante ajoutera les comptes, les pseudonymes, les scores sauvegardés et un classement des joueurs qui gagnent le plus, avec des vues de type top 5 ou top 200 configurables.

## Reprendre le travail

Lire d'abord [la fiche de conception](GAME_DESIGN.md). Elle distingue les règles demandées, les propositions à tester et les décisions encore ouvertes. Les [consignes de reprise](AGENTS.md) permettent de conserver cette distinction pendant le développement.

La vue à travers les yeux du personnage est confirmée. Prochaine étape : créer une petite arène 3D pour tester le déplacement, la poursuite et une première arme. Le multijoueur devra être intégré tôt pour pouvoir essayer une partie ensemble.

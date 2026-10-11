# Consignes pour le projet Killers

## Contexte et référence

- Répondre en français, avec des explications accessibles aux créateurs du jeu.
- Le dépôt Git se trouve dans le dossier parent `games`. Conserver le jeu et sa documentation dans `killers`. Ne pas créer de dépôt Git imbriqué.
- Lire `GAME_DESIGN.md` avant de proposer ou modifier une mécanique de jeu.
- La fiche distingue les règles demandées, les propositions de prototype et les décisions ouvertes. Une proposition ne constitue pas une validation des créateurs.
- Après une décision explicite des créateurs, mettre à jour la section correspondante et le journal des décisions. Ne pas transformer silencieusement une hypothèse en règle confirmée.

## Invariants de conception

- Jeu en 3D à la première personne, à travers les yeux du personnage pour les deux rôles ; modes 1 chasseur contre 1 survivant et 2 chasseurs contre 2 survivants.
- Trois vies par survivant, trois emplacements d'équipement par chasseur, 30 secondes pour se cacher et quatre minutes de survie.
- Chronomètre de combat commun à tous les joueurs, géré par le jeu. Ne pas confondre ce choix confirmé avec les règles encore proposées de reprise du chronomètre après une perte de vie.
- Recharge par défaut du dash de déplacement : 120 secondes dès l'activation, pour les deux rôles. Recharge par défaut de la lance : 60 secondes dès l'activation. Chaque joueur et chaque arme disposent de recharges indépendantes.
- Tous les paramètres d'équilibrage doivent être facilement configurables sans modifier le code des mécaniques. Les valeurs par défaut sont des points de départ, pas des constantes dispersées dans le code.
- Premier prototype avec Joueur 1 à Joueur 4 et des identifiants de session, sans comptes ni base de données. Comptes, pseudonymes, scores persistants et classement par victoires sont prévus pour une version suivante ; top 5 et top 200 sont des vues envisagées et configurables.
- En 2 contre 2, seul le survivant touché réapparaît ; les autres continuent. Ne pas réinitialiser toute la partie après une touche.
- Les cinq premiers équipements de chasseur proposés par les créateurs sont communs : branche, règle, seringue, lance et bâton du tonnerre.
- Les survivants ont aussi des équipements de fuite : course sur les murs et fumigène gênant la vision des chasseurs sans aveugler les survivants. Leur nombre d'emplacements, rareté et équilibrage restent à valider.
- Concevoir chaque pouvoir avec une possibilité de réponse. Rechercher le plaisir des deux rôles, la lisibilité et des commandes utilisables sur mobile.

## Développement

- Godot et GDScript sont la base proposée, à confirmer avant de créer le projet moteur.
- Construire d'abord le prototype décrit dans la fiche, avec des ressources de configuration centralisées pour les règles, armes, déplacements et interactions. Le comportement, l'affichage et la validation réseau doivent lire les mêmes valeurs.
- Vérifier tôt une vraie partie entre deux instances ; distinguer une simulation locale d'une validation sur deux appareils ou sur Internet.
- Respecter le report explicite des comptes, de la base de données et du classement à une version suivante. Ne pas ajouter de boutique ou de serveur payant au premier prototype sans besoin établi.
- Pour le futur classement, séparer les résultats de test des résultats officiels et prévoir une validation de confiance, sans compter deux fois une même partie. Le barème et la période ne sont pas encore confirmés.
- Garder les identifiants, clés de signature et secrets hors du dépôt.
- Ne pas présenter une fonctionnalité documentée comme implémentée, testée ou publiée.

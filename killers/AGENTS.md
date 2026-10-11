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
- En 2 contre 2, seul le survivant touché réapparaît ; les autres continuent. Ne pas réinitialiser toute la partie après une touche.
- Les cinq premiers équipements de chasseur proposés par les créateurs sont communs : branche, règle, seringue, lance et bâton du tonnerre.
- Les survivants ont aussi des équipements de fuite : course sur les murs et fumigène gênant la vision des chasseurs sans aveugler les survivants. Leur nombre d'emplacements, rareté et équilibrage restent à valider.
- Concevoir chaque pouvoir avec une possibilité de réponse. Rechercher le plaisir des deux rôles, la lisibilité et des commandes utilisables sur mobile.

## Développement

- Godot et GDScript sont la base proposée, à confirmer avant de créer le projet moteur.
- Construire d'abord le prototype décrit dans la fiche, en gardant les réglages d'équilibrage modifiables.
- Vérifier tôt une vraie partie entre deux instances ; distinguer une simulation locale d'une validation sur deux appareils ou sur Internet.
- Ne pas ajouter de compte joueur, boutique, classement ou serveur payant au premier prototype sans besoin établi.
- Garder les identifiants, clés de signature et secrets hors du dépôt.
- Ne pas présenter une fonctionnalité documentée comme implémentée, testée ou publiée.

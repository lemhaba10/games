# Killers règles et conception du jeu

Version initiale du 11 octobre 2026.

Killers est un jeu multijoueur de cache-cache et de poursuite en 3D. Les chasseurs doivent prendre les survivants de vitesse, comprendre leurs feintes et utiliser leurs équipements. Les survivants doivent exploiter les cachettes, les chemins du labyrinthe et les mouvements pour leur échapper.

Le plaisir recherché est partagé : réussir une poursuite doit être satisfaisant, et réussir une évasion aussi. Les manches doivent produire des surprises et donner envie de rejouer en changeant de rôle.

## Statut des règles

Les sections « Règles demandées » et « Décisions confirmées » consignent les choix exprimés par les créateurs. Toutes les valeurs introduites dans les sections « Proposition » sont des réglages de départ à essayer, pas des décisions déjà approuvées.

La caméra, certaines règles de chronomètre et les interactions entre pouvoirs restent à choisir. Cette fiche décrit le jeu envisagé ; elle ne décrit pas un logiciel déjà réalisé.

## Règles demandées

| Élément | Règle |
| --- | --- |
| Univers | Jeu en 3D dans une carte en forme de labyrinthe. |
| Mode 1 contre 1 | Un chasseur contre un survivant. |
| Mode 2 contre 2 | Deux chasseurs contre deux survivants. |
| Équipement du chasseur | Trois armes ou outils dans son inventaire, choisis avant de jouer. |
| Préparation | Le survivant dispose de 30 secondes pour se cacher. |
| Poursuite | Le survivant doit survivre quatre minutes. |
| Vies | Chaque survivant possède trois vies. Une touche qui inflige des dégâts retire une vie. |
| Après une touche | S'il lui reste des vies, le survivant bénéficie à nouveau de 30 secondes pour se cacher. |
| Mobilité | Vitesses équilibrées entre les rôles et accélérations temporaires disponibles après un délai. |
| Feintes | Les survivants peuvent faire des feintes, des glissades et d'autres mouvements d'esquive. Les chasseurs disposent de réponses à ces mouvements. |
| Pièges | Les chasseurs peuvent déposer des objets pour bloquer un trajet ou orienter la fuite. |
| Secrets | Des leviers cachés, activés dans le bon ordre, ouvrent une pièce secrète qui se referme. Le chasseur peut reproduire la combinaison pour entrer. Le survivant risque alors d'être coincé. |
| Raretés | Équipements communs, rares, épiques, légendaires ; autres catégories possibles plus tard. |
| Évolution | Ajouter progressivement des armes et des situations nouvelles pour renouveler le plaisir de jouer. |

Le terme « chasseur » désigne ici le rôle aussi appelé « tueur » dans l'idée initiale. Le terme « survivant » désigne le joueur poursuivi.

## Décisions confirmées

- En **2 contre 2**, lorsqu'un survivant est touché, **seul ce survivant réapparaît**. Les autres joueurs continuent à jouer : ni retour collectif au départ, ni nouvelle préparation pour tout le monde.
- La vue doit être en 3D. Le choix entre première et troisième personne n'est pas encore arrêté.
- Les cinq premiers équipements décrits plus bas appartiennent tous à la catégorie **commune**.

## Proposition de déroulement d'une partie

### Début de partie

1. Choisir le mode et attribuer les rôles.
2. Chaque chasseur choisit trois équipements différents parmi ceux disponibles.
3. Chaque survivant commence avec trois vies.
4. Pendant 30 secondes, les survivants explorent et se cachent. Les chasseurs restent dans une zone de départ qui ne permet pas de voir où ils partent.
5. Le chronomètre de quatre minutes démarre à la libération des chasseurs.

### Touche et perte de vie

Une touche valide avec une arme à dégâts retire une vie. Un effet de détection ou de gêne ne retire pas automatiquement une vie : chaque équipement précise son comportement.

À la perte d'une vie, interrompre immédiatement les dégâts sur ce survivant. Plusieurs attaques arrivant simultanément ne doivent pas lui retirer plusieurs vies avant sa réapparition. Annuler les effets de ralentissement et d'aveuglement à sa réapparition.

À zéro vie, le survivant est éliminé pour cette partie. En 2 contre 2, il peut suivre son coéquipier sans caméra libre lui permettant de révéler la position des chasseurs.

### Nouvelle cachette en 1 contre 1

Proposition fidèle à l'idée de « recommencer » : si le survivant a encore une vie, replacer les deux joueurs, conserver ses vies restantes, donner 30 secondes pour se cacher, puis recommencer une poursuite de quatre minutes.

Cette règle peut produire une partie approchant 13 minutes 30 secondes si les trois poursuites durent presque quatre minutes. Tester si cette durée reste amusante ; ne pas raccourcir silencieusement les quatre minutes ou supprimer les trois vies.

### Nouvelle cachette en 2 contre 2

La réapparition individuelle est confirmée. Pour rendre les 30 secondes personnelles compatibles avec la poursuite des autres joueurs, proposition de prototype :

- Le survivant perd une vie et réapparaît à un point éloigné des chasseurs, sans indication de sa position.
- Il dispose de 30 secondes pour se recacher ; pendant cette période, il est invisible aux adversaires, impossible à toucher et sans collision avec les autres joueurs.
- Pendant cette protection, il ne peut pas activer de mécanisme, bloquer un passage ou déclencher un piège. Les adversaires et leurs positions ne lui sont pas affichés : cette phase ne doit pas servir à espionner pour son équipe.
- La fin de protection est clairement indiquée au survivant. Aucun compte à rebours public ne révèle sa position.
- Le chronomètre commun de quatre minutes continue. Il n'est pas réinitialisé par une touche.
- Si les deux survivants se recachent simultanément, les chasseurs peuvent se déplacer et préparer leurs pièges, mais ne détectent pas les survivants protégés.

Ce fonctionnement reste **à tester et à valider**, notamment la longueur de la protection. Il favorise potentiellement beaucoup les survivants. Une alternative à discuter serait une zone de réapparition avec plusieurs sorties cachées, à la place de l'invisibilité temporaire.

### Victoire

Proposition : les chasseurs gagnent lorsque tous les survivants ont perdu leurs trois vies avant la fin du temps. Les survivants gagnent si au moins l'un d'eux possède encore une vie lorsque le chronomètre atteint zéro.

Dans cette proposition, un survivant en train de se recacher compte encore comme vivant. Si la dernière élimination et la fin du temps surviennent ensemble, comparer les instants validés par la partie ; en cas d'égalité exacte, donner la victoire aux survivants. Cette convention et l'avantage de la protection en fin de partie devront être éprouvés.

Après la partie, proposer de rejouer en inversant les rôles, puis afficher les résultats des deux côtés. La revanche doit pouvoir se lancer rapidement.

## Proposition de caméra et de visibilité

Commencer les essais en **première personne**, avec la caméra à hauteur des yeux. Cette vue favorise les surprises et les cachettes. Une troisième personne rapprochée peut être comparée si les créateurs préfèrent voir leur personnage.

La 3D seule ne garantit pas qu'on soit caché : les murs doivent réellement masquer les personnages, les noms ne doivent pas apparaître à travers les obstacles et aucun indicateur ne doit donner en permanence la position adverse. En troisième personne, vérifier particulièrement la possibilité de regarder derrière un angle sans exposer son personnage.

Prévoir une sensibilité réglable, des commandes simples et des effets visuels brefs. La caméra définitive doit être essayée sur téléphone avant de concevoir toutes les animations.

## Proposition de vitesse et de boost

Les distances et vitesses ci-dessous supposent que l'échelle de la carte est réglée en mètres.

| Action | Survivant | Chasseur |
| --- | --- | --- |
| Course normale | 5 m/s | 5,2 m/s |
| Marche discrète | 2,5 m/s | 2,5 m/s |
| Boost | Vitesse multipliée par 1,4 pendant 1 seconde | Vitesse multipliée par 1,4 pendant 1 seconde |
| Recharge du boost | 12 secondes après la fin du boost | 12 secondes après la fin du boost |
| Charges disponibles | Une, prête au début de la poursuite | Une, prête au début de la poursuite |

Le léger avantage de course du chasseur met la pression dans une ligne droite. Le survivant gagne du terrain en choisissant mieux son trajet, en glissant et en feintant. Ces nombres servent uniquement à commencer les essais : les dimensions de la carte et les équipements changeront fortement l'équilibre.

Afficher clairement la disponibilité du boost. Une touche distincte déclenche l'accélération ; courir normalement ne consomme pas de ressource au premier prototype. En 2 contre 2, les recharges continuent normalement lors d'une réapparition individuelle, sans rendre artificiellement des charges.

## Proposition de feintes et de réponses

| Action du survivant | Intérêt | Réponse du chasseur |
| --- | --- | --- |
| Glissade de 0,6 seconde, recharge de 5 secondes | Passer sous un obstacle bas et modifier rapidement sa trajectoire | Anticiper la sortie, contourner ou préparer son attaque ; la glissade ne rend pas invincible |
| Changement de direction au dernier instant | Faire manquer une attaque ou une charge | Attendre la feinte, puis attaquer pendant le retour à la course |
| Marche discrète | Réduire les indices sonores | Utiliser la règle et vérifier les cachettes |
| Boost à un embranchement | Rompre le contact visuel | Garder son propre boost ou utiliser un autre chemin |
| Saut bas | Franchir certains petits obstacles | Emprunter un raccourci ou suivre ; le saut n'annule pas les dégâts |

Éviter d'empiler trop de boutons au début. Prototype : déplacement, caméra, boost, interaction et glissade. Ajouter le saut si la carte lui donne un vrai rôle. Donner aux chasseurs les mouvements de base nécessaires pour que les passages réservés aux survivants ne créent pas de refuges impossibles à atteindre.

## Équipements communs demandés

Les comportements de la deuxième colonne viennent des créateurs. Les dégâts, durées et recharges de la troisième colonne sont des **propositions de prototype**.

| Équipement | Effet demandé | Réglage initial proposé | Possibilité de réponse |
| --- | --- | --- | --- |
| Branche | Arme simple, sans pouvoir spécial | Corps à corps, portée de 1,8 m, retire une vie, préparation de 0,25 seconde, délai de 1 seconde entre attaques | Sortir de portée ou faire manquer le coup |
| Règle | Affiche la distance de l'ennemi jusqu'à 30 m ; ne détecte rien au-delà | À l'activation, indique pendant 2 secondes la distance arrondie du survivant actif le plus proche ; recharge de 8 secondes ; aucun dégât | Changer de trajet entre deux mesures ; aucun nom ni direction révélé |
| Seringue | Au corps à corps, inverse les commandes et réduit la vitesse de 50 % | Portée de 1,5 m, effet de 2 secondes, recharge de 15 secondes ; ne retire pas de vie dans cette première proposition | Éviter la portée courte et exploiter le délai après une attaque manquée |
| Lance | Permet une ruée vers l'ennemi | Charge dans la direction visée, jusqu'à 6 m en 0,35 seconde ; retire une vie au contact ; recharge de 10 secondes ; s'arrête contre un mur | Esquiver latéralement pendant le bref signal de préparation |
| Bâton du tonnerre | Aveugle un ennemi avec un éclair dans un rayon de 15 m | Affecte les survivants visibles à 15 m maximum ; gêne visuelle de 1 seconde ; recharge de 18 secondes ; aucun dégât | Se mettre derrière un mur pendant l'annonce de 0,4 seconde |

### Proposition d'interactions entre équipements

- La règle fonctionne à travers les murs, mais ne révèle pas le chemin à suivre. C'est un outil de recherche, pas une vision à travers les obstacles.
- La seringue inverse les directions de déplacement, sans inverser la caméra ni les menus. Sur mobile, elle inverse de la même façon les directions du joystick. Son ralentissement affecte aussi la vitesse pendant un boost.
- Les effets de deux seringues ne se cumulent pas et ne prolongent pas un effet déjà actif. Accorder ensuite 3 secondes d'immunité à la seringue pour éviter une immobilisation répétée par deux chasseurs.
- Le tonnerre produit un voile bref et un effet sonore reconnaissable ; il conserve une perception minimale du décor. Accorder 3 secondes d'immunité à un nouvel aveuglement après la fin de l'effet.
- La lance ne traverse pas les murs et ne se cumule pas avec un boost. Une charge touche au maximum un survivant et s'arrête à l'impact.
- Tous les coups et pouvoirs offensifs sont bloqués par les murs, à l'exception explicite de la mesure de distance de la règle.
- Changer d'équipement prend 0,35 seconde et n'annule aucune recharge. Les outils non sélectionnés continuent à se recharger.
- Proposer au moins une arme à dégâts dans chaque inventaire. Il reste à décider si cette condition doit être obligatoire ou s'il existe une attaque de base indépendante.
- Le tir a été évoqué pour illustrer une touche, mais aucune arme à feu précise n'a encore été choisie.

## Proposition de labyrinthe et de pièges

Commencer avec une carte compacte, construite à la main, contenant trois boucles reliées entre elles. Un dédale composé uniquement d'impasses favorise les captures sans choix ; des boucles permettent les détours, les feintes et les interceptions.

Prévoir des repères faciles à reconnaître : une salle colorée, une fontaine, un atelier. Alterner petits couloirs, zones ouvertes et cachettes. Dimensionner la carte en testant les temps de trajet avec les vitesses retenues, plutôt qu'en choisissant d'abord une grande surface.

Premier piège proposé : une **barricade temporaire** qui bloque un couloir pendant 8 secondes. Chaque chasseur dispose d'une charge, rechargée en 20 secondes, avec une seule barricade active à la fois. Elle se pose en 0,7 seconde sur des emplacements autorisés et peut être démontée par un survivant avec une interaction de 1,5 seconde.

Pour préserver les possibilités de jeu, interdire sa pose sur un joueur, dans les zones de réapparition ou sur l'unique sortie d'une pièce secrète. Les deux chasseurs ne doivent pas pouvoir bloquer ensemble tous les passages d'une zone. Les emplacements de la première carte devront être vérifiés pour cela.

Proposition : donner la barricade dans un emplacement utilitaire séparé des trois équipements. Ce choix et le nombre de pièges disponibles restent à valider.

## Secrets et leviers

Le mécanisme demandé est conservé : trouver des leviers cachés, les actionner dans le bon ordre, entrer dans une pièce qui se referme ; un chasseur qui reproduit cet ordre peut entrer à son tour.

Proposition pour la première carte :

- Trois leviers identifiables par leur forme et leur symbole, avec un indice dans le décor.
- Une combinaison fixe au premier prototype, puis éventuellement une combinaison différente à chaque partie avec un indice correspondant.
- La progression de la combinaison appartient à chaque joueur, pour qu'un autre joueur ne puisse pas casser accidentellement la séquence en cours.
- Une mauvaise séquence remet cette progression à zéro et produit un petit bruit local.
- La bonne séquence ouvre la porte pendant 4 secondes ; tout joueur peut profiter de l'ouverture.
- La porte se referme sans écraser ni bloquer un personnage dans son encadrement.
- Un levier intérieur permet de ressortir après une interaction de 2 secondes. Le refuge comporte une seule sortie : un chasseur qui entre peut encore coincer le survivant.

La pièce ne protège ni de la règle ni des attaques une fois la porte ouverte. Elle ne doit pas permettre une victoire garantie simplement parce qu'on connaît le secret. Tester sa facilité de découverte et le temps nécessaire au chasseur pour reproduire la combinaison.

## Proposition de règles supplémentaires pour le 2 contre 2

- Désactiver les dégâts et effets négatifs entre coéquipiers au premier prototype.
- Afficher à chaque équipe les vies et l'état de ses survivants concernés, sans révéler les positions ennemies.
- Ajouter un signal simple pour indiquer un endroit à son coéquipier ; tester le jeu sans chat vocal intégré.
- Autoriser les chasseurs à se répartir la recherche et l'interception.
- Un survivant éliminé reste spectateur ; la réanimation par un allié n'entre pas dans la première version.
- Si un joueur quitte une partie, afficher clairement ce qui se passe. La règle de forfait ou de remplacement reste à décider avant l'ouverture de parties publiques.

## Proposition de raretés et de renouvellement

Conserver les cinq équipements initiaux en commun. Introduire les autres raretés lorsque la poursuite de base est déjà amusante.

Une rareté plus élevée peut apporter une mécanique plus particulière, une apparence ou une difficulté d'utilisation différente. Éviter qu'elle assure simplement la victoire grâce à des dégâts ou à une vitesse supérieurs.

Pour renouveler les parties : tester un nouvel équipement à la fois, ajouter des variantes de passages, déplacer certains indices et créer d'autres petites cartes. Les variantes compétitives doivent rester identiques pour tous les joueurs d'une même partie.

Faire revenir les joueurs par des parties satisfaisantes, des revanches rapides, des styles de jeu variés et éventuellement des récompenses cosmétiques. Le premier prototype ne nécessite ni boutique ni récompenses quotidiennes. Aucun mode d'obtention des raretés ou modèle économique n'est encore décidé.

## Proposition de base technique

- Moteur : Godot, avec GDScript ; choix proposé lors de la première discussion, à confirmer avant installation et création du projet.
- Premier support de développement : ordinateur. Prévoir tôt un essai Android ou iPhone pour évaluer les commandes et les performances.
- Distribution visée : version ordinateur, puis Steam, Android et iOS. Steam est une boutique pour la version ordinateur.
- Multijoueur : d'abord deux instances, puis deux appareils sur un réseau local ; préparer ensuite les connexions sur Internet.
- L'hôte de la partie valide les touches, les vies, les chronomètres et les pouvoirs. Chaque appareil ne doit pas décider seul qu'il a touché quelqu'un.
- Conserver les valeurs d'armes, de vitesse et de recharge dans des données faciles à modifier.
- Utiliser des formes et décors provisoires pour tester. Garder les crédits et licences des ressources ajoutées au projet.

L'hébergement Internet, les connexions entre plateformes et les comptes joueurs ne sont pas encore choisis. Le prototype local ne constituera pas une validation de ces fonctions.

## Ordre proposé pour construire le prototype

| Étape | Contenu | Résultat attendu |
| --- | --- | --- |
| 1 | Caméra 3D, déplacement, collisions, petite carte | Se déplacer et se cacher derrière un mur |
| 2 | Deux joueurs en réseau local, rôles et branche | Un joueur peut poursuivre et toucher l'autre |
| 3 | Trois vies, préparation, poursuite, victoire et revanche | Jouer une partie 1 contre 1 complète |
| 4 | Boost, glissade et premiers réglages | Chaque rôle dispose d'actions intéressantes pendant une poursuite |
| 5 | Trois emplacements et cinq équipements communs | Comparer plusieurs façons de jouer |
| 6 | Quatre joueurs et réapparition individuelle | Jouer un vrai 2 contre 2 sans interrompre les autres après une touche |
| 7 | Barricade et une pièce à leviers | Tester interception, secrets et possibilités de sortie |
| 8 | Commandes mobiles, connexion Internet et finitions | Préparer les essais sur les appareils et réseaux visés |

Faire un premier essai des commandes mobiles dès l'étape 1 ou 4, même si leur finition arrive plus tard. Les boutiques, les raretés avancées et les cartes supplémentaires viennent après la validation de cette boucle de jeu.

## Critères d'essai

- Jouer chaque rôle, avec plusieurs personnes, avant de conclure qu'une arme ou une vitesse est équilibrée.
- Vérifier qu'un survivant peut réellement rompre le contact visuel, et qu'un chasseur peut le retrouver sans suivre un marqueur permanent.
- Observer les taux de victoire par rôle, les durées de poursuite, les équipements utilisés et les endroits où les captures se produisent. Ne pas fixer un verdict sur une seule partie.
- Vérifier les cas limites : deux coups simultanés, deux ralentissements, décès à la fin du chronomètre, dernière vie, deux survivants en protection et déconnexion.
- Tester la règle à moins de 30 m, exactement à 30 m et au-delà ; vérifier le rayon de 15 m et les murs pour le tonnerre.
- Essayer de bloquer tous les trajets avec les pièges et de rester indéfiniment dans la pièce secrète ; corriger toute stratégie qui supprime les possibilités de réponse.
- Tester les commandes inversées, le boost et la glissade au clavier comme au tactile.
- Après les parties, demander ce qui a été amusant ou frustrant et changer peu de valeurs à la fois.

## Décisions encore ouvertes

1. Première personne ou troisième personne rapprochée ?
2. Confirmer Godot et GDScript pour réaliser le prototype.
3. En 1 contre 1, les quatre minutes recommencent-elles après chaque vie perdue ?
4. En 2 contre 2, valider le chronomètre continu, la protection personnelle de 30 secondes et la victoire possible pendant cette protection.
5. La seringue et le tonnerre retirent-ils aussi une vie, ou appliquent-ils seulement leur effet ?
6. Le bâton du tonnerre affecte-t-il tous les adversaires visibles à portée ou une seule cible ?
7. Les trois emplacements peuvent-ils contenir uniquement des outils sans dégâts ? Les pièges occupent-ils un de ces emplacements ?
8. Quelle direction artistique : cartoon, inquiétante, autre ? Quels ordinateurs et téléphones utiliser pour les premiers essais ?
9. Comment obtenir les futurs équipements rares et comment présenter les résultats d'une revanche avec rôles inversés ?

## Journal des décisions

- 11 octobre 2026 : définition initiale par les créateurs des modes 1 contre 1 et 2 contre 2, du jeu en 3D, des trois vies, des boosts, du labyrinthe, des pièges, des secrets, des cinq équipements communs et des futures raretés.
- 11 octobre 2026 : confirmation explicite qu'en 2 contre 2, seul le survivant touché réapparaît et que les autres continuent.
- 11 octobre 2026 : le dossier `games` est la racine du dépôt `git@github.com:lemhaba10/games.git` ; le jeu réside dans `killers`.
- Les valeurs chiffrées d'équilibrage et les autres comportements décrits comme propositions n'ont pas encore été validés en jeu.

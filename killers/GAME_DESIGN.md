# Killers règles et conception du jeu

Version initiale du 11 octobre 2026.

Killers est un jeu multijoueur de cache-cache et de poursuite en 3D. Les chasseurs doivent prendre les survivants de vitesse, comprendre leurs feintes et utiliser leurs équipements. Les survivants doivent exploiter les cachettes, les chemins du labyrinthe et les mouvements pour leur échapper.

Le plaisir recherché est partagé : réussir une poursuite doit être satisfaisant, et réussir une évasion aussi. Les manches doivent produire des surprises et donner envie de rejouer en changeant de rôle.

## Statut des règles

Les sections « Règles demandées » et « Décisions confirmées » consignent les choix exprimés par les créateurs. Toutes les valeurs introduites dans les sections « Proposition » sont des réglages de départ à essayer, pas des décisions déjà approuvées.

La vue à la première personne, le chronomètre commun géré par le jeu et les valeurs par défaut des recharges du dash et de la lance sont confirmés. Le comportement du chronomètre après une perte de vie et certaines interactions entre pouvoirs restent à choisir. Toutes les valeurs d'équilibrage doivent être faciles à configurer. Cette fiche décrit le jeu envisagé ; elle ne décrit pas un logiciel déjà réalisé.

## Règles demandées

| Élément | Règle |
| --- | --- |
| Univers | Jeu en 3D dans une carte en forme de labyrinthe, vu à travers les yeux du personnage. |
| Mode 1 contre 1 | Un chasseur contre un survivant. |
| Mode 2 contre 2 | Deux chasseurs contre deux survivants. |
| Équipement du chasseur | Trois armes ou outils dans son inventaire, choisis avant de jouer. |
| Équipement du survivant | Des outils pour fuir, notamment un équipement permettant de courir sur les murs et une grenade fumigène qui gêne la vision des chasseurs sans gêner celle des survivants. Nombre d'emplacements à définir. |
| Préparation | Le survivant dispose de 30 secondes pour se cacher. |
| Poursuite | Le survivant doit survivre quatre minutes. |
| Chronomètre | Un chronomètre de combat commun à tous les joueurs, géré par le jeu selon les réglages des créateurs. |
| Vies | Chaque survivant possède trois vies. Une touche qui inflige des dégâts retire une vie. |
| Après une touche | S'il lui reste des vies, le survivant bénéficie à nouveau de 30 secondes pour se cacher. |
| Mobilité | Vitesses équilibrées entre les rôles et accélérations temporaires disponibles après un délai. |
| Dash de déplacement | Recharge individuelle de 120 secondes par défaut dès l'utilisation, pour les deux rôles. Cette valeur doit être facilement modifiable. |
| Recharge des armes | Chaque arme possède son propre délai configurable. Pour la lance, la valeur de départ est de 60 secondes après utilisation. |
| Configuration | Durées, recharges, vitesses, portées, vies et autres paramètres d'équilibrage modifiables sans changer le code des mécaniques. |
| Joueurs au prototype | Joueur 1 et Joueur 2, puis Joueur 3 et Joueur 4 en 2 contre 2 ; comptes et base de données reportés à une version suivante. |
| Progression future | Comptes avec pseudonymes, scores conservés en base de données et classement des joueurs qui gagnent le plus ; affichages envisagés de type top 5 ou top 200. |
| Feintes | Les survivants peuvent faire des feintes, des glissades et d'autres mouvements d'esquive. Les chasseurs disposent de réponses à ces mouvements. |
| Pièges | Les chasseurs peuvent déposer des objets pour bloquer un trajet ou orienter la fuite. |
| Secrets | Des leviers cachés, activés dans le bon ordre, ouvrent une pièce secrète qui se referme. Le chasseur peut reproduire la combinaison pour entrer. Le survivant risque alors d'être coincé. |
| Raretés | Équipements communs, rares, épiques, légendaires ; autres catégories possibles plus tard. |
| Évolution | Ajouter progressivement des armes et des situations nouvelles pour renouveler le plaisir de jouer. |

Le terme « chasseur » désigne ici le rôle aussi appelé « tueur » dans l'idée initiale. Le terme « survivant » désigne le joueur poursuivi.

## Décisions confirmées

- En **2 contre 2**, lorsqu'un survivant est touché, **seul ce survivant réapparaît**. Les autres joueurs continuent à jouer : ni retour collectif au départ, ni nouvelle préparation pour tout le monde.
- La vue est en 3D et **à la première personne**, à travers les yeux du personnage, pour les chasseurs comme pour les survivants.
- Les cinq premiers équipements de chasseur décrits plus bas appartiennent tous à la catégorie **commune**.
- Les survivants possèdent aussi des équipements de fuite : **course sur les murs** et **grenade fumigène**. La fumée gêne la vision des chasseurs, sans aveugler les survivants. Les noms définitifs, raretés et réglages de ces deux équipements restent à définir.
- Le **chronomètre de combat est commun à tous les joueurs** et géré par le jeu. Les créateurs en définissent les réglages.
- Le **dash de déplacement se recharge en 120 secondes par défaut à partir de son activation**, pour chaque joueur. Une nouvelle activation est impossible avant l'expiration de ce délai.
- La **charge de la lance se recharge en 60 secondes par défaut à partir de son activation**. Chaque arme possède son propre délai indépendant ; cette correction remplace l'idée précédente de deux minutes pour la lance.
- **Toutes les valeurs d'équilibrage doivent être configurables facilement**, y compris les recharges. Les 120 secondes du dash sont une valeur de départ, pas une constante définitive : les créateurs pourront essayer 60, 30, 10 secondes ou d'autres valeurs.
- Commencer avec **Joueur 1 à Joueur 4**, sans comptes ni base de données pour le prototype. Prévoir ensuite des comptes, pseudonymes, scores persistants et un classement fondé sur les victoires, avec des vues de type top 5 ou top 200.
- Le projet Godot créé par les créateurs se trouve dans **`games/killers-game`**. La documentation reste dans **`games/killers`**, et le dépôt Git commun est **`games`**.

## Proposition de déroulement d'une partie

### Début de partie

1. Choisir le mode et attribuer les rôles.
2. Chaque chasseur choisit trois équipements différents parmi ceux disponibles.
3. Chaque survivant commence avec trois vies.
4. Pendant 30 secondes, les survivants explorent et se cachent. Les chasseurs restent dans une zone de départ qui ne permet pas de voir où ils partent.
5. Le chronomètre de quatre minutes démarre à la libération des chasseurs.

### Chronomètre commun et recharges individuelles

Tous les joueurs voient le même temps de combat restant. Le jeu pilote ce chronomètre à partir d'une référence de temps commune ; chaque appareil affiche cet état sans décider indépendamment du début ou de la fin de la partie.

Les 30 secondes pour se cacher constituent une phase distincte du temps de combat. En 2 contre 2, le compte à rebours personnel d'un survivant qui se recache ne remplace pas le chronomètre commun affiché aux autres.

Chaque joueur possède ses propres recharges : le dash d'un joueur ne consomme pas celui d'un autre. Chaque arme possède aussi son propre délai. Utiliser la lance déclenche sa recharge de 60 secondes, sans déclencher la recharge de 120 secondes du dash de déplacement ; l'interdiction proposée de les activer simultanément reste applicable.

Le caractère commun du chronomètre est confirmé. Son éventuelle remise à zéro après une perte de vie en 1 contre 1, et sa continuité en 2 contre 2, restent décrites ci-dessous comme des propositions à valider.

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
- Pendant cette protection, il ne peut pas activer de mécanisme, bloquer un passage, déclencher un piège ou utiliser ses équipements de fuite. Les adversaires et leurs positions ne lui sont pas affichés : cette phase ne doit pas servir à espionner pour son équipe.
- La fin de protection est clairement indiquée au survivant. Aucun compte à rebours public ne révèle sa position.
- Le chronomètre commun de quatre minutes continue. Il n'est pas réinitialisé par une touche.
- Si les deux survivants se recachent simultanément, les chasseurs peuvent se déplacer et préparer leurs pièges, mais ne détectent pas les survivants protégés.

Ce fonctionnement reste **à tester et à valider**, notamment la longueur de la protection. Il favorise potentiellement beaucoup les survivants. Une alternative à discuter serait une zone de réapparition avec plusieurs sorties cachées, à la place de l'invisibilité temporaire.

### Victoire

Proposition : les chasseurs gagnent lorsque tous les survivants ont perdu leurs trois vies avant la fin du temps. Les survivants gagnent si au moins l'un d'eux possède encore une vie lorsque le chronomètre atteint zéro.

Dans cette proposition, un survivant en train de se recacher compte encore comme vivant. Si la dernière élimination et la fin du temps surviennent ensemble, comparer les instants validés par la partie ; en cas d'égalité exacte, donner la victoire aux survivants. Cette convention et l'avantage de la protection en fin de partie devront être éprouvés.

Après la partie, proposer de rejouer en inversant les rôles, puis afficher les résultats des deux côtés. La revanche doit pouvoir se lancer rapidement.

## Caméra confirmée et propositions de visibilité

La caméra est placée **à hauteur des yeux du personnage**, en première personne, pour les deux rôles. C'est le choix confirmé par les créateurs : le joueur voit comme s'il était lui-même dans le labyrinthe.

Proposition de visibilité : les murs doivent réellement masquer les personnages, les noms ne doivent pas apparaître à travers les obstacles et aucun indicateur ne doit donner en permanence la position adverse. La caméra ne doit jamais traverser un mur, y compris pendant une glissade ou une course murale.

Prévoir une sensibilité réglable, des commandes simples et des effets visuels brefs. Garder l'horizon stable pendant la course murale, avec un éventuel léger mouvement de caméra désactivable. Essayer cette vue sur téléphone avant de concevoir toutes les animations.

## Dash configurable et propositions de vitesse

Le « boost » mentionné dans la fiche désigne le **dash de déplacement** commun aux deux rôles. Sa recharge de **120 secondes à partir de l'activation** est la valeur par défaut confirmée. La durée de l'accélération, sa puissance et sa disponibilité au début de la poursuite restent des propositions. Les distances et vitesses ci-dessous supposent que l'échelle de la carte est réglée en mètres.

| Action | Survivant | Chasseur |
| --- | --- | --- |
| Course normale | 5 m/s | 5,2 m/s |
| Marche discrète | 2,5 m/s | 2,5 m/s |
| Boost | Vitesse multipliée par 1,4 pendant 1 seconde | Vitesse multipliée par 1,4 pendant 1 seconde |
| Recharge du dash, valeur par défaut confirmée | 120 secondes à partir de l'activation | 120 secondes à partir de l'activation |
| Charges disponibles | Une, prête au début de la poursuite | Une, prête au début de la poursuite |

Le léger avantage de course proposé pour le chasseur met la pression dans une ligne droite. Le survivant gagne du terrain en choisissant mieux son trajet, en glissant et en feintant. Les valeurs proposées de vitesse servent à commencer les essais ; la recharge confirmée reste elle aussi configurable pour l'équilibrage.

Afficher clairement la disponibilité du dash et son délai restant. Par exemple, avec le réglage par défaut, un dash activé à 00:20 du temps écoulé redevient disponible à 02:20, si la partie continue. La recharge commence dès l'activation, pas à la fin de l'accélération.

Proposition : une touche distincte déclenche l'accélération ; courir normalement ne consomme pas de ressource. En 2 contre 2, les recharges continuent lors d'une réapparition individuelle, sans rendre artificiellement des charges. Une éventuelle remise à zéro du chronomètre affiché ne doit pas effacer les recharges en cours.

## Proposition de feintes et de réponses

| Action du survivant | Intérêt | Réponse du chasseur |
| --- | --- | --- |
| Glissade de 0,6 seconde, recharge de 5 secondes | Passer sous un obstacle bas et modifier rapidement sa trajectoire | Anticiper la sortie, contourner ou préparer son attaque ; la glissade ne rend pas invincible |
| Changement de direction au dernier instant | Faire manquer une attaque ou une charge | Attendre la feinte, puis attaquer pendant le retour à la course |
| Marche discrète | Réduire les indices sonores | Utiliser la règle et vérifier les cachettes |
| Boost à un embranchement | Rompre le contact visuel | Garder son propre boost ou utiliser un autre chemin |
| Saut bas | Franchir certains petits obstacles | Emprunter un raccourci ou suivre ; le saut n'annule pas les dégâts |

Éviter d'empiler trop de boutons au début. Prototype : déplacement, caméra, boost, interaction et glissade. Ajouter le saut si la carte lui donne un vrai rôle. Donner aux chasseurs les mouvements de base nécessaires pour que les passages réservés aux survivants ne créent pas de refuges impossibles à atteindre.

## Équipements communs des chasseurs demandés

Les comportements de la deuxième colonne viennent des créateurs. Les dégâts, durées et recharges de la troisième colonne sont des **propositions de prototype**, sauf la recharge de la lance : **60 secondes par défaut**, confirmées par les créateurs. Toutes ces valeurs sont configurables.

| Équipement | Effet demandé | Réglage initial proposé | Possibilité de réponse |
| --- | --- | --- | --- |
| Branche | Arme simple, sans pouvoir spécial | Corps à corps, portée de 1,8 m, retire une vie, préparation de 0,25 seconde, délai de 1 seconde entre attaques | Sortir de portée ou faire manquer le coup |
| Règle | Affiche la distance de l'ennemi jusqu'à 30 m ; ne détecte rien au-delà | À l'activation, indique pendant 2 secondes la distance arrondie du survivant actif le plus proche ; recharge de 8 secondes ; aucun dégât | Changer de trajet entre deux mesures ; aucun nom ni direction révélé |
| Seringue | Au corps à corps, inverse les commandes et réduit la vitesse de 50 % | Portée de 1,5 m, effet de 2 secondes, recharge de 15 secondes ; ne retire pas de vie dans cette première proposition | Éviter la portée courte et exploiter le délai après une attaque manquée |
| Lance | Permet une ruée vers l'ennemi | Charge dans la direction visée, jusqu'à 6 m en 0,35 seconde ; retire une vie au contact ; recharge confirmée de 60 secondes par défaut dès l'activation ; s'arrête contre un mur | Esquiver latéralement pendant le bref signal de préparation |
| Bâton du tonnerre | Aveugle un ennemi avec un éclair dans un rayon de 15 m | Affecte les survivants visibles à 15 m maximum ; gêne visuelle de 1 seconde ; recharge de 18 secondes ; aucun dégât | Se mettre derrière un mur pendant l'annonce de 0,4 seconde |

### Proposition d'interactions entre équipements

- La règle fonctionne à travers les murs, mais ne révèle pas le chemin à suivre. C'est un outil de recherche, pas une vision à travers les obstacles.
- La seringue inverse les directions de déplacement, sans inverser la caméra ni les menus. Sur mobile, elle inverse de la même façon les directions du joystick. Son ralentissement affecte aussi la vitesse pendant un boost.
- Les effets de deux seringues ne se cumulent pas et ne prolongent pas un effet déjà actif. Accorder ensuite 3 secondes d'immunité à la seringue pour éviter une immobilisation répétée par deux chasseurs.
- Le tonnerre produit un voile bref et un effet sonore reconnaissable ; il conserve une perception minimale du décor. Accorder 3 secondes d'immunité à un nouvel aveuglement après la fin de l'effet.
- La lance ne traverse pas les murs et ne se cumule pas avec un boost. Une charge touche au maximum un survivant et s'arrête à l'impact.
- Tous les coups et pouvoirs offensifs sont bloqués par les murs, à l'exception explicite de la mesure de distance de la règle.
- Changer d'équipement prend 0,35 seconde et n'annule aucune recharge. Les outils non sélectionnés continuent à se recharger.
- Proposer au moins une arme à dégâts dans chaque inventaire de chasseur. Il reste à décider si cette condition doit être obligatoire ou s'il existe une attaque de base indépendante.
- Le tir a été évoqué pour illustrer une touche, mais aucune arme à feu précise n'a encore été choisie.

## Équipements de fuite des survivants

Les survivants peuvent utiliser des équipements pour échapper aux chasseurs. Les deux premiers effets demandés sont la course sur les murs et la fumée qui gêne uniquement la vision des chasseurs. Leur fonction de fuite est confirmée ; les paramètres ci-dessous sont des **propositions à tester**.

Proposition d'inventaire initial : deux emplacements, un pour chaque équipement, disponibles dès le début de la poursuite. Les trois emplacements confirmés des chasseurs ne déterminent pas le nombre d'emplacements des survivants. Ces outils n'infligent pas de dégâts dans le prototype proposé.

| Équipement au nom provisoire | Effet demandé | Réglage initial proposé | Réponse possible du chasseur |
| --- | --- | --- | --- |
| Bottes de course murale | Courir sur un mur pour fuir | Course horizontale jusqu'à 2 secondes à 6 m/s, recharge de 18 secondes après la fin de l'action | Anticiper le point de retour au sol, emprunter un autre passage ou toucher le survivant pendant la course |
| Grenade fumigène | Créer de la fumée qui aveugle le chasseur sans aveugler le survivant | Lancer jusqu'à 8 m, nuage de 4 m de rayon pendant 4 secondes, une charge, recharge de 25 secondes à partir du lancer | Contourner le nuage, écouter les pas ou utiliser la règle pour estimer la distance |

### Proposition de fonctionnement de la course murale

- Activer l'équipement à proximité d'un mur compatible en avançant le long de celui-ci. Prévoir une commande explicite utilisable au clavier et sur écran tactile.
- Courir horizontalement, sans escalade verticale ni montée sur le sommet du labyrinthe. Prévoir des surfaces lisibles et un retour au sol accessible aux deux rôles.
- La course se termine à la fin du mur, après 2 secondes ou si le joueur relâche l'action. Une nouvelle activation exige un retour au sol et une recharge terminée : pas d'enchaînement infini entre deux murs.
- Le survivant reste vulnérable. Une touche interrompt l'action et applique la perte de vie habituelle. Les murs et les barricades conservent leurs collisions.
- Ne pas cumuler la vitesse de course murale avec le boost. Le ralentissement de la seringue s'applique aussi à cette vitesse ; l'inversion des directions reste active sans inverser la caméra.
- Un trajet mural doit aider à esquiver ou contourner un obstacle sans conduire hors de la carte ou vers une cachette définitivement inaccessible aux chasseurs.

### Proposition de fonctionnement de la fumée

- Pour les chasseurs, le nuage masque les personnages et le décor derrière lui ou à l'intérieur. Il gêne aussi un chasseur qui regarde à travers depuis l'extérieur ; il ne provoque pas d'aveuglement à distance ailleurs dans la carte.
- Pour les survivants, afficher une limite ou une brume légère non occultante afin qu'ils sachent où se trouve le nuage tout en gardant une vision claire. En 2 contre 2, cela s'applique aussi au survivant allié. Les murs restent opaques pour tous.
- Le nuage ne traverse pas les murs et ne se propage pas dans une pièce fermée adjacente. Son rayon maximal est limité par le décor.
- La fumée ne rend pas invincible et ne bloque ni les déplacements ni les attaques. Elle ne supprime pas le bruit des pas ni la détection de la règle.
- Dans le prototype proposé, le tonnerre exige une cible visible : la fumée peut donc empêcher son déclenchement sur un survivant masqué, mais n'annule pas un aveuglement déjà appliqué.
- Le lancer et l'apparition du nuage produisent un son local. Deux nuages superposés ne renforcent pas l'aveuglement ; chacun conserve sa durée propre.
- La recharge ne se réinitialise pas à la perte d'une vie. Interdire l'utilisation des deux équipements pendant les phases protégées de cachette, initiales ou après réapparition.

Tester particulièrement les fumigènes alternés de deux survivants : ils doivent permettre une évasion sans maintenir un couloir sous une fumée permanente. Les durées, rayons et recharges restent ajustables après les premières parties.

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

Conserver les cinq équipements initiaux des chasseurs en commun. La rareté des équipements de survivant reste à choisir. Introduire les autres raretés lorsque la poursuite de base est déjà amusante.

Une rareté plus élevée peut apporter une mécanique plus particulière, une apparence ou une difficulté d'utilisation différente. Éviter qu'elle assure simplement la victoire grâce à des dégâts ou à une vitesse supérieurs.

Pour renouveler les parties : tester un nouvel équipement à la fois, ajouter des variantes de passages, déplacer certains indices et créer d'autres petites cartes. Les variantes compétitives doivent rester identiques pour tous les joueurs d'une même partie.

Faire revenir les joueurs par des parties satisfaisantes, des revanches rapides, des styles de jeu variés et éventuellement des récompenses cosmétiques. Le premier prototype ne nécessite ni boutique ni récompenses quotidiennes. Aucun mode d'obtention des raretés ou modèle économique n'est encore décidé.

## Joueurs et sauvegardes du prototype

Le premier prototype utilise des noms automatiques : **Joueur 1** et **Joueur 2** en 1 contre 1, jusqu'à **Joueur 4** en 2 contre 2. L'hôte attribue un identifiant de session distinct du nom affiché pour associer correctement chaque joueur à son personnage, son rôle et ses résultats. Ces identifiants ne sont pas des comptes permanents.

Conserver en mémoire les informations de la partie et, si utile, les victoires de la session pour les revanches. Aucun compte, mot de passe, base de données ou classement mondial n'est nécessaire pour cette étape. Les résultats de test ne sont pas destinés à devenir des scores officiels.

Godot fournit des outils pour écrire et relire des fichiers locaux, notamment `FileAccess`, JSON et `ConfigFile` pour les préférences. Une sauvegarde locale suffit si l'on souhaite ensuite retenir le volume, la sensibilité ou un pseudo d'essai sur l'appareil. Elle ne synchronise pas automatiquement ces informations entre plusieurs appareils. [Sauvegardes dans Godot](https://docs.godotengine.org/en/stable/tutorials/io/saving_games.html)

## Comptes et classement pour une version suivante

Après validation du jeu, ajouter les comptes et une base de données partagée afin de retrouver le profil et les résultats d'un joueur au fil des sessions. Le pseudonyme est le nom public ; un identifiant permanent distinct permet de retrouver les résultats même si ce pseudonyme change.

Architecture proposée : **jeu Godot → service en ligne → base de données**. Le service gère l'identification, l'enregistrement des résultats et la consultation du classement. Godot peut communiquer avec un service web via ses outils HTTP. [Requêtes HTTP dans Godot](https://docs.godotengine.org/en/stable/tutorials/networking/http_request_class.html)

Le fournisseur de comptes, la technologie de base de données et l'hébergement seront choisis au moment de cette étape. Les sauvegardes locales du prototype et les futurs comptes restent deux fonctions distinctes.

### Proposition de données à conserver

| Données | Usage |
| --- | --- |
| Profil | Identifiant permanent, pseudonyme et date de création du compte |
| Résultat de partie | Identifiant unique de partie, joueurs, équipes, rôles, mode, vainqueurs, date et version des règles |
| Statistiques | Parties jouées, victoires, défaites et score, calculés à partir des résultats validés |

Le classement public affiche le rang, le pseudonyme et le score ou le nombre de victoires. Les informations utilisées pour se connecter ne font pas partie de cet affichage.

### Proposition de score et de classement

- Commencer avec **une victoire = un point**, et zéro point pour une défaite. Le barème reste configurable ; aucun barème définitif n'est encore adopté.
- En 2 contre 2, attribuer une victoire à chacun des deux joueurs de l'équipe gagnante, même si un survivant a été éliminé avant la victoire de son équipe.
- Attribuer les points à la fin de la partie complète. Une vie perdue, une touche ou une nouvelle phase de cachette ne compte pas comme une victoire supplémentaire.
- Classer d'abord par nombre de victoires ou par score si un barème différent est adopté. Un classement au nombre de victoires mesure aussi le volume de jeu, pas seulement le niveau.
- Afficher un **top 5** en aperçu et permettre de consulter un **top 200**. Ces tailles sont configurables et peuvent être deux vues du même classement ; ajouter la position personnelle du joueur même s'il est en dehors du top.
- Prévoir des classements séparés pour le 1 contre 1 et le 2 contre 2 au départ. La période retenue, le traitement des égalités et une éventuelle distinction par rôle restent à décider.
- Un classement quotidien n'est pas encore décidé : chaque joueur possède un score, mais sa remise à zéro quotidienne, saisonnière ou son cumul permanent restent à choisir.

### Proposition de validation des résultats

Le futur service calcule les points à partir d'un résultat validé, plutôt que d'accepter un total de points choisi par l'application du joueur. Donner à chaque partie un identifiant unique pour qu'un même résultat reçu deux fois ne compte qu'une fois.

Les parties du prototype hébergées chez un joueur restent des essais non classés. Avant un classement public, définir une source de résultats de confiance, par exemple un serveur de partie contrôlé par le projet : ajouter une base de données ne suffit pas à rendre fiables les résultats déclarés par un joueur hôte.

Conserver la version des règles utilisée pour chaque résultat. Les parties de test avec des paramètres librement modifiés ne doivent pas alimenter le classement officiel. Définir également le traitement des déconnexions, abandons et parties incomplètes avant de distribuer des points publics.

## Configuration facile des règles et de l'équilibrage

Les créateurs doivent pouvoir modifier les règles et l'équilibrage sans changer le code des mécaniques. Conserver les paramètres dans des ressources de configuration éditables depuis l'éditeur du moteur, avec des noms explicites et les unités affichées. Un menu de réglages destiné aux joueurs n'est pas nécessaire pour répondre à ce besoin.

Prévoir les groupes suivants :

- **Partie** : durée de préparation, durée de combat, nombre de vies et règles de reprise après une touche, avec des réglages par mode si nécessaire.
- **Déplacement par rôle** : course, marche, glissade, durée et puissance du dash, recharge et disponibilité initiale.
- **Chaque arme ou équipement** : recharge indépendante, portée, durée, dégâts ou vies retirées, rayon, intensité des effets, nombre de charges et conditions d'utilisation.
- **Carte et interactions** : durée des barricades, ouverture des portes, temps d'interaction et paramètres des secrets.
- **Progression future** : barème de points, taille des classements, périodes et modes éligibles, lorsque les comptes seront ajoutés. Versionner le barème pour éviter de mélanger silencieusement des scores calculés avec des règles différentes.

Valeurs de départ confirmées : `dash_cooldown_seconds = 120` pour les deux rôles et `spear_cooldown_seconds = 60` pour la lance. Les autres nombres de cette fiche gardent leur statut de règle demandée ou de proposition ; les rendre configurables ne change pas ce statut.

Pour comparer un dash toutes les deux minutes, toutes les minutes, toutes les 30 secondes ou toutes les 10 secondes, modifier uniquement son réglage. L'affichage de la recharge, la validation réseau et le comportement effectif doivent tous lire cette même valeur, sans copies de nombres dispersées dans le code.

Proposition technique : charger et valider la configuration au début de la partie, puis la partager avec tous les appareils. Utiliser la configuration de l'hôte ou du serveur comme référence. Appliquer les modifications aux parties suivantes pour conserver des règles identiques entre joueurs pendant une partie en cours. Garder les valeurs par défaut dans le dépôt pour pouvoir revenir facilement à un réglage connu.

## Proposition de base technique

- Moteur : projet Godot créé dans `games/killers-game/project.godot`, avec la version de fonctionnalités 4.7 et le rendu Compatibility. GDScript est le langage retenu pour le développement prévu. Le projet moteur existe, mais aucune scène jouable n'est encore créée.
- Premier support de développement : ordinateur. Prévoir tôt un essai Android ou iPhone pour évaluer les commandes et les performances.
- Distribution visée : version ordinateur, puis Steam, Android et iOS. Steam est une boutique pour la version ordinateur.
- Multijoueur : d'abord deux instances, puis deux appareils sur un réseau local ; préparer ensuite les connexions sur Internet.
- L'hôte de la partie valide les touches, les vies, les chronomètres et les pouvoirs. Chaque appareil ne doit pas décider seul qu'il a touché quelqu'un.
- Mettre en œuvre la configuration centralisée décrite ci-dessus pour les règles, armes, vitesses et recharges ; calculer les échéances à partir du temps de partie de référence, indépendamment du compte à rebours affiché.
- Utiliser des formes et décors provisoires pour tester. Garder les crédits et licences des ressources ajoutées au projet.

Le prototype commence avec des joueurs de session sans compte. Les comptes et le classement sont prévus pour une étape suivante ; leurs fournisseurs, l'hébergement Internet et les connexions entre plateformes ne sont pas encore choisis. Le prototype local ne constituera pas une validation de ces fonctions.

## Ordre proposé pour construire le prototype

| Étape | Contenu | Résultat attendu |
| --- | --- | --- |
| 1 | Caméra 3D à la première personne, déplacement, collisions, petite carte | Se déplacer et se cacher derrière un mur |
| 2 | Joueur 1 et Joueur 2 en réseau local, identifiants de session, rôles et branche | Un joueur peut poursuivre et toucher l'autre, sans compte ni base de données |
| 3 | Vies et durées configurables, chronomètre commun, préparation, poursuite, victoire et revanche | Jouer une partie 1 contre 1 complète |
| 4 | Dash configurable, glissade et premiers réglages | Tester notamment une recharge de 120, 60, 30 ou 10 secondes sans changer le code |
| 5 | Trois emplacements et cinq équipements communs pour les chasseurs ; course murale et fumigène pour les survivants | Comparer les outils de poursuite et de fuite |
| 6 | Quatre joueurs et réapparition individuelle | Jouer un vrai 2 contre 2 sans interrompre les autres après une touche |
| 7 | Barricade et une pièce à leviers | Tester interception, secrets et possibilités de sortie |
| 8 | Commandes mobiles, connexion Internet et finitions | Préparer les essais sur les appareils et réseaux visés |
| Version suivante | Comptes, pseudonymes, base de données, résultats validés, scores et classement configurable | Retrouver sa progression et consulter les meilleurs joueurs |

Faire un premier essai des commandes mobiles dès l'étape 1 ou 4, même si leur finition arrive plus tard. Les boutiques, les raretés avancées et les cartes supplémentaires viennent après la validation de cette boucle de jeu.

## Critères d'essai

- Jouer chaque rôle, avec plusieurs personnes, avant de conclure qu'une arme ou une vitesse est équilibrée.
- Vérifier qu'un survivant peut réellement rompre le contact visuel, et qu'un chasseur peut le retrouver sans suivre un marqueur permanent.
- Observer les taux de victoire par rôle, les durées de poursuite, les équipements utilisés et les endroits où les captures se produisent. Ne pas fixer un verdict sur une seule partie.
- Vérifier les cas limites : deux coups simultanés, deux ralentissements, décès à la fin du chronomètre, dernière vie, deux survivants en protection et déconnexion.
- Vérifier que tous les joueurs partagent la même échéance de fin de combat et que les comptes à rebours personnels ne la remplacent pas.
- Avec les valeurs par défaut, vérifier qu'un deuxième dash est refusé avant 120 secondes et autorisé à partir de 120 secondes après l'activation ; faire le même contrôle à 60 secondes pour la lance. Vérifier que les joueurs et les armes ont des recharges indépendantes.
- Modifier uniquement la configuration du dash à 60, 30 puis 10 secondes et vérifier que le comportement, l'affichage et la validation réseau suivent tous la nouvelle valeur dès la partie suivante. Vérifier également qu'une réapparition ou un changement d'arme ne contourne pas une recharge.
- Tester la règle à moins de 30 m, exactement à 30 m et au-delà ; vérifier le rayon de 15 m et les murs pour le tonnerre.
- Essayer de bloquer tous les trajets avec les pièges et de rester indéfiniment dans la pièce secrète ; corriger toute stratégie qui supprime les possibilités de réponse.
- Tester les commandes inversées, le boost et la glissade au clavier comme au tactile.
- Vérifier la course murale en première personne : caméra hors des murs, fin de course, retour au sol, vulnérabilité et absence de sortie du labyrinthe.
- Vérifier la fumée depuis les points de vue des deux rôles, à l'intérieur et à l'extérieur : chasseurs gênés, survivants voyant clairement, murs toujours opaques, règle fonctionnelle et interaction cohérente avec le tonnerre.
- Tester deux fumigènes simultanés ou alternés, les recharges après une perte de vie et l'interdiction d'utiliser ces équipements pendant la protection.
- Pour la future version avec comptes : vérifier qu'une partie n'attribue les points qu'une fois, que les résultats de test sont exclus, que le mode et la version du barème sont respectés, et qu'un changement de pseudo conserve les résultats du compte.
- Après les parties, demander ce qui a été amusant ou frustrant et changer peu de valeurs à la fois.

## Décisions encore ouvertes

1. Valider le nombre d'emplacements des survivants, les noms et raretés de leurs équipements, ainsi que les réglages de course murale et de fumée.
2. En 1 contre 1, les quatre minutes recommencent-elles après chaque vie perdue ?
3. En 2 contre 2, valider le chronomètre continu, la protection personnelle de 30 secondes et la victoire possible pendant cette protection.
4. La seringue et le tonnerre retirent-ils aussi une vie, ou appliquent-ils seulement leur effet ?
5. Le bâton du tonnerre affecte-t-il tous les adversaires visibles à portée ou une seule cible ?
6. Les trois emplacements des chasseurs peuvent-ils contenir uniquement des outils sans dégâts ? Les pièges occupent-ils un de ces emplacements ?
7. Quelle direction artistique : cartoon, inquiétante, autre ? Quels ordinateurs et téléphones utiliser pour les premiers essais ?
8. Comment obtenir les futurs équipements rares et comment présenter les résultats d'une revanche avec rôles inversés ?
9. Pour la version avec comptes : confirmer le barème, les égalités, les périodes du classement, les règles d'abandon et la méthode de validation des résultats. Choisir ensuite le service de comptes, la base de données et l'hébergement.

## Journal des décisions

- 11 octobre 2026 : définition initiale par les créateurs des modes 1 contre 1 et 2 contre 2, du jeu en 3D, des trois vies, des boosts, du labyrinthe, des pièges, des secrets, des cinq équipements communs et des futures raretés.
- 11 octobre 2026 : confirmation explicite qu'en 2 contre 2, seul le survivant touché réapparaît et que les autres continuent.
- 11 octobre 2026 : le dossier `games` est la racine du dépôt `git@github.com:lemhaba10/games.git` ; la conception initiale est enregistrée dans `killers`.
- 11 octobre 2026 : confirmation de la vue à la première personne, à travers les yeux du personnage.
- 11 octobre 2026 : ajout demandé d'équipements de fuite pour les survivants, avec course sur les murs et grenade fumigène gênant les chasseurs sans aveugler les survivants. Leurs valeurs d'équilibrage et leur rareté ne sont pas encore validées.
- 11 octobre 2026 : confirmation d'un chronomètre de combat commun à tous les joueurs et géré par le jeu.
- 11 octobre 2026 : recharge du dash de déplacement fixée à 120 secondes par défaut après activation. Après correction des créateurs, la lance possède sa propre recharge de 60 secondes, et chaque arme a un délai indépendant.
- 11 octobre 2026 : tous les paramètres d'équilibrage doivent être faciles à configurer. Les 120 secondes du dash sont une valeur de départ qui pourra être remplacée notamment par 60, 30 ou 10 secondes pour les essais.
- 11 octobre 2026 : commencer sans compte ni base de données avec Joueur 1 à Joueur 4 ; prévoir ensuite des comptes avec pseudonymes, scores persistants et classement des meilleurs joueurs selon les victoires, avec des vues de type top 5 ou top 200. Le barème et la période du classement restent à définir.
- 11 octobre 2026 : les créateurs initialisent le projet Godot dans `games/killers-game`, l'éditeur ayant demandé un dossier vide. Conserver ce dossier pour le jeu et `games/killers` pour la documentation ; le projet existant utilise Godot 4.7 avec le rendu Compatibility.
- Les valeurs chiffrées d'équilibrage et les autres comportements décrits comme propositions n'ont pas encore été validés en jeu.

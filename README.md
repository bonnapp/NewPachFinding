___________________________________________________________________________
DESCRIPTION

Ce projet à pour but de comparer différent algo de pach finding et de comparer .
Afin que les algorithmes marchent , les fcihiers .map doivent respecter cette structure

Exemple
type octile  LIGNE 1
height 5     LIGNE 2
width 5      LIGNE 3
map          LIGNE 4
..SS..
SS..S
S.@.S
SS.@S
.....


Selon que la case à visiter a pour valeur
          'S' alors coutMvmt ← 5
          'W' alors coutMvmt ← 8
          autrement coutMvmt ← 1
          '@' et 'T' équivaut à un mur  

Il existe 7 algorithmes
algoBFS(fname, D, A)
algoDijkstra(fname, D, A)
algoGlouton(fname, D, A)
algoAstar(fname, D, A)
AVarianteUne(fname, D, A)
AVarianteDeux(fname, D, A)
AVarianteTrois(fname, D, A)

avec comme paramètres :
• fname | type : String | exemple : "didactic.map"      (chemin du fichier .map)
• D | type : Tuple{Int64, Int64} | exemple : (12, 14)   (point de départ)
• A | type : Tuple{Int64, Int64} | exemple : (4, 5)     (point d'arrivé)

___________________________________________________________________________
STRUCTURE DE PROJET

'src/' :Contient le code source
'dat/' :Contient les fichiers de données
'doc/' :Contient la documentation de projet

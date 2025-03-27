include("pile.jl")
include("pileprioritaire.jl")
#using Plots  #pour dessiner




 #Fonction qui creé 3 dictionnaires (mur,sable,eau)
function Graphe(nom)
mur= Dict{Tuple{Int64,Int64}, Char}()
sable= Dict{Tuple{Int64,Int64}, Char}()
eau= Dict{Tuple{Int64,Int64}, Char}()
try 
    open(nom, "r") do f
        height = ""
        weigt = ""
    readline(f)
    test =readline(f)
    for i in 8:sizeof(test)
        height=height * test[i]
    end
    test =readline(f)
    for i in 7:sizeof(test)
        weigt=weigt * test[i]
    end
    readline(f) #ligne 4
    for i in 1:parse(Int64, height)
        ligne =readline(f)
        for j in 1:parse(Int64, weigt)
            if ligne[j] == '@' || ligne[j] == 'T'
                
                mur[(i,j)]=ligne[j]
            end 
            if ligne[j] == 'S' 
                sable[(i,j)]=ligne[j]
            end 
            if ligne[j] == 'W' 
                eau[(i,j)]=ligne[j]
            end 
        end
    end  
    return (mur,sable,eau,height,weigt)
    end #end du try
catch
    # fichier n'existe pas
    println("file doesn't exist")
    return 0
    end
end


# Fonction pour reconstruire le chemin 
function chemin(parent, vD, vA)
    path = []
    current = vA
    chaine=""

    while current != vD
        chaine="->"*string(current)*chaine
        if !haskey(parent, current)
            println("Erreur: chemin incomplet")
            return 0
        end
        current = parent[current]  # Remonter vers le parent

    end
    println("Chemin le plus court :",vD,chaine)
    return 0
end


function Heureutisque(vA,v)
    return abs(vA[1]-v[1]) +abs(vA[2]-v[2])
end 

#fontion pour le dessiner
#=
function dessiner_etats(graphe,eval, vD, vA)
    p = plot(size=(800, 800))

     # Ajouter les eval

    # Ajouter les murs
    murs = collect(keys(graphe[1]))
    if !isempty(murs)
        scatter!([m[1] for m in murs], [m[2] for m in murs],markersize=1, markershape=:square, color=:black, label="Murs")
    end
     # Ajouter les sable
     sable = collect(keys(graphe[2]))
     #
     if !isempty(sable)
      #
         scatter!([m[1] for m in sable], [m[2] for m in sable],markersize=2, markershape=:square, color=:yellow, label="sable")
     end
       # Ajouter les eau
       eau = collect(keys(graphe[3]))
       if !isempty(eau)
           scatter!([m[1] for m in eau], [m[2] for m in eau],markersize=2, markershape=:square, color=:blue, label="eau")
       end
        # Ajouter les eval      
     test = collect(keys(eval))
     if !isempty(test)
         scatter!([m[1] for m in test], [m[2] for m in test],markersize=2,markershape=:square, color=:pink, label="eval", )
     end
      
       scatter!(p,[vD[1]], [vD[2]], markersize=5, label="Départ", color=:green)
       scatter!(p,[vA[1]], [vA[2]], markersize=5, label="Arrivée", color=:red ,linecolor=:red)  
       
    xlabel!("X")
    ylabel!("Y")
    title!("Weigted A*  variante 1")

    display(p)
end

=#
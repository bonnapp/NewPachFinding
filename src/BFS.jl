include("pile.jl")
include("pileprioritaire.jl")
include("code.jl")




function algoBFS(G,vD,vA)
    #Variable
    graphe =Graphe(G)
    F=Pile()
    ajouterdebut(F,vD)
    visiter=Set{Tuple{Int64,Int64}}()
    push!(visiter,vD)
    evaluer=0
    parent = Dict{Tuple{Int64, Int64}, Tuple{Int64, Int64}}()  # Stocke d'où vient chaque nœud

    #Vérifacation que les points prient ne soit pas des murs
    if haskey(graphe[1], vD) || haskey(graphe[1], vA)
        println("l'un des points est un mur")
        return false
    end
    #Debut
    parent[vD] = (-1, -1)  # Marquer le point de départ
    debut = time() 
    while !(vide(F))
        u=enlever(F)
        if u == vA
            fin = time() 
            println("BFS:")
            println("Nombre evaluer :",evaluer)
            println("Temps:" , fin-debut  )
             chemin(parent, vD, vA)
             println(" ")
             return
        else
        v=[(1+u[1],u[2]),(u[1],u[2]+1),(u[1]-1,u[2]) ,(u[1],u[2]-1)]
        for s in v
            if !(s in visiter) && s[1]<=parse(Int64,graphe[4]) && s[2]<=parse(Int64,graphe[5]) && s[1]>0 && s[2]>0 && !(haskey(graphe[1],s))
                evaluer=evaluer+1
                ajouterdebut(F,s)
                push!(visiter,s)
                parent[s] = u
                end
            end
        end
    end
end

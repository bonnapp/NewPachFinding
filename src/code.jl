include("pile.jl")
include("pileprioritaire.jl")


 #Fonction qui creé 3 dictionnaires (mur ,sable,eau)
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


function algoBFS(G,vD,vA)
    graphe =Graphe(G)
    F=Pile()
    ajouterdebut(F,vD)
    visiter=Set{Tuple{Int64,Int64}}()
    push!(visiter,vD)
    evaluer=0
    parent = Dict{Tuple{Int64, Int64}, Tuple{Int64, Int64}}()  # Stocke d'où vient chaque nœud
    if haskey(graphe[1], vD) || haskey(graphe[1], vA)
        println("l'un des points est un mur")
        return false
    end

    parent[vD] = (-1, -1)  # Marquer le point de départ
    while !(vide(F))
        u=enlever(F)
        if u == vA
            println("BFS:")
            println("Nombre evaluer :",evaluer)
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


function algoDijkstra(G,vD,vA)
graphe =Graphe(G)
permanent=Set{Tuple{Int64,Int64}}()
distance= Dict{Tuple{Int64,Int64}, Float64}()
parent = Dict{Tuple{Int64, Int64}, Tuple{Int64, Int64}}()
pq = PriorityQueue()
evaluer =0
if haskey(graphe[1], vD) || haskey(graphe[1], vA)
    println("l'un des points est un mur")
    return false
end
for i in 1:parse(Int64, graphe[4])
    for j in 1:parse(Int64, graphe[5])
        if !(haskey(graphe[1],(i,j))) 
            distance[(i,j)]=Inf
        end
    end
end     
distance[vD]=0
ajouterdebut(pq,vD,0.0)
while !(isempty(pq.elements))
    u =enlever(pq)
    if u == vA
        println("l'algortihme Dijkstra :")
            println("La distance est :" , distance[u])
            println("Nombre evalué:" , evaluer )
            chemin(parent, vD, vA)
            println(" ")
        return true
    end
    push!(permanent, u)
    s=[(1+u[1],u[2]),(u[1]-1,u[2]),(u[1],u[2]+1) ,(u[1],u[2]-1)]
        for v in s
    if !(v in permanent) && haskey(distance,v)
        if haskey(graphe[2],v)#sable
            new_distance = distance[u]+5
        elseif haskey(graphe[3],v) #eau
            new_distance = distance[u]+8
        else
            new_distance = distance[u]+1
        end
        if new_distance < distance[v]

            
            evaluer=evaluer+1
            distance[v] = new_distance
            parent[v] = u
            ajouterdebut(pq,v,new_distance)
        end

    end
end  
end#while    
println("l'algortihme Dijkstra :")
println("Nombre evalué:" , evaluer )
println("Pas de chemin")
println(" ")
return false
end #end de la fin de fonction =Dijkstra



function Glouton(G,vD,vA)
    graphe =Graphe(G)
    permanent=Set{Tuple{Int64,Int64}}()
    distance= Dict{Tuple{Int64,Int64}, Float64}()
    parent = Dict{Tuple{Int64, Int64}, Tuple{Int64, Int64}}()
    pq = PriorityQueue()
    evaluer=0
    if haskey(graphe[1], vD) || haskey(graphe[1], vA)
        println("l'un des points est un mur")
        return false
    end
    
    for i in 1:parse(Int64, graphe[4])
        for j in 1:parse(Int64, graphe[5])
            if !(haskey(graphe[1],(i,j))) 
                distance[(i,j)]=Inf
            end
        end
    end     
    distance[vD]=0
    ajouterdebut(pq,vD,0.0)
    while !(isempty(pq.elements))
        u =enlever(pq)
        if u == vA
            println("l'algortihme Glouton :")
            println("La distance est :" , distance[u])
            println("Nombre evalué:" , evaluer )
            chemin(parent, vD, vA)
            println(" ")
            return true
        end
        push!(permanent, u)
        s=[(1+u[1],u[2]),(u[1],u[2]+1),(u[1]-1,u[2]) ,(u[1],u[2]-1)]
        for v in s
        if !(v in permanent) && haskey(distance,v) && !(haskey(pq.valeur,v)  )  
               evaluer=evaluer+1
            if haskey(graphe[2],v)#sable
                new_distance = distance[u]+5
            elseif haskey(graphe[3],v) #eau
                new_distance = distance[u]+8
            else
                new_distance = distance[u]+1
            end
            if new_distance < distance[v]
                distance[v] = new_distance
                parent[v] = u
                if vA[1]-v[1]<0 
                    if vA[2]-v[2]<0 
                        h=-(vA[1]-v[1])-(vA[2]-v[2])
                    end
                h=-(vA[1]-v[1])+(vA[2]-v[2])
                else
                    if vA[2]-v[2]<0 
                        h=(vA[1]-v[1])-(vA[2]-v[2])
                    end
                h=(vA[1]-v[1])+(vA[2]-v[2])  
                end
                ajouterdebut(pq,v,Float64(h))
            end
    
        end
    end #end for 
    end#while  
 println("l'algortihme Glouton  :")
println("Nombre evalué:" , evaluer )
println("Pas de chemin")
println(" ")  
    
    
    end #end de la fin de fonction glouton





function algoAstar(G,vD,vA)
    graphe =Graphe(G)
    permanent=Set{Tuple{Int64,Int64}}()
    distance= Dict{Tuple{Int64,Int64}, Float64}()
    parent = Dict{Tuple{Int64, Int64}, Tuple{Int64, Int64}}()
    pq = PriorityQueue()
    evaluer=0
    if haskey(graphe[1], vD) || haskey(graphe[1], vA)
        println("l'un des points est un mur")
    return false
        end
        
        for i in 1:parse(Int64, graphe[4])
            for j in 1:parse(Int64, graphe[5])
                if !(haskey(graphe[1],(i,j))) 
                    distance[(i,j)]=Inf
                end
            end
        end     
        distance[vD]=0
        ajouterdebut(pq,vD,0.0)
        while !(isempty(pq.elements))
            u =enlever(pq)
            
            if u == vA
                println("l'algortihme astar :")
                println("La distance est :" , distance[u] )
                println("Nombre evalué:" , evaluer  )
                chemin(parent, vD, vA)
                println(" ")
                return true
            end
            push!(permanent, u)
            s=[(1+u[1],u[2]),(u[1],u[2]+1),(u[1]-1,u[2]) ,(u[1],u[2]-1)]
            for v in s
            if !(v in permanent) && haskey(distance,v)
                if haskey(graphe[2],v)#sable
                    new_distance = distance[u]+5
                elseif haskey(graphe[3],v) #eau
                    new_distance = distance[u]+8
                else
                    new_distance = distance[u]+1
                end
                if new_distance < distance[v]
                    distance[v] = new_distance
                    parent[v] = u
                    if vA[1]-v[1]<0 
                        if vA[2]-v[2]<0 
                            h=-(vA[1]-v[1])-(vA[2]-v[2])
                        end
                    h=-(vA[1]-v[1])+(vA[2]-v[2])
                    else
                        if vA[2]-v[2]<0 
                            h=(vA[1]-v[1])-(vA[2]-v[2])
                        end
                    h=(vA[1]-v[1])+(vA[2]-v[2])  
                    end 
                    if haskey(pq.valeur,v) 
                        update(pq,v,Float64((h + new_distance)))   # Mettre à jour la priorité existante
                    else
                        evaluer=evaluer +1
                        ajouterdebut(pq,v,Float64((h + new_distance)) )  # Ajouter seulement si absent
                    end
                end
        
            end
        end #end for
end#while   
println("l'algortihme astar :")
println("Nombre evalué:" , evaluer )
println("Pas de chemin")
println(" ")
end #end de la fin de fonction astar
    
    

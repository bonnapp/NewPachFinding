include("pile.jl")
include("pileprioritaire.jl")
include("code.jl")



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
    debut = time() 
    while !(isempty(pq.elements))
        u =enlever(pq)
        if u == vA
            fin = time() 
            println("l'algortihme Dijkstra :")
                println("La distance est :" , distance[u])
                println("Nombre evalué:" , evaluer )
                println("Temps:" , fin-debut  )
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
    
    
    
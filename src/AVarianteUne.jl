include("pile.jl")
include("pileprioritaire.jl")
include("code.jl")




function AVarianteUne(G,vD,vA)
    #Variable
    graphe =Graphe(G)
    permanent=Set{Tuple{Int64,Int64}}()
    distance= Dict{Tuple{Int64,Int64}, Float64}()
    parent = Dict{Tuple{Int64, Int64}, Tuple{Int64, Int64}}()
    pq = PriorityQueue()
    evaluer=0
    height=parse(Int64, graphe[4])
    weigt=parse(Int64, graphe[5])
    w=0.5
    #Vérifacation que les points prient ne soit pas des murs
    if haskey(graphe[1], vD) || haskey(graphe[1], vA)
        println("l'un des points est un mur")
    return false
        end     
        distance[vD]=0
        ajouterdebut(pq,vD,0.0)
        debut = time() 
        while !(isempty(pq.elements))
            u =enlever(pq)
            
            if u == vA
                fin = time() 
                println("l'algortihme wA* Variante 1 :")
                println("La distance est :" , distance[u] )
                println("Nombre evalué:" , evaluer  )
                println("Temps:" , fin-debut  )
                chemin(parent, vD, vA)
                println(" ")
                return true
            end
            push!(permanent, u)
            s=[(u[1]-1,u[2]),(u[1],u[2]+1),(u[1]+1,u[2]) ,(u[1],u[2]-1)]
            for v in s
            if !(v in permanent) && !(haskey(graphe[1],v)) && v[1]>0 && v[2]>0 && v[2]<=weigt && v[1]<=height
                if haskey(graphe[2],v)#sable
                    new_distance = distance[u]+5
                elseif haskey(graphe[3],v) #eau
                    new_distance = distance[u]+8
                else
                    new_distance = distance[u]+1
                end
                if haskey(distance,v)
                    if new_distance < distance[v]
                        distance[v] = new_distance
                        parent[v] = u
                        h=Heureutisque(vA,v)
                        update(pq,v,Float64(((1-w)*h + w*new_distance))) 
                    end 
                else
                    distance[v] = new_distance
                    parent[v] = u
                    h=Heureutisque(vA,v)  
                    evaluer=evaluer +1
                        ajouterdebut(pq,v,Float64(((1-w)*h + w*new_distance)) ) 

                end
               
                
        
            end
        end #end for
end#while   
println("l'algortihme wA* vairante 1 :")
println("Nombre evalué:" , evaluer )
println("Pas de chemin")
println(" ")
end #end de la fin de fonction wa



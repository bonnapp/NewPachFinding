mutable struct Pile
    queue::Vector{Tuple{Int64, Int64}}
    debut::Int
    fin::Int

    function Pile()
     new(Vector{Tuple{Int64, Int64}}(),1,0)
    end
end

function ajouterdebut(pile::Pile,v)
    pile.fin += 1
    if length(pile.queue)<pile.fin
        push!(pile.queue ,v)
    else
        pile.queue[pile.fin]  =v 
    
    end
end

function enlever(pile::Pile)
    if pile.debut > pile.fin
        error("La file est vide")                  
    end
    v = pile.queue[pile.debut]
    pile.debut += 1  
    return v
end

function vide(pile::Pile)
    return pile.debut > pile.fin
end

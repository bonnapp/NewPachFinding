mutable struct PriorityQueue
    elements::Vector
    valeur::Dict
end

function PriorityQueue()
    return PriorityQueue([],Dict())
end

function ajouterdebut(pq::PriorityQueue, element::Any, priority::Float64)
    push!(pq.elements, (priority, element))
    pq.valeur[element] = priority
    entasser(pq)
end

function enlever(pq::PriorityQueue)
    if isempty(pq.elements)
        error("La file est vide.")
    end
    # L'élément avec la plus haute priorité est au début du tableau (indice 1)
    pop_element = pq.elements[1]
    pq.elements[1] = pq.elements[end]  # Remplacer la racine par le dernier élément
    pop!(pq.elements)  # Supprimer le dernier élément
    entasserbas(pq)  # Réorganiser le tas pour maintenir l'invariant du tas binaire
    return pop_element[2]
end

# Fonction pour réorganiser le tas de bas en haut
function entasser(pq::PriorityQueue)
    i = length(pq.elements)
    while i > 1
        parent = div(i, 2)
        if pq.elements[parent][1] > pq.elements[i][1]  # Priorité plus faible, donc échange
            pq.elements[parent], pq.elements[i] = pq.elements[i], pq.elements[parent]
            i = parent
        else
            break
        end
    end
end

# Fonction pour réorganiser le tas de haut en bas
function entasserbas(pq::PriorityQueue)
    i = 1
    while true
        EnfantGauche = 2 * i
        EnfantDroit = 2 * i + 1
        petit = i
        
        # Trouver l'enfant avec la priorité la plus basse
        if EnfantGauche <= length(pq.elements) && pq.elements[EnfantGauche][1] < pq.elements[petit][1]
            petit = EnfantGauche
        end
        
        if EnfantDroit <= length(pq.elements) && pq.elements[EnfantDroit][1] < pq.elements[petit][1]
            petit = EnfantDroit
        end
        
        # Si le plus petit enfant a une priorité plus faible, échanger
        if petit != i
            pq.elements[i], pq.elements[petit] = pq.elements[petit], pq.elements[i]
            i = petit
        else
            break
        end
    end
end

function update(pq::PriorityQueue, key::Any, new_priority::Float64)
    # Trouver l'indice de l'élément dans la file
    for i in 1:length(pq.elements)
        if pq.elements[i][2] == keys
            # Mettre à jour la priorité
            pq.elements[i] = (new_priority, key)
            
            # Réorganiser le tas en fonction de la nouvelle priorité
            if new_priority < pq.elements[i][1]
                entasser(pq)  # Si la priorité est diminuée, on remonte
            else
                entasserbas(pq)  # Si la priorité est augmentée, on descend
            end
            return
        end
    end
end


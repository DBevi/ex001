using Random
using DrWatson


function NearestNeighboursSum(lattice)
    erg = 0
    sum = 0
    
    for k in axes(lattice, 3) 
        for j in axes(lattice, 2)  
            for i in axes(lattice, 1)
                if 0 < i+1 <= size(lattice, 1)
                    erg = erg + lattice[i, j, k] * lattice[i+1, j, k]
                end
    
                if 0 < i-1 <= size(lattice, 1)
                    erg = erg + lattice[i, j, k] * lattice[i-1, j, k]
                end
    
                if 0 < j+1 <= size(lattice, 2)
                    erg = erg + lattice[i, j, k] * lattice[i, j+1, k]
                end
    
                if 0 < j-1 <= size(lattice, 2)
                    erg = erg + lattice[i, j, k] * lattice[i, j-1, k]
                end
    
                if 0 < k+1 <= size(lattice, 3)
                    erg = erg + lattice[i, j, k] * lattice[i, j, k+1]
                end
    
                if 0 < k-1 <= size(lattice, 3)
                    erg = erg + lattice[i, j, k] * lattice[i, j, k-1]
                end
            end
        end    
    end    
    erg
end
    
function SpinSum(lattice)
    erg = 0
    sum = 0
    for k in axes(lattice, 3) 
        for j in axes(lattice, 2)  
            for i in axes(lattice, 1)
                erg = erg + lattice[i, j, k]
            end
        end
    end
    erg
end

function Hamiltonian(lattice, J, B)
    
    H = -J * NearestNeighboursSum(lattice) - B * SpinSum(lattice)

end


function Magnetization(lattice)
    erg = 0
    sol = 0
    for k in axes(lattice, 3) 
        for j in axes(lattice, 2)  
            for i in axes(lattice, 1)
                erg = erg + lattice[i, j, k]
            end
        end
    end
    sol = (1/length(lattice)) * erg
end

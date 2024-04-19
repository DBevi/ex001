using Random
using DrWatson
@quickactivate"ex01"
include(srcdir("nn_sum.jl"))

n_row = 3
n_column = 3
n_depth = 3


lattice = rand(Int8[-1, 1], n_row, n_column, n_depth)


function MetropolisAlgo(lattice, times, beta)

    energy = abs(Hamiltonian(lattice, J, B))

    net_spins = zeros(times)
    net_energy = zeros(times)

    for t in 1:times

        init_lattice = deepcopy(lattice)

        random_spin_pos = rand(1:length(lattice))
        
        spin_i = lattice[random_spin_pos]
        spin_f = lattice[random_spin_pos] * -1

        lattice[random_spin_pos] = spin_f
        spinflip_lattice = deepcopy(lattice)

        E_i = abs(Hamiltonian(init_lattice, J, B))
        E_f = abs(Hamiltonian(spinflip_lattice, J, B))

        dE = E_f - E_i

        if dE > 0
            if rand() < exp(-beta*dE)
                println("accepted by probability")
                energy = energy + dE
                lattice = deepcopy(spinflip_lattice)
            else
                println("rejected")
                lattice = deepcopy(init_lattice)
            end
        else
            println("accepted")
            energy = energy + dE  
            lattice = deepcopy(spinflip_lattice)  
        end

        net_energy[t] = energy
        net_spins[t] = SpinSum(lattice)

    end
      
    net_energy
end
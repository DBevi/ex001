using Random
using DrWatson
@quickactivate"ex01"
using Plots
include(srcdir("nn_sum.jl"))
include(srcdir("metropolis_alg.jl"))


n_row = 3
n_column = 3
n_depth = 3

J = 1
B = 0
beta = 1
times = 7


spins_lattice = rand(Int8[-1, 1], n_row, n_column, n_depth)


energy = MetropolisAlgo(spins_lattice, times, beta)

        
x = range(0, 7, length=100)
y = energy
plot(x, y)
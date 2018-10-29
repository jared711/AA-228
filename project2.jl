using LightGraphs
using Printf
using DataFrames
using CSV
using SpecialFunctions
using Random

function write_policy_file(PI,option)
    filename = string(option, ".policy")
    
    open(filename, "w") do f
        write(f, "A, B, C, D\n")
        write(f, string(PI))
    end
    
    
    #newfile = open(filename, "w")
    #write(newfile, 1)
    print("Policy file written \n")
end
    
function iterative_policy_evaluation(PI, n)
    U_PI_0 = 0 # for all s
    
    for t = 1:n
        U[t] = R(s,PI(s)) + gamma*sum(T(s_prime, s,PI(s))*U(s_prime)) # for all s
    end
    
    return U
end
    
    
function bayes_score_constribution(mᵢⱼ)

    nᵢ, nⱼ = size(mᵢⱼ)
    ΣlnΓ(x) = sum(lgamma.(x))
    mᵢ₀ = sum(mᵢⱼ, dims = 2)

    return nᵢ*ΣlnΓ(nⱼ) - ΣlnΓ(nⱼ .+ mᵢ₀) + ΣlnΓ(1.0 .+ mᵢⱼ)
end


option = "small"
if option == "small"
   print("small option selected \n") 
elseif option == "medium"
    print("medium option selected \n") 
elseif option == "large"
    print("large option selected \n") 
else
    print("Error: Incorrect name input \n")
end


data = CSV.read(string(option, ".csv")) |> Array{Int, 2}
m, n = size(data)


PI = [1 2 3]
write_policy_file(PI,option)


print("Finished \n")


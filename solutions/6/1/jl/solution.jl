open("cases/input/2","r") do f
    for input in eachline(f)
        for i in 4:length(input)
            if length(Set(input[i-3:i])) == 4
                println(i)
                break
            end
        end
    end
end
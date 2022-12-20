open("cases/input/2","r") do f
    for input in eachline(f)
        for i in 14:length(input)
            if length(Set(input[i-13:i])) == 14
                println(i)
                break
            end
        end
    end
end
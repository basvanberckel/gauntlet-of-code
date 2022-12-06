function solve(lines)
    prev = lines[1]
    result = 0
    for line in lines[2:end]
        if line > prev
            result += 1
        end
        prev = line
    end
    return result
end

open("cases/input/1","r") do f
    println(solve(collect(eachline(f))))
end
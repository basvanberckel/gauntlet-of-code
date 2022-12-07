filename = "cases/input/1"
file = io.open(filename)

prev = file:read("*n")
solution = 0
while true do
    local cur = file:read("*n")
    if cur == nil then break end
    if cur > prev then
        solution = solution + 1
    end
    prev = cur
end

print(solution)

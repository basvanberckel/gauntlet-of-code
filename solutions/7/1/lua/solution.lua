filename = "cases/input/2"
file = io.open(filename)

dirtotals = {}
cwd = {}
while true do
    local line = file:read("*l")
    if line == nil then break end
    local command, dir = string.match(line, "^\$ (%a%a) *(.*)$")
    if command == "cd" then
        if dir == ".." then
            table.remove(cwd)
        else
            table.insert(cwd, dir)
            dirtotals[table.concat(cwd, "/")] = 0
        end
    elseif command == nil then
        local size = string.match(line, "^(.+) .+$")
        if size ~= "dir" then
            for i, _ in ipairs(cwd) do
                local d = table.concat({unpack(cwd, 1, i)}, "/")
                dirtotals[d] = dirtotals[d] + tonumber(size)
            end
        end
    end
end

solution = 0
for dir, size in pairs(dirtotals) do
    if size < 100000 then
        solution = solution + size
    end
end
print(solution)
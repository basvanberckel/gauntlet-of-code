lines = File.readlines('cases/input/2')

grid = Hash.new

startcoord = nil
endcoord = nil

Coord = Struct.new(:x, :y)
Point = Struct.new(:coord, :elevation, :distance)

lines.each_with_index do |line, y|
    line.chomp.each_char.with_index do |elevation, x|
        coord = Coord.new(x, y)
        distance = nil
        if elevation == "S"
            startcoord = coord
            elevation = 1
            distance = 0
        elsif elevation == "E"
            endcoord = coord
            elevation = 26
        else
            elevation = elevation.ord - 96
        end
        point = Point.new(coord, elevation, distance)
        grid[coord] = point
    end
end

todo = [startcoord]

def surrounding (coord)
    return [
        Coord.new(coord.x - 1, coord.y),
        Coord.new(coord.x + 1, coord.y),
        Coord.new(coord.x, coord.y - 1),
        Coord.new(coord.x, coord.y + 1),
    ]
end

while true
    nexttodo = []
    while todo.length() > 0
        coord = todo.shift
        point = grid[coord]
        surrounding(coord).each do |surr|
            next if not grid.include?(surr)
            surrpoint = grid[surr]
            next if surrpoint.elevation - 1 > point.elevation
            if surrpoint.distance.nil?
                surrpoint.distance = point.distance + 1
                nexttodo.push(surr)
            end
        end
    end
    break if nexttodo.length() == 0
    todo = nexttodo
end

puts grid[endcoord].distance
lines = File.readlines('cases/input/2')

basegrid = Hash.new

startcoords = []
endcoord = nil

Coord = Struct.new(:x, :y)
Point = Struct.new(:elevation, :distance)

lines.each_with_index do |line, y|
    line.chomp.each_char.with_index do |elevation, x|
        coord = Coord.new(x, y)
        distance = nil
        if elevation == "S"
            elevation = 1
        elsif elevation == "E"
            endcoord = coord
            elevation = 26
        else
            elevation = elevation.ord - 96
        end
        if elevation == 1
            startcoords.push(coord)
        end
        point = Point.new(elevation)
        basegrid[coord] = point
    end
end

def surrounding (coord)
    return [
        Coord.new(coord.x - 1, coord.y),
        Coord.new(coord.x + 1, coord.y),
        Coord.new(coord.x, coord.y - 1),
        Coord.new(coord.x, coord.y + 1),
    ]
end

def printgrid(grid)
    y = 0
    grid.each do |coord, point|
        if coord.y > y
            puts
            y = coord.y
        end
        print point.distance, " "
    end
end

solution = 10000000

startcoords.each do |startcoord| 
    todo = [startcoord]
    grid = Marshal.load(Marshal.dump(basegrid))
    grid[startcoord].distance = 0
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
    if not grid[endcoord].distance.nil? and grid[endcoord].distance < solution
        solution = grid[endcoord].distance
    end
end

puts solution
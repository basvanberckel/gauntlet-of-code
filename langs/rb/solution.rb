lines = File.readlines('cases/input/1')

solution = 0
prev = lines.first

lines[1..-1].each do |cur|
    solution += cur > prev ? 1 : 0
    prev = cur
end

puts solution
import Foundation

let path = "cases/input/1"
guard let file = freopen(path, "r", stdin) else {
    exit(1)
}
defer {
    fclose(file)
}

var solution = 0
var prev = readLine()!
while let cur = readLine() {
    solution += cur > prev ? 1 : 0
    prev = cur
}

print(solution)
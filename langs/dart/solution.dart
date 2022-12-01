import 'dart:io';

int solve(List<String> lines) {
    var solution = 0;
    var prev = int.parse(lines[0]);
    for (var line in lines.sublist(1)) {
        var cur = int.parse(line);
        if (cur > prev) solution++;
        prev = cur;
    }
    return solution;
}

void main() {
    for (var file in Directory("cases/input").listSync()) {
        file = (file as File);
        var lines = file.readAsLinesSync();
        var solution = solve(lines);
        var filename = file.uri.pathSegments.last;
        print("\nOutput for case $filename");
        print("\t$solution");
        var output_file = File("cases/output/$filename");
        if (!output_file.existsSync())
            continue;
        var expected = int.parse(output_file.readAsStringSync());
        if (solution == expected) {
            print("pass");
            continue;
        }
        print("Expected:");
        print("\t$expected");
    }
}
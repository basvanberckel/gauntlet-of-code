import std.conv;
import std.stdio;
import std.file;
import std.path;


pure int solve(const int[] lines) @safe
{
    int solution = 0;
    int prev = lines[0];
    foreach (line; lines[0..$])
    {
        if (line > prev) solution++;
        prev = line;
    }
    return solution;
}

void main()
{
    foreach (string path; dirEntries("cases/input", SpanMode.shallow)) {
        int[] lines = slurp!int(path, "%s");
        int solution = solve(lines);
        string filename = baseName(path);
        writefln("\nOutput for case %s:", filename);
        writefln("\t%d", solution);
        string output_file = buildPath("cases/output", filename);
        if (!exists(output_file))
            continue;
        int expected = slurp!int(output_file, "%s")[0];
        if (solution == expected) {
            writeln("pass");
            continue;
        }
        writeln("Expected:");
        writefln("\t%d", expected);
    }
}
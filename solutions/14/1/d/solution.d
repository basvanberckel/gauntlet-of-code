import std.conv;
import std.stdio;
import std.file;
import std.path;
import std.array;
import std.typecons;

struct Coord {
    int x, y;
}

struct Grid {
    bool[Coord] blocks;
    int bottom, xMin, xMax;
}

pure Coord parseCoord(const string s) @safe
{
    string[] sxy = s.split(",");
    int x = to!int(sxy[0]);
    int y = to!int(sxy[1]);
    return Coord(x, y);
}

pure Grid parseGrid(const string[] lines) @safe
{
    bool[Coord] blocks;
    int bottom = 0;
    int xMin = 500;
    int xMax = 500;
    foreach (line; lines) 
    {
        string[] points = line.split(" -> ");
        Coord prev = parseCoord(points[0]);

        if (prev.y > bottom) bottom = prev.y;
        if (prev.x < xMin) xMin = prev.x;
        if (prev.x > xMax) xMax = prev.x;
        foreach (point; points[1..$])
        {
            Coord cur = parseCoord(point);

            if (cur.y > bottom) bottom = cur.y;
            if (cur.x < xMin) xMin = cur.x;
            if (cur.x > xMax) xMax = cur.x;

            blocks[cur] = 1;

            if(cur.x > prev.x) {
                for(int x = prev.x; x < cur.x; x++) {
                    Coord c = {x, cur.y};
                    blocks[c] = 1;
                }
            } else if(cur.x < prev.x) {
                for(int x = cur.x; x < prev.x; x++) {
                    Coord c = {x, cur.y};
                    blocks[c] = 1;
                }
            } else if(cur.y > prev.y) {
                for(int y = prev.y; y < cur.y; y++) {
                    Coord c = {cur.x, y};
                    blocks[c] = 1;
                }
            } else if(cur.y < prev.y) {
                for(int y = cur.y; y < prev.y; y++) {
                    Coord c = {cur.x, y};
                    blocks[c] = 1;
                }
            } 
            prev = cur;
        }
    }
    return Grid(blocks, bottom, xMin, xMax);
}


void printGrid(Grid grid) @safe
{
    for (int y = 0; y <= grid.bottom; y++)
    {
        for (int x = grid.xMin; x <= grid.xMax; x++)
        {
            Coord c = {x, y};
            if (c in grid.blocks)
            {
                write("#");
            } 
            else 
            {
                write(".");
            }
        }
        write("\n");
    }
}

bool dropSand(ref Grid grid) @safe
{
    int x = 500;

    for (int y = 0; y <= grid.bottom; y++)
    {
        bool moved = false;
        foreach (dx; [0, -1, 1])
        {
            if (!(Coord(x + dx, y+1) in grid.blocks))
            {
                moved = true;
                x = x + dx;
                break;
            }
        }
        if (!moved) 
        {
            grid.blocks[Coord(x, y)] = 1;
            return true;
        }
    }

    return false;
}

int solve(const string[] lines) @safe
{
    auto grid = parseGrid(lines);
    int solution = 0;
    while (dropSand(grid))
    {
        solution++;
    }
    return solution;
}

void main()
{
    foreach (string path; dirEntries("cases/input", SpanMode.shallow)) {
        string[] lines = slurp!string(path, "%s");
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
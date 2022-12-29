import std.conv;
import std.stdio;
import std.file;
import std.path;
import std.array;
import std.typecons;
import std.algorithm;

struct Coord {
    int x, y;
}

struct Grid {
    int[Coord] blocks;
    int bottom;

    pure int get(const Coord c) @safe
    {
        if(c.y > bottom + 1) return 1;

        int *p = c in blocks;
        return p ? *p : 0;
    }

    pure Tuple!(int, int) xMinMax() @safe
    {
        auto sorted = blocks.byKey.array.sort!((a, b) => a.x < b.x).array;
        return tuple(sorted[0].x, sorted[$-1].x);
    }
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
    int[Coord] blocks;
    int bottom = 0;
    foreach (line; lines) 
    {
        string[] points = line.split(" -> ");
        Coord prev = parseCoord(points[0]);

        if (prev.y > bottom) bottom = prev.y;
        foreach (point; points)
        {
            Coord cur = parseCoord(point);

            if (cur.y > bottom) bottom = cur.y;

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
    return Grid(blocks, bottom);
}


void printGrid(Grid grid) @safe
{

    auto xMinMax = grid.xMinMax().expand;
    
    for (int y = 0; y <= grid.bottom+2; y++)
    {
        for (int x = xMinMax[0]; x <= xMinMax[1]; x++)
        {
            // if (x == 500 && y == 0)
            // {
            //     write("+");
            //     continue;
            // }

            Coord c = {x, y};

            switch(grid.get(c))
            {
                case 1:
                    write("#");
                    break;
                case 2:
                    write("o");
                    break; 
                default:
                    write(".");
            }
        }
        write("\n");
    }
}

void dropSand(ref Grid grid) @safe
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
            grid.blocks[Coord(x, y)] = 2;
            return;
        }
    }

    grid.blocks[Coord(x, grid.bottom + 1)] = 2;
    return;
}

int solve(const string[] lines) @safe
{
    auto grid = parseGrid(lines);
    int solution = 0;
    while (grid.get(Coord(500, 0)) == 0)
    {
        dropSand(grid);
        solution++;
    }
    printGrid(grid);
    return solution;
}

void main()
{
    foreach (string path; dirEntries("cases/input", SpanMode.shallow)) {
        string filename = baseName(path);
        string[] lines = slurp!string(path, "%s");
        int solution = solve(lines);
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
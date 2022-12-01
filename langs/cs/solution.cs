static string Solve(string[] lines) 
{
    int prev = int.Parse(lines[0]);
    int solution = 0;
    foreach (string line in lines[1..])
    {
        int cur = int.Parse(line);
        if (cur > prev) solution++;
        prev = cur;   
    }
    return solution.ToString();
}

foreach (string path in Directory.GetFiles("cases/input"))
{
    string[] lines = File.ReadAllLines(path);
    string solution = Solve(lines);
    string fileName = Path.GetFileName(path);
    System.Console.WriteLine(string.Format("Output for case {0}: ", fileName));
    System.Console.WriteLine("\t" + solution);

    string outputPath = Path.Join("cases/output", fileName);
    if (!File.Exists(outputPath)) continue;

    string expected = File.ReadAllText(outputPath);
    if (solution == expected) {
        System.Console.WriteLine("pass");
        continue;
    }
    System.Console.WriteLine("Expected:");
    System.Console.WriteLine("\t" + expected);

}
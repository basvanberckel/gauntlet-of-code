import os


def solve(lines: list[str]) -> str:
    solution = 0
    prev = int(lines[0])
    for line in lines[1:]:
        if int(line) > prev:
            solution += 1
        prev = int(line)
    return str(solution)


if __name__ == "__main__":
    for f in os.listdir("cases/input"):
        file = open(os.path.join("cases/input", f))
        lines = file.readlines()
        solution = solve(lines)
        print(f"\nOutput for case {f}:")
        print("\t" + solution)
        if not os.path.isfile(os.path.join("cases/output", f)):
            continue
        file = open(os.path.join("cases/output", f))
        expected = file.readline()
        if expected == solution:
            print("pass")
            continue

        print("Expected:")
        print("\t" + expected)

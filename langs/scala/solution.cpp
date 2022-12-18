#include <iostream>
#include <fstream>
#include <string>
#include <filesystem>

std::string solve(std::ifstream lines) {
    int line;
    int prev;
    int solution = 0;
    lines >> prev;
    while (lines >> line) {
        if (line > prev) ++solution;
        prev = line;
    }
    return std::to_string(solution);
}


int main() {
    for (const auto &f : std::filesystem::directory_iterator("cases/input")) {
        std::ifstream lines(f.path());
        std::string solution = solve(std::move(lines));
        std::cout << '\n' << "Output for case " << f.path().filename() << ":" << '\n';
        std::cout << '\t' << solution << '\n';
        std::filesystem::path output_file("cases/output");
        output_file /= f.path().filename().string();
        if (!std::filesystem::exists(output_file))
            continue;
        std::ifstream expected_lines(output_file);
        std::string expected;
        expected_lines >> expected;
        if (solution == expected) {
            std::cout << "pass" << '\n';
            continue;
        }
        std::cout << "Expected:" << '\n';
        std::cout << '\t' << expected << std::endl;
    }
}

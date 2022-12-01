#include <stdio.h>
#include <dirent.h>
#include <stdlib.h>

int solve(FILE* input) {
    int cur;
    int prev;
    int solution = 0;
    fscanf(input, "%d\n", &prev);
    while (fscanf(input, "%d\n", &cur) == 1) {
        if (cur > prev) ++solution;
        prev = cur;
    }
    return solution;
}


int main() {
    DIR *dir = opendir("cases/input");
    struct dirent *fileinfo;
    char filename[20];
    char output_filename[20];
    FILE *file;
    char *data;
    int solution;
    int expected;
    while ((fileinfo = readdir(dir)) != NULL) {
        if (fileinfo->d_type != DT_REG)
            continue;
        sprintf(filename, "cases/input/%s", fileinfo->d_name);
        file = fopen(filename, "r");
        solution = solve(file);
        fclose(file);
        printf("\nOutput for case %s:'n", fileinfo->d_name);
        printf("\t%d\n", solution);
        sprintf(output_filename, "cases/output/%s", fileinfo->d_name);
        file = fopen(output_filename, "r");
        if (file == NULL)
            continue;
        fscanf(file, "%d", &expected);
        if (solution == expected) {
            printf("pass\n");
            continue;
        }
        printf("Expected:\n");
        printf("\t%d\n", expected);
    }
}

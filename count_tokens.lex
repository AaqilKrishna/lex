%{
int space = 0;
int small = 0;
int cap = 0;
int tab = 0;
int num = 0;
int newLine = 0;
%}

%%
[ ] space++;
[a-z] small++;
[A-Z] cap++;
[0-9] num++;
[\t] tab++;
[\n] newLine++;
%%

int yywrap(void) {
    FILE *output_file = fopen("output.txt", "w");
    if (!output_file) {
        perror("Error opening output file");
        return 1;
    }

    fprintf(output_file, "Number of spaces: %d\n", space);
    fprintf(output_file, "Number of small letters: %d\n", small);
    fprintf(output_file, "Number of capital letters: %d\n", cap);
    fprintf(output_file, "Number of numbers: %d\n", num);
    fprintf(output_file, "Number of tabs: %d\n", tab);
    fprintf(output_file, "Number of new lines: %d\n", newLine);
    
    fclose(output_file);
    
    return 1;
}

int main() {
    yylex();
    return 0;
}
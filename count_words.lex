%{
int words = 0;
%}

%%
[a-zA-Z]+ words++;
. ;
%%

int yywrap(void) {
    FILE *output_file = fopen("output.txt", "w");
    if (!output_file) {
        perror("Error opening output file");
        return 0;
    }

    fprintf(output_file, "Number of words: %d\n", words);
    
    fclose(output_file);

    return 1;
}

int main() {
    yylex();
    return 0;
}
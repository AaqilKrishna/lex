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
    fprintf(yyout, "Number of spaces: %d\n", space);
    fprintf(yyout, "Number of small letters: %d\n", small);
    fprintf(yyout, "Number of capital letters: %d\n", cap);
    fprintf(yyout, "Number of numbers: %d\n", num);
    fprintf(yyout, "Number of tabs: %d\n", tab);
    fprintf(yyout, "Number of new lines: %d\n", newLine);
    
    return 1;
}

int main() {
    yyin = fopen("input.txt", "r");
    yyout = fopen("output.txt", "w");
    
    yylex();

    fclose(yyin);
    fclose(yyout);

    return 0;
}
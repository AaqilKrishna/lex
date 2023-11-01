%{
int words = 0;
%}

%%
[a-zA-Z]+ words++;
. ;
%%

int yywrap(void) {
    fprintf(yyout, "Number of words: %d\n", words);
    
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
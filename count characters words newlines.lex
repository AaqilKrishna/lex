word [a-zA-Z]+

%{
int nchar = 0;
int nword = 0;
int nline = 0;
%}

%%
[\n] {
    nline++;
    nchar++;
}

{word} {
    nword++;
    nchar += yyleng;
}

. nchar++;

%%

int yywrap() {
    fprintf(yyout, "Number of characters: %d\n", nchar);
    fprintf(yyout, "Number of words: %d\n", nword);
    fprintf(yyout, "Number of new lines: %d\n", nline);

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
digit [0-9]
letter [a-zA-Z]

%{
int count = 0;
%}

%%
{letter}({letter}|{digit})* count++;
{digit}({letter}|{digit})* ;
%%

int yywrap(void) {
    fprintf(yyout, "Number of identifiers: %d", count);

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
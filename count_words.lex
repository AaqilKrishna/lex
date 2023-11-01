%{
    int words = 0;
%}

%%
[a-zA-Z]+ words++;
[\n] {
        printf("Number of words: %d\n", words);
        return 0;
    }
%%

int main() {
    printf("\nEnter string: ");
    yylex();
    return 0;
}
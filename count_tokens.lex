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

int main() {
    printf("Enter a string: ");
    yylex();
    printf("Number of spaces: %d\n", space);
    printf("Number of small letters: %d\n", small);
    printf("Number of capital letters: %d\n", cap);
    printf("Number of numbers: %d\n", num);
    printf("Number of tabs: %d\n", tab);
    printf("Number of new lines: %d\n", newLine);
    return 0;
}
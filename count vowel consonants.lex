vowel [aeiouAEIOU]

%{
int nvowel = 0;
int nconsonant = 0;
%}

%%
{vowel} nvowel++;

[a-zA-Z] nconsonant++;

. ;

%%

int yywrap() {
    fprintf(yyout, "number of vowels: %d\n", nvowel);
    fprintf(yyout, "number of consonants: %d\n", nconsonant);
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
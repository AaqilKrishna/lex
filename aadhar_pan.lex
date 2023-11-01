capLetter [A-Z]
digit [0-9]

%{
int validAadhar = 0;
int inValidAadhar = 0;
int validPan = 0;
int inValidPan = 0;
int aadhar_state[10000] = {0};
int pan_first_alpha[26] = {0};
%}

%%
{digit}{digit}{digit}{digit}[ ]{digit}{digit}{digit}{digit}[ ]{digit}{digit}{digit}{digit} {
    validAadhar++;
    char temp[5] = {yytext[0], yytext[1], yytext[2], yytext[3], '\0'};
    int state_code = atoi(temp);
    aadhar_state[state_code] += 1;
}

{capLetter}{capLetter}{capLetter}{capLetter}{capLetter}{digit}{digit}{digit}{digit}{capLetter} {
    validPan++;
    int alpha = yytext[0] - 'A';
    pan_first_alpha[alpha] += 1;
}

({digit})*[ ]({digit})*[ ]({digit})* inValidAadhar++;

({capLetter})+({digit})*({capLetter})* inValidPan++;

. ;

[\n] ;

%%

int yywrap() {
    fprintf(yyout, "No of valid Aadhar Numbers: %d\n", validAadhar);
    fprintf(yyout, "No of invalid Aadhar Numbers: %d\n", inValidAadhar);

    fprintf(yyout, "No of valid Pan Numbers: %d\n", validPan);
    fprintf(yyout, "No of invalid Pan Numbers: %d\n", inValidPan);


    fprintf(yyout, "\nAadhar card counts by state:\n");
    for (int i = 0; i < 10000; i++) {
        if (aadhar_state[i] > 0) {
            fprintf(yyout, "State Code %04d: %d\n", i, aadhar_state[i]);
        }
    }

    fprintf(yyout, "\nPAN card counts by first alphabet:\n");
    for (int i = 0; i < 26; i++) {
        if (pan_first_alpha[i] > 0) {
            fprintf(yyout, "%c: %d\n", 'A' + i, pan_first_alpha[i]);    
        }
    }
    
    return 1;
}

int main() {
    yyin = fopen("input.txt", "r");
    yyout = fopen("output.txt", "w");

    yylex();

    fclose(yyin);
    fclose(yyout);
}
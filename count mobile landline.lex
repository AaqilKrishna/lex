digit [0-9]

%{
int valid_mobile = 0;
int invalid_mobile = 0;
int valid_landline = 0;
int invalid_landline = 0;
int country[100] = {0};
int area[1000] = {0};
%}

%%
"+"{digit}{digit}{digit}{digit}{digit}{digit}{digit}{digit}{digit}{digit}{digit}{digit} {
    valid_mobile++;
    char temp[3] = {yytext[1], yytext[2], '\0'};
    int country_code = atoi(temp);
    country[country_code]++;
}

{digit}{digit}{digit}{digit}{digit}{digit}{digit}{digit}{digit}{digit}{digit} {
    valid_landline++;
    char temp[4] = {yytext[0], yytext[1], yytext[2], '\0'};
    int area_code = atoi(temp);
    area[area_code]++;
}

"+"([0-9])* invalid_mobile++;

([0-9])+ invalid_landline++;

. ;

[\n] ;

%%

int yywrap() {
    fprintf(yyout, "No of valid Mobile Numbers: %d\n", valid_mobile);
    fprintf(yyout, "No of invalid Mobile Numbers: %d\n", invalid_mobile);
    fprintf(yyout, "No of valid Landline Numbers: %d\n", valid_landline);
    fprintf(yyout, "No of invalid Mobile Numbers: %d\n", invalid_landline);

    fprintf(yyout, "\nMobile number counts by country:\n");
    for(int i = 0; i < 100; i++) {
        if (country[i] > 0) {
            fprintf(yyout, "Country Code %02d: %d\n", i, country[i]);
        }
    }

    fprintf(yyout, "\nLandline number counts by area:\n");
    for(int i = 0; i < 1000; i++) {
        if (area[i] > 0) {
            fprintf(yyout, "Area Code %03d: %d\n", i, area[i]);
        }
    }

    return 1;
}

int main () {
    yyin = fopen("input.txt", "r");
    yyout = fopen("output.txt", "w");

    yylex();

    fclose(yyin);
    fclose(yyout);

    return 0;
}

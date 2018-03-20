%option noyywrap
%{
#include <ctype.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
%}
hexn 0[xX][a-fA-F0-9]+
octn 0[oO][0-7]+
binn 0[bB][01]+
octnn 0[0-7]+
cmt [#][^\n]+
mulcmta "'''"
mulcmtb "\"\"\""
%%
{mulcmta}	{
	char c[3];//char c is used as a quene;
	int len = strlen(yytext);//int len is used to store the lenth of string recognized
	int done = 0;//simply a flag
	for (int i = 0;i < len;i++)
		putchar(yytext[i]);//print the 's
	for (int i = 0;i <= 2;i++)
		c[i] = input();//initial char c with the next three characters
	if (c[0] == '\'' && c[1] == '\'' && c[2] == '\'')
		done = 1;//function ends with three 's.
	else
		{
			for (int i = 0;i <= 2;i++)
				putchar(isupper(c[i])?tolower(c[i]):c[i]);//print characters, upper alphabets printed as lower alphabets.
		}
	do{
		c[0] = c[1];//dequene
		c[1] = c[2];//dequene
		c[2] = input();//enquene
		if(c[0] == '\'' && c[1] == '\'' && c[2] == '\'')
			done = 1;//function ends with three 's.
		else putchar(isupper(c[2])?tolower(c[2]):c[2]);//print characters, upper alphabets printed as lower alphabets.
	}while(!done);
	putchar(c[2]);//print the last '.
	}
{mulcmtb}	{
	char c[3];//char c is used as a quene;
	int len = strlen(yytext);//int len is used to store the lenth of string recognized.
	int done = 0;//simply a flag.
	for (int i = 0;i < len;i++)
		putchar(yytext[i]);//print the \"s
	c[0] = input();
	c[1] = input();
	c[2] = input();//initial char c with the next three characters.
	if (c[0] == '"' && c[1] == '"' && c[2] == '"')
		done = 1;//function ends with three \"s.
	else//print characters, upper alphabets printed as lower alphabets.
		{putchar(isupper(c[0])?tolower(c[0]):c[0]);
		putchar(isupper(c[1])?tolower(c[1]):c[1]);
		putchar(isupper(c[2])?tolower(c[2]):c[2]);}
	do{
		c[0] = c[1];//dequene
		c[1] = c[2];//dequene
		c[2] = input();//enquene
		if (c[0] == '"' && c[1] == '"' && c[2] == '"')
			done = 1;//function ends with three \"s.
		else putchar(isupper(c[2])?tolower(c[2]):c[2]);//print characters, upper alphabets printed as lower alphabets.
	}while(!done);
	putchar(c[2]);//print the last \".
	}
{hexn} {char c;//char c is used to store the character temporarily.
	int i;//int i is used temporarily.
	int len = strlen(yytext);//len is used to store the lenth of string recognized.
	int temp = 0;
	for (i = 2;i < len;i++)//calculate the exact decimal number.
	{
		c = yytext[i];
		if (isalpha(c))
			temp = isupper(c)?temp*16+c-55:temp*16+c-87;//equivalent writing: c-\'A\',c-\'a\'
		else if(isdigit(c))
			temp = temp*16+c-48;//equivalent writing: left shift temp fourtimes
	}
	char str[20];//store the number in str.
	sprintf(str,"%d",temp);//store the number.
	for (i = 0;i<strlen(str);i++)
	{
		c = str[i];
		putchar(c);//print the str.
	}
	}
{octn} {
	char c;
	int i;
	int len = strlen(yytext);
	int temp = 0;//all the same as hexn.
	for (i=2;i<len;i++)//calculate the exact decimal number.
	{
		c = yytext[i];
		if(isdigit(c))
			temp = temp * 8 + c - 48;//all the same as hexn.
	}
	char str[20];
	sprintf(str,"%d",temp);
	for (i = 0;i<strlen(str);i++)
	{
		c = str[i];
		putchar(c);//all the same as hexn.
	}
	}
{binn} {//all the same as octn, temp multiplied by two is equivalent to left shift.
	char c;
	int i;
	int len = strlen(yytext);
	int temp = 0;
	for (i=2;i<len;i++)
	{
		c = yytext[i];
		if(isdigit(c))
			temp = temp * 2 + c - 48;
	}
	char str[20];
	sprintf(str,"%d",temp);
	for (i = 0;i<strlen(str);i++)
	{
		c = str[i];
		putchar(c);
	}
	}
{octnn} {//used to recognize octal numbers start with zero.
	char c;
	int i;
	int len = strlen(yytext);
	int temp = 0;
	for (i=1;i<len;i++)
	{
		c = yytext[i];
		if(isdigit(c))
			temp = temp * 8 + c - 48;
	}
	char str[20];
	sprintf(str,"%d",temp);
	for (i = 0;i<strlen(str);i++)
	{
		c = str[i];
		putchar(c);
	}
	}
{cmt}	{//single-line comment.
	char c;
	int i;
	int len = strlen(yytext);
	for (i = 0;i<len;i++)
	{
		c = yytext[i];
		if(isupper(c))
			putchar(tolower(c));//print all of the characters, capitalized alphabet printed as a lower one.
		else
			putchar(c);
	}
	}
%%

void main(void)
{
    yylex();
}


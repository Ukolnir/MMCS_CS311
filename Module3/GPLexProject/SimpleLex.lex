%using ScannerHelper;
%namespace SimpleScanner

Alpha 	[a-zA-Z_]
Digit   [0-9] 
AlphaDigit {Alpha}|{Digit}
INTNUM  {Digit}+
REALNUM {INTNUM}\.{INTNUM}
ID {Alpha}{AlphaDigit}*
DotChr [^\r\n]
OneLineCmnt \/\/{DotChr}*
Ap [^']
Strap \'{Ap}*\'

// ����� ����� ������ �������� �����, ���������� � ������� - ��� �������� � ����� Scanner
%{
  public int LexValueInt;
  public double LexValueDouble;
  public int cntID;
%}

%x COMMENT

%%
{INTNUM} { 
  LexValueInt = int.Parse(yytext);
  return (int)Tok.INUM;
}

{REALNUM} { 
  LexValueDouble = double.Parse(yytext);
  return (int)Tok.RNUM;
}

begin { 
  return (int)Tok.BEGIN;
}

end { 
  return (int)Tok.END;
}

cycle { 
  return (int)Tok.CYCLE;
}

{ID}  { 
  return (int)Tok.ID;
}

":" { 
  return (int)Tok.COLON;
}

":=" { 
  return (int)Tok.ASSIGN;
}

";" { 
  return (int)Tok.SEMICOLON;
}

{OneLineCmnt} {
	return (int)Tok.STRCOMMENT;
}

{Strap} {
	return (int)Tok.STRINAP;
}

"{" {
  BEGIN(COMMENT);
  cntID = 0;
}

<COMMENT>{ID} {
  ++cntID;
}

<COMMENT> "}" { 
  BEGIN(INITIAL);
  return (int)Tok.LONGCOMMENT;
}

[^ \r\n] {
	LexError();
	return 0; // ����� �������
}



%%

// ����� ����� ������ �������� ���������� � ������� - ��� ���� �������� � ����� Scanner

public void LexError()
{
	Console.WriteLine("({0},{1}): ����������� ������ {2}", yyline, yycol, yytext);
}

public string TokToString(Tok tok)
{
	switch (tok)
	{
		case Tok.ID:
			return tok + " " + yytext;
		case Tok.INUM:
			return tok + " " + LexValueInt;
		case Tok.RNUM:
			return tok + " " + LexValueDouble;
		default:
			return tok + "";
	}
}


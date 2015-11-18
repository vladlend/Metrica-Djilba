unit Program1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const
  Lexem: array[1..42] of string = (
    'continue',
    'break',
    'while',
    'return',
    'switch',
    'sizeof',
    '{',
    '}',
    '"',
    '?',
    ':',
    '==',
    '=',
    '<=',
    '>=',
    '!=',
    '==',
    '=',
    '++',
    '--',
    '+',
    '-',
    '<<=',
    '<<',
    '>>=',
    '>>',
    '<',
    '>',
    '*=',
    '*',
    '/=',
    '/',
    '%=',
    '%',
    '||',
    '&&',
    '|=',
    '|',
    '&=',
    '&',
    '^=',
    '^'
  );

var
  BlockLevel: array[1..255] of Integer;

procedure TForm1.Button1Click(Sender: TObject);
var
  F: TextFile;
  Op: Integer;
  S: string;
  I: Integer;
  CurPos: Integer;
  P: Integer;
  CommentFlag: Boolean;
  ConstStringFlag: Boolean;
  OpNumber: Integer;
  IfNumber: Integer;
  CurLevel: Integer;
  MaxLevel: Integer;
begin
  if not OpenDialog1.Execute then
    Exit;

  OpNumber := 0;
  IfNumber := 0;
  CurLevel := 0;
  MaxLevel := 0;
  CommentFlag := False;
  ConstStringFlag := False;

  AssignFile(F, OpenDialog1.FileName);
  Reset(F);
  while not Eof(F) do begin
    Readln(F, S);
    CurPos := 1;
    while CurPos <= Length(S) do
    begin
      if CommentFlag then begin
        P := Pos('*/', Copy(S, CurPos, Length(S)-CurPos));
        if P <> 0 then begin
          CurPos := P + 2;
          CommentFlag := False;
          Continue;
        end else begin
          Break;
        end;
      end;

      if Copy(S, CurPos, 2) = '//' then
        Break;

      if Copy(S, CurPos, 2) = '/*' then begin
        P := Pos('*/', Copy(S, CurPos+2, Length(S)-CurPos-2));
        if P <> 0 then begin
          CurPos := CurPos + P + 3;
          Continue;
        end else begin
          CommentFlag := True;
          Break;
        end;
      end;

      if ConstStringFlag then begin
        P := Pos('"', Copy(S, CurPos, Length(S)-CurPos));
        if P <> 0 then begin
          CurPos := P + 1;
          ConstStringFlag := False;
          Continue;
        end else begin
          Break;
        end;
      end;

      if S[CurPos] = '"' then begin
        P := Pos('"', Copy(S, CurPos+1, Length(S)-CurPos-1));
        if P <> 0 then begin
          CurPos := CurPos + P + 2;
          Continue;
        end else begin
          ConstStringFlag := True;
          Break;
        end;
      end;

      if Copy(S, CurPos, 2) = 'if' then begin
        Inc(IfNumber);
        Inc(OpNumber);
        Inc(CurLevel);
        if CurLevel > MaxLevel then
          MaxLevel := CurLevel;
        BlockLevel[CurLevel] := 0;
        CurPos := CurPos + 2;
      end;

      if Copy(S, CurPos, 4) = 'else' then begin
        Inc(CurLevel);
        CurPos := CurPos + 4;
      end;

      if (S[CurPos] = '{') and (CurLevel > 0) then begin
        BlockLevel[CurLevel] := BlockLevel[CurLevel] + 1;
        Inc(CurPos);
      end;
      if (S[CurPos] = '}') and (CurLevel > 0) then begin
        BlockLevel[CurLevel] := BlockLevel[CurLevel] - 1;
        if BlockLevel[CurLevel] = 0 then begin
          Dec(CurLevel);
        end;
        Inc(CurPos);
      end;
      if (S[CurPos] = ';') and (CurLevel > 0) then begin
        if BlockLevel[CurLevel] = 0 then begin
          Dec(CurLevel);
        end;
        Inc(CurPos);
      end;

      for I:=1 to 42 do
        if Lexem[i] = Copy(S, CurPos, Length(Lexem[i])) then begin
          Inc(OpNumber);
          CurPos := CurPos + Length(Lexem[i]);
        end;
      Inc(CurPos);
    end;
  end;
  CloseFile(F);

  Memo1.Lines.Clear;
  Memo1.Lines.Add(Format('Number of operators = %d',[OpNumber]));
  Memo1.Lines.Add(Format('Number of IF operators = %d',[IfNumber]));
  if OpNumber > 0 then
    Memo1.Lines.Add(Format('IF / Op = %f',[IfNumber / OpNumber]));
  Memo1.Lines.Add(Format('Max level = %d',[MaxLevel]));
end;

end.

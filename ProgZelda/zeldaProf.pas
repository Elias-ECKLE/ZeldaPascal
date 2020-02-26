program zelda;
uses crt;
type coord=RECORD
       x:integer;
       y:integer;
       end;

const MAXLG=20;
      MAXLA=25;
      POSIXL=10;
      POSIYL=13;

var posl:coord;
    hyrule:array[1..MAXLG,1..MAXLA] of integer;   

procedure init;
var i,j,a,b:integer;
begin
        for i:=1 to MAXLG do
                for j:=1 to MAXLA do
                  hyrule[i,j]:=0;
        hyrule[POSIXL,POSIYL]:=-1;
        for i:=1 to 3 do
                for j:=1 to 5 do
                begin
                      a:=random(MAXLG)+1;
                      b:=random(MAXLA)+1;
                        while hyrule[a,b]<>0 do
                        begin
                                a:=random(MAXLG)+1;
                                b:=random(MAXLA)+1;
                        end;
                      hyrule[a,b]:=i;
                end;
        hyrule[POSIXL,POSIYL]:=0;
        posl.x:=POSIXL;
        posl.y:=POSIYL;
end;

function i2O(x:integer):string;
var res:string;
begin
    res:=' ';
    case x of
    1: res:='R';
    2: res:='A';
    3: res:='~';
    end;
    i2O:=res;
end;

procedure affiche;
var i,j:integer;
begin
        for i:=1 to MAXLG do
        begin
                for j:=1 to MAXLA do
                  write(i2O(hyrule[i,j]));
                writeln;
        end;
end;

procedure affichelink(c:coord);
begin
    gotoxy(c.x,c.y);write('L');
end;

BEGIN
   randomize;
   clrscr;
   cursoroff;
   init;
   affiche;
   affichelink(posl);
   readln;
END.
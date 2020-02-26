program zelda;

uses crt,MMSystem;


const maxLg=20;
const maxLa=25;
const posX_L=10;
const posY_L=13;

type
    tabNb= array[1..maxLa,1..maxLg] of integer;

type coord=RECORD
    x:integer;
    y:integer;
    end;
type stats=RECORD
    coeur:integer;
    ptsMystere:integer;
    tresor:integer;
    end;

type joueur=RECORD
    position:coord;
    nb:stats;
    hyrule:tabNb;
    end;




function init(map:tabNb):tabNb;
//BUT:initialiser la map d'Hyrule, placer les obstacles soit 5 emplacements d'eau, 5 rochers, 5 arbres
//SORTIE:nb correspondant aux objets placés dans la map

var i,j,a,b:integer;
begin

    //stockage de la valeur par defaut de la map
    for i:=1 to maxLa do
        for j:=1 to maxLg do
        map[i,j]:=0;
    //pose Link temporaire
    map[posX_L,posY_L]:=-1;


    //verif et pose des chiffres obstacles
    for i:=1 to 3 do
    begin
        for j:=1 to 5 do
        begin
            a:=random(maxLa)+1;
            b:=random(maxLg)+1;
            while (map[a,b]<>0) do //si un autre nb que 0 est présent, on tire une nouvelle position afin d'eviter l'ecrasement de ce nb
            begin
                a:=random(maxLa)+1;
                b:=random(maxLg)+1;
            end;
            map[a,b]:=i;
        end;
    end;
       //verif et pose des items coeur et mystere
    for i:=4 to 5 do
    begin
        for j:=1 to 3 do
        begin
            a:=random(maxLa)+1;
            b:=random(maxLg)+1;
            while (map[a,b]<>0) do //si un autre nb que 0 est présent, on tire une nouvelle position afin d'eviter l'ecrasement de ce nb
            begin
                a:=random(maxLa)+1;
                b:=random(maxLg)+1;
            end;
            map[a,b]:=i;
        end;
    end;
          //verif et pose des deux trésors
        for j:=1 to 2 do
        begin
            a:=random(maxLa)+1;
            b:=random(maxLg)+1;
            while (map[a,b]<>0) do //si un autre nb que 0 est présent, on tire une nouvelle position afin d'eviter l'ecrasement de ce nb
            begin
                a:=random(maxLa)+1;
                b:=random(maxLg)+1;
            end;
            map[a,b]:=6;
    end;


    map[posX_L,posY_L]:=0;
    init:=map;

end;

function NtoC (N:integer):char;
//BUT: envoyer le caractere correspondant au chiffre reçu.
//ENTREE: chiffre venant de la map
//SORTIE:caractere a afficher
var C:char;
begin
    case N of
        0: C:=' '; //valeur par défaut map, correpond a un vide
        1: C:='R';//R pour Rocher
        2: C:='A';//A pour arbre
        3: C:='E';//E pour Eau
        4: C:='C';//C pour coeur
        5: C:='?';//? pour mystere
        6: C:='T';//T pour trésor
    end;
    NtoC:=C;
end;
procedure affichTab(map:tabNb);
//BUT: afficher map
//ENTREE:map
var i,j:integer;
begin
      for i:=1 to maxLg do
        begin
            for j:=1 to maxLa do
            begin
                textbackground(6);
                if (map[j,i]>=4) and (map[j,i]<=6) then
                    textcolor(blue)
                else
                    textcolor(black);
                write(NtoC(map[j,i]));
            end;
        writeln;
    end;
end;



procedure affichLink(posLink:coord;car:char);
begin
    gotoxy(posLink.x,posLink.y);
    textcolor(green);
    writeln(car);
end;

procedure affichStats(nbDuStat:integer;nbStat: integer);
begin
    if nbDuStat=4 then
        begin
        textcolor(blue);
        gotoxy(30,7); write(nbStat,' ',NtoC(nbDuStat));
        end
    else if nbDuStat=5 then
        begin
        textcolor(blue);
        gotoxy(34,7); write(nbStat,' ',NtoC(nbDuStat));
        end
    else if nbDuStat=6 then
        begin
        textcolor(blue);
        gotoxy(39,7); write(nbStat,' ',NtoC(nbDuStat));
        end;
end;






{
function verifDeplac(posLink:coord; input:char; map:tabNb):boolean;
var bool:boolean;
begin

    bool:=true;

    if (input='Z') or (input='z') then
    begin
        if ((posLink.y-1)<1) then
          begin
                bool:=false;
          end;
        if bool=true then
            begin
                if map[posLink.x,posLink.y-1]<>0 then
                    bool:=false;
          end;
    end


    else if (input='Q') or (input='q') then
    begiN
        if ((posLink.x-1)<1) then
          begin
            bool:=false;
          end;
        if bool=true then
          begin
            if map[posLink.x-1,posLink.y]<>0 then
                bool:=false;
          end;
    end

    else if (input='S') or (input='s') then
    begin
        if ((posLink.y+1)>maxLa) then
            begin
                bool:=false;
            end;
        if bool=true then
            begin
             if map[posLink.x,posLink.y+1]<>0 then
                    bool:=false;
            end;
    end

    else if (input='D') or (input='d') then
    begin
        if ((posLink.x+1)>maxLg) then
          begin
            bool:=false;
          end;
         if bool=true then
          begin
            if map[posLink.x+1,posLink.y]<>0 then
                bool:=false;
          end;
    end;

    verifDeplac:=bool;
end;

}

{function deplacLink(posLink:coord; hyrule:tabNb):coord;
var input:char;
var bool,fin:boolean;
begin
    repeat
        gotoxy(35,5);
        read (input);
    until (input='Z') or (input='Q') or (input='S') or (input='D') or (input='z') or (input='q') or (input='s') or (input='d') or (input=' ');

    bool:=false;

    if (input='Z') or (input='z') then
        begin
            bool:=verifDeplac(posLink, input,hyrule);
            if bool=true then
                begin
                gotoxy(posLink.x,posLink.y);write(' ');
                textcolor(green);
                gotoxy(posLink.x,posLink.y-1);write('L');
                 posLink.y:=posLink.y-1;
                end
            else
                begin
                gotoxy(posLink.x,posLink.y);write(' ');
                delay(5);
                 textcolor(green);
                gotoxy(posLink.x,posLink.y);write('L');
                end;
        end
    else if  (input='Q') or (input='q') then
        begin
            bool:=verifDeplac(posLink, input,hyrule);
            if bool=true then
                begin
                gotoxy(posLink.x,posLink.y);write(' ');
                 textcolor(green);
                gotoxy(posLink.x-1,posLink.y);write('L');
                 posLink.x:=posLink.x-1;
                end
            else
                begin
                gotoxy(posLink.x,posLink.y);write(' ');
                 textcolor(green);
                gotoxy(posLink.x,posLink.y);write('L');
                end;
        end
    else if  (input='S') or (input='s') then
        begin
            bool:=verifDeplac(posLink, input,hyrule);
            if bool=true then
                begin
                gotoxy(posLink.x,posLink.y);write(' ');
                 textcolor(green);
                gotoxy(posLink.x,posLink.y+1);write('L');
                 posLink.y:=posLink.y+1;
                end
            else
                begin
                gotoxy(posLink.x,posLink.y);write(' ');
                 textcolor(green);
                gotoxy(posLink.x,posLink.y);write('L');
                end;
        end
    else if  (input='D') or (input='d') then
        begin
            bool:=verifDeplac(posLink, input,hyrule);
            if bool=true then
                begin
                gotoxy(posLink.x,posLink.y);write(' ');
                 textcolor(green);
                gotoxy(posLink.x+1,posLink.y);write('L');
                posLink.x:=posLink.x+1;
                end
            else
                begin
                gotoxy(posLink.x,posLink.y);write(' ');
                 textcolor(green);
                gotoxy(posLink.x,posLink.y);write('L');
                end;
        end
    else if input=' ' then
        begin
        posLink.x:=-1;
        posLink.y:=-1;
        end;

    deplacLink:=posLink;
end;
}


procedure playMusic(morceau:integer);
begin
    case morceau of
     0: sndPlaySound('C:\freePascal\Tableaux\Zelda\sounds\mainThemeZelda.wav', snd_Async or snd_loop);
     1: sound(5000);
     4: sound(2000);
     5: sound(3000);
     6: sndPlaySound('C:\freePascal\Tableaux\Zelda\sounds\ouvertureTresor.wav', snd_Async or snd_NoDefault);
     end;

end;


function etatLink(link:joueur; posLinkTempX,posLinkTempY:integer):joueur;
begin
    if (posLinkTempX>0) and (posLinkTempX<=maxLa) and (posLinkTempY>0) and (posLinkTempY<=maxLg) and(link.hyrule[posLinkTempX, posLinkTempY]=0) then
        begin
            affichLink(link.position,' ');
            link.position.x:=posLinkTempX;
            link.position.y:=posLinkTempY;
            affichLink(link.position,'L');
        end
    else if(posLinkTempX>0) and (posLinkTempX<=maxLa) and (posLinkTempY>0) and (posLinkTempY<=maxLg) and(link.hyrule[posLinkTempX, posLinkTempY]=4) then
        begin
            affichLink(link.position,' ');
            link.position.x:=posLinkTempX;
            link.position.y:=posLinkTempY;
            affichLink(link.position,'L');

            link.nb.coeur:=link.nb.coeur+1;
            affichStats(link.hyrule[posLinkTempX, posLinkTempY],link.nb.coeur);
            playMusic(link.hyrule[posLinkTempX,posLinkTempY]);
            delay(150);
            nosound;
            link.hyrule[posLinkTempX, posLinkTempY]:=0;

        end
    else if(posLinkTempX>0) and (posLinkTempX<=maxLa) and (posLinkTempY>0) and (posLinkTempY<=maxLg) and(link.hyrule[posLinkTempX, posLinkTempY]=5) then
       begin
             affichLink(link.position,' ');
            link.position.x:=posLinkTempX;
            link.position.y:=posLinkTempY;
            affichLink(link.position,'L');

            link.nb.ptsMystere:=link.nb.ptsMystere+1;
            affichStats(link.hyrule[posLinkTempX, posLinkTempY],link.nb.ptsMystere);
            playMusic(link.hyrule[posLinkTempX,posLinkTempY]);
            delay(150);
            nosound;
            link.hyrule[posLinkTempX, posLinkTempY]:=0;

       end
    else if(posLinkTempX>0) and (posLinkTempX<=maxLa) and (posLinkTempY>0) and (posLinkTempY<=maxLg) and(link.hyrule[posLinkTempX, posLinkTempY]=6) then
       begin
            affichLink(link.position,' ');
            link.position.x:=posLinkTempX;
            link.position.y:=posLinkTempY;
            affichLink(link.position,'L');

            link.nb.tresor:=link.nb.tresor+1;
            affichStats(link.hyrule[posLinkTempX, posLinkTempY],link.nb.tresor);
            playMusic(link.hyrule[posLinkTempX,posLinkTempY]);
            link.hyrule[posLinkTempX, posLinkTempY]:=0;
            delay(12000);
            playMusic(0);
       end
    else
        begin
            playMusic(1);
            delay(150);
            nosound;
        end;


       etatLink:=link;
end;



// prog principal
//BUT:se déplacer avec Link dans Hyrule (tableau à deux dimensions présentant trois obstacles : Eau, Arbre, Rocher)
//ENTREE:inputs qui permettent de déplacer Link vers le haut,bas,gauche,droite
//SORTIE: affichage d'Hyrule et position de Link qui change selon le déplacement effectué

var ch:char;
var link:joueur;
var posLinkTemp:coord;
var fin:boolean;
{var
  image: TFPCustomImage;
  reader: TFPCustomImageReader;}

BEGIN
    //init de la map avec ses différents obstacles et placement initial de Link
    clrscr;
    randomize;
    cursoroff;
    playMusic(0);
    gotoxy(51,8);
    write('The Legend of Zelda');
    gotoxy(45,10);
    write('Appuyer sur entrer pour commencer');



    readln;

    clrscr;
    posLinkTemp.x:=posX_L;
    posLinkTemp.y:=posY_L;

    link.position.x:=posX_L;
    link.position.y:=posY_L;
    link.nb.coeur:=0;
    link.nb.ptsMystere:=0;
    link.nb.tresor:=0;
    link.hyrule:=init(link.hyrule);


    affichTab(link.hyrule);
    affichLink(link.position,'L');






    //déplacements de Link avec les quatres flèches
     repeat
    ch:=ReadKey;
    case ch of
     #0 : begin
            ch:=ReadKey; {Read ScanCode}
            case ch of
             #75 : link:=etatLink(link,posLinkTemp.x-1, posLinkTemp.y);//gauche
             #77 : link:=etatLink(link,posLinkTemp.x+1, posLinkTemp.y);//droite
             #72 : link:=etatLink(link,posLinkTemp.x,   posLinkTemp.y-1);//haut
             #80 : link:=etatLink(link,posLinkTemp.x,   posLinkTemp.y+1);//bas
            end;
          end;
    #27 : exit;
    end;
     posLinkTemp.x:=link.position.x;
     posLinkTemp.y:=link.position.y;
  until ch=#27 {Esc}

END.

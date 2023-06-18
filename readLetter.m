function letter=readLetter(snap)
% disp('readingletter');
%READLETTER reads the character fromthe character's binary image.
%   LETTER=READLETTER(SNAP) outputs the character in class 'char' from the
%   input binary image SNAP.

load NewTemplates % Loads the templates of characters in the memory.
snap=imresize(snap,[42 24]); % Resize the input image so it can be compared with the template's images.
comp=[ ];
for n=1:length(NewTemplates)
    sem=corr2(NewTemplates{1,n},snap); % Correlation the input image with every image in the template for best matching.
    comp=[comp sem]; % Record the value of correlation for each template's character.
end
vd=find(comp==max(comp)); % Find the index which correspond to the highest matched character.
%*-*-*-*-*-*-*-*-*-*-*-*-*-
% Accodrding to the index assign to 'letter'.
% Alphabets listings.
if vd==1
    letter='1';
elseif vd==2
    letter='2';
elseif vd==3 || vd==4
    letter='3';
elseif vd==6|| vd==5
    letter='4';
elseif vd==7
    letter='5';
elseif vd==10 || vd==8 ||vd==9
    letter='6';
elseif vd==11
    letter='7';
elseif vd==13 || vd==12
    letter='8';
elseif vd==16 || vd==14 || vd==15
    letter='9';
elseif vd==18 || vd==17
    letter='0';
elseif vd==20|| vd==19
    letter='A';
elseif vd==22 || vd==21
    letter='B';
elseif vd==23
    letter='C';
elseif vd==25 || vd==24
    letter='D';
elseif vd==26
    letter='E';
elseif vd==27
    letter='F';
elseif vd==28
    letter='G';
elseif vd==29
    letter='H';
elseif vd==30
    letter='I';
elseif vd==31
    letter='J';
elseif vd==32
    letter='K';
elseif vd==33
    letter='L';
elseif vd==35|| vd==34
    letter='M';
elseif vd==36
    letter='N';
elseif vd==38 || vd==37
    letter='O';
elseif vd==40||vd==39
    letter='P';
    %*-*-*-*-*
% Numerals listings.
elseif vd==42||vd==41
    letter='Q';
elseif vd==45||vd==43||vd==44
    letter='R';
elseif vd==46
    letter='S';
elseif vd==47 
    letter='T';
elseif vd==48
    letter='U';
elseif vd==49 
    letter='V';
elseif vd==50
    letter='W';
elseif vd==51 
    letter='X';
elseif vd==52
    letter= 'Y';
else
    
    letter='Z';
end
end
%% Image segmentation and extraction
%% Read Image
function segexp()
imagen=imread('newocr.jpg');
%% Show image
figure(1)
imshow(imagen);
title('INPUT IMAGE WITH NOISE')
%% Convert to gray scale
if size(imagen,3)==3 % RGB image
    imagen=rgb2gray(imagen);
end
%% Convert to binary image
threshold = graythresh(imagen);
imagen =~im2bw(imagen,threshold);
%% Remove all object containing fewer than 30 pixels
imagen = bwareaopen(imagen,30);
pause(1)
%% Show image binary image
figure(2)
imshow(~imagen);
title('INPUT IMAGE WITHOUT NOISE')
%% Label connected components
[L Ne]=bwlabel(imagen);
%% Measure properties of image regions
propied=regionprops(L,'BoundingBox');
hold on
%% Plot Bounding Box
for n=1:size(propied,1)
    rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
%     disp(propied(n).Perimeter);
end
hold off
pause (2)
%% Objects extraction
figure

word=[ ];
re=imagen;
%Opens text.txt as file for write
fid = fopen('text.txt', 'wt');
% Load templates
load NewTemplates
global NewTemplates
% Compute the number of letters in template file
num_letras=size(NewTemplates,2);
counter=0;
for n=1:Ne
     [r,c] = find(L==n);
    n1=imagen(min(r):max(r),min(c):max(c));
     [pixr(1,n) pixc(1,n)]=size(n1);
    if(pixr(1,n)>110 && pixc(1,n)>20 && pixr(1,n)<310 )
         imshow(~n1);
         pause(1)
        img_r=imresize(n1,[42 24]);
        %Uncomment line below to see letters one by one
         imshow(img_r);pause(0.5);
        letter=readLetter(img_r);
         word=[word letter]
    end
    
    end
fprintf(fid,'%s\n',word);%Write 'word' in text file (upper)
fclose(fid);
winopen('text.txt')

text1=word
% s=serial('COM5');
% if text1=='KAO3MJ1011'
%         result=urlread('http://localhost/vehicle/pay.php?id=1')
%         num=result(17:29);
%         subchunk = regexp(num, '(?<=")[^"]+(?=")', 'match');
%         numstr = subchunk{1}
% 
%         amount=result(43:end);
%         subchunk1 = regexp(amount, '(?<=")[^"]+(?=")', 'match');
%         amtstr = subchunk1{1}
%         if (str2num(amtstr)>0)
%         sendstr=strcat('G0','M',numstr,'A',amtstr,'@')
%         fopen(s)
%         fwrite(s,sendstr)
%         fclose(s)
%         else
%         amtstr=num2str(abs(str2num(amtstr)))
%         sendstr=strcat('G1','M',numstr,'A','000','@')
%         fopen(s)
%         fwrite(s,sendstr)
%         fclose(s)
%         end
% elseif(text1=='KA65H4546')
%         result=urlread('http://localhost/vehicle/pay.php?id=2')
%         num=result(17:29);
%         subchunk = regexp(num, '(?<=")[^"]+(?=")', 'match');
%         numstr = subchunk{1}
% 
%         amount=result(43:end);
%         subchunk1 = regexp(amount, '(?<=")[^"]+(?=")', 'match');
%         amtstr = subchunk1{1}
%        if (str2num(amtstr)>0)
%         sendstr=strcat('G0','M',numstr,'A',amtstr,'@')
%         fopen(s)
%         fwrite(s,sendstr)
%         fclose(s)
%        else
%         amtstr=num2str(abs(str2num(amtstr)))
%         sendstr=strcat('G1','M',numstr,'A','000','@')
%         fopen(s)
%         fwrite(s,sendstr)
%         fclose(s)
%         end
% elseif(text1=='KAO4CA4943')
%         result=urlread('http://localhost/vehicle/pay.php?id=3')
%         num=result(17:29);
%         subchunk = regexp(num, '(?<=")[^"]+(?=")', 'match');
%         numstr = subchunk{1}
% 
%         amount=result(43:end);
%         subchunk1 = regexp(amount, '(?<=")[^"]+(?=")', 'match');
%         amtstr = subchunk1{1}
%         if (str2num(amtstr)>0)
%         sendstr=strcat('G0','M',numstr,'A',amtstr,'@')
%         fopen(s)
%         fwrite(s,sendstr)
%         fclose(s)
%         else
%             amtstr=num2str(abs(str2num(amtstr)))
%         sendstr=strcat('G1','M',numstr,'A','000','@')
%         fopen(s)
%         fwrite(s,sendstr)
%         fclose(s)
%         end
% elseif(text1=='KA14CP6748')
%         result=urlread('http://localhost/vehicle/pay.php?id=4')
%         num=result(17:29);
%         subchunk = regexp(num, '(?<=")[^"]+(?=")', 'match');
%         numstr = subchunk{1}
% 
%         amount=result(43:end);
%         subchunk1 = regexp(amount, '(?<=")[^"]+(?=")', 'match');
%         amtstr = subchunk1{1}
%        if (str2num(amtstr)>0)
%         sendstr=strcat('G0','M',numstr,'A',amtstr,'@')
%         fopen(s)
%         fwrite(s,sendstr)
%         fclose(s)
%        else
%             amtstr=num2str(abs(str2num(amtstr)))
%         sendstr=strcat('G1','M',numstr,'A','000','@')
%         fopen(s)
%         fwrite(s,sendstr)
%         fclose(s)
%         end
% else
%         sendstr=strcat('G1M0000000000A000@')
%         fopen(s)
%         fwrite(s,sendstr)
%         fclose(s)
% end
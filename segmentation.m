%% Image segmentation and extraction
%% Read Image
function segmentation()
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
imagen = bwareaopen(imagen,100);
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
    
end
hold off
pause (2)
%% Objects extraction
figure
for n=1:Ne
    [r,c] = find(L==n);
    n1=imagen(min(r):max(r),min(c):max(c));
     [pixr(1,n) pixc(1,n)]=size(n1);
     disp(size(n1))
     if(pixr(1,n)>130 && pixc(1,n)>20  )
     imshow(~n1);
     kl=~n1;
     readLetter(kl);
    pause(1)
    
    end
end
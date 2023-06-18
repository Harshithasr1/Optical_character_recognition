function preprocessing(newimg)
%NUMBERPLATEEXTRACTION extracts the characters from the input number plate image.

f=newimg; % Reading the number plate image.
f=imresize(f,[400 NaN]);
figure(1),imshow(f);
title('org img ');% Resizing the image keeping aspect ratio same.
g=rgb2gray(f);
level=graythresh(g);
f1=imsharpen(g);
figure(2),imshow(f1);
title('sharp img');
f1=imadjust(f1);
figure(3),imshow(f1);
title('adj img');
f2=adapthisteq(f1);
figure(4),imshow(f2);
title('histeq');
f2=im2bw(f2);
figure(5),imshow(f2);
title('bin img');
f2=bwmorph(f2,'bridge',Inf);
figure(6),imshow(f2);
title('aftr morph');
% Converting the RGB (color) image to gray (intensity).
g=medfilt2(f2,[3 3]);
figure(7),imshow(f2);
title('after noise');% Median filtering to remove noise.
se=strel('disk',1); % Structural element (disk of radius 1) for morphological processing.
gi=imdilate(g,se);
figure(2),imshow(f);% Dilating the gray image with the structural element.
ge=imerode(g,se);
figure(3),imshow(f);% Eroding the gray image with structural element.
gdif=imsubtract(gi,ge); 
figure(4),imshow(gdif);% Morphological Gradient for edges enhancement.
gdiff=mat2gray(gdif);
figure(5),imshow(gdiff);% Converting the class to double.
gdiff=conv2(gdiff,[1 1;1 1]);
figure(6),imshow(gdiff);% Convolution of the double image for brightening the edges.
gdiff=imadjust(gdiff,[0.5 0.7],[0 1],0.1); % Intensity scaling between the range 0 to 1.
B=logical(gdiff);
figure(7),imshow(B);
% Conversion of the class from double to binary. 
% Eliminating the possible horizontal lines from the output image of regiongrow
% that could be edges of license plate.
er=imopen(B,strel('line',level,0));
figure(8),imshow(er);
out1=imsubtract(B,er);
figure(9),imshow(out1);
f2=bwmorph(f2,'bridge',Inf);
% Filling all the regions of the image.
F=imfill(out1,'holes');
figure(10),imshow(F);
% Thinning the image to ensure character isolation.
H=bwmorph(F,'thin',1);
figure(11),imshow(H);
 H=imerode(H,strel('line',4,0));
figure(12),imshow(H);
% Selecting all the regions that are of pixel area more than 100.
final=bwareaopen(H,250);
 final=~final;
figure(13),imshow(final);

imwrite(final,'newocr.jpg');
segexp();

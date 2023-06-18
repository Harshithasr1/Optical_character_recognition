 function newimg=cropped(f)
% clc
% clear all
% close all
warning off
% load templates;
%%
    %f=imread('im13.jpg');
    f=imresize(f,[700 NaN]); 
%imwrite(RGBimg,writeNam);
    %figure(1), imshow(RGBimg); % Color Image
    grayImg = rgb2gray(f); %convert gray
    % figure(2), imshow(grayImg);
    % median filter is applied for smoothing and unwanted noise removal
    grayImg = medfilt2(grayImg,[3 3]);
    %   dynamic thresholding is appiled
    grayImg = adapthisteq(grayImg);
    % figure(3), imshow(grayImg);
    %%
    
    % discret wavelet transform is applied for enhance the edge
    [LL LH HL HH] = dwt2(grayImg, 'haar');
    imgDWT = [LL,LH;HL,HH];
    % figure(4), imshow(imgDWT,[]);
    % find LH edge
    
    edgeImg = HL > 10;
    %         figure(5), imshow(edgeImg,[]);
    
    hei = edge(edgeImg,'sobel',0.11,'horizontal');
    vei = edge(edgeImg,'sobel',0.11,'vertical');
    vei2 = edge(edgeImg,'sobel',0.11,'vertical');
    vei = rot90(vei);
    horizontalProjection = sum(vei);
    verticalProjection = sum(hei);
    horizontalProjection(1:100)=0;
    maxIndexValue= find(horizontalProjection == max(horizontalProjection), 1, 'last' );
    top = maxIndexValue;tip = maxIndexValue;
    k=0.35;
    threshold = max(horizontalProjection)*k;
    s = std(horizontalProjection);
    
    while(horizontalProjection(1,top)>s)
        top = top-1;
    end
    while(horizontalProjection(1,tip)>s)
        tip = tip+1;
    end
    
    band = grayImg(top*2:tip*2,:);
    cannyBand = ~im2bw(band,0.5);
    msk=[0 1 1 1 0;
        0 1 1 1 0;
        0 1 1 1 0;];
    
    CC = bwconncomp(cannyBand);
    imgComp = imcomplement(cannyBand);
    label = bwlabel(imgComp);
    area = regionprops(label, 'Area');
    for no = 1:size(area,1)
        if (area(no,1).Area > 2000)
            
        else
            loclabel = find(label == no);
            label(loclabel) = 0;
        end
        
    end
    verticalBrightnessProjection = mean(band);
    rgbBand = f(top*1.5:tip*2,:,:);

    newimg=imresize(rgbBand,2);
%    imwrite(rgbBand,'c:\users\murali\documents\matlab\newimg.jpg');
%     figure(1),imshow(newimg);
    preprocessing(newimg);

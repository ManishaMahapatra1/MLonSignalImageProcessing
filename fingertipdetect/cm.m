clc;
clear all;
close all;
A = imread('C:\Users\ECEDELL07\Desktop\workshop\finger tip detection\two.jpg'); %reading the image
B = rgb2gray(A);                                 %converting to gray image
C = max(max(B))-B;
[M,N] = size(B);
for i = 1:M
    for j = 1:N
        if C(i,j)>=20
            C(i,j) = 255;
        else
            C(i,j) = 0;
        end
    end
end
imshow(C,[]);
se = strel('disk',5);
D = imdilate(C,se);
imshow(D,[]);
cen = regionprops(D,'centroid');
bou = bwboundaries(D);
for k = 1:length(bou)
    boundary = bou{k};
end
centroids = cat(1, cen.Centroid);
centroids = centroids(255,:);
 centroids(1,1) = centroids(1,1);
 bou = cat(1,bou);
hold on,
plot(centroids(:,1),centroids(:,2), 'b*')
centroids(2)=centroids(2)+70;
plot(boundary(:,2),boundary(:,1),'r');
hold off,
for i =1:length(boundary(:,1))
    ff(i) = sqrt(((boundary(i,2)-centroids(1,1))^2)+((boundary(i,1)-centroids(1,2))^2));
end
figure,

 %% applying average filter
b = (1/20)*ones(1,20);
a=1;
BB = filtfilt(b,a,ff);
plot(BB);

%% finding the peak values
[pk,lo] = findpeaks(BB,'MinPeakHeight',90 );
hold on,
%stem(lo(1,(1:end-1)),pk(1,(1:end-1)));
stem(lo(1,1:end-1),pk(1,1:end-1));
hold off,
figure,
imshow(D,[]);
hold on,

%% locating the tips on the image
for i = 1:length(lo)-1
plot(boundary(lo(i),2),boundary(lo(i),1),'r*');
if i<=length(lo)-2
  line([boundary(lo(i),2) boundary(lo(i+1),2)],[boundary(lo(i),1) boundary(lo(i+1),1)]);
end
end
plot(centroids(:,1),centroids(:,2), 'b*');


%detect a box,glue,calender, elephant
%book, glasses, paperweight from a clutter of image
clear;clc;
%loading two images
boximage=imread('box.jpeg');
boximage=rgb2gray(boximage);
figure;
imshow(boximage);
title('image of box');
sceneimage=imread('desk.jpeg');
sceneimage=rgb2gray(sceneimage);
figure;
imshow(sceneimage);
title('cluttered image of desk');

%detecting feature points
boxpoints=detectSURFFeatures(boximage);
scenepoints=detectSURFFeatures(sceneimage);

%visualise strongest features
figure;
imshow(boximage);
title('100 strongest feature found in image');
hold on;
plot(selectStrongest(boxpoints,100));
%for comparison visualise the strongest feature found
%in the target image
imshow(sceneimage);
title('300 strongest feature found in image');
hold on;
plot(selectStrongest(scenepoints,300));

%extracting feature descriptors
[boxfeatures, boxpoints]= extractFeatures(boximage, boxpoints);
[scenefeatures, scenepoints]= extractFeatures(sceneimage, scenepoints);

%finding and matching features
boxpairs=matchFeatures(boxfeatures, scenefeatures);
disp 'putatively matched features.'
matchedboxpoints= boxpoints(boxpairs(:,1),:);
matchedscenepoints= scenepoints(boxpairs(:,2),:);
figure;
showMatchedFeatures(boximage, sceneimage, matchedboxpoints,matchedscenepoints, 'montage');
title('putatively matched points (including outliers)');

%locating object in scene
[tform, inlierboxpoints, inlierscenepoints]= estimateGeometricTransform(matchedboxpoints, matchedscenepoints,'affine');
figure;
showMatchedFeatures(boximage, sceneimage,inlierboxpoints,inlierscenepoints,'montage');
title('matched points(inliers only)');
%bounding polygon of reference image
boxpolygon=[1,1; size(boximage,2),1; size(boximage,2),size(boximage,1); 1,size(boximage,1); 1,1];
%transforming polygon into coordinate to display in the image
newboxpolygon=transformPointsForward(tform, boxpolygon);
%display detected object
figure;
imshow(sceneimage);
hold on;
line(newboxpolygon(:,1), newboxpolygon(:,2), 'Color','y');
title('detected box');

%detecting another object
elephantimage=imread('elephant2.jpeg');
elephantimage=rgb2gray(elephantimage);
figure;
imshow(elephantimage);
title('image of elephant');
%detecting features from elephant
elephantpoints=detectSURFFeatures(elephantimage);
figure;
imshow(elephantimage);
plot(selectStrongest(elephantpoints,100));
title('100 strong features');
%extracting features
[elephantfeatures, elephantpoints]=extractFeatures(elephantimage,elephantpoints);
%match features
elephantpairs = matchFeatures(elephantfeatures, scenefeatures,'MaxRatio',0.9);
matchedelephantpoints= elephantpoints(elephantpairs(:,1),:);
matchedscenepoints= scenepoints(elephantpairs(:,2),:);
figure;
showMatchedFeatures(elephantimage, sceneimage, matchedelephantpoints,matchedscenepoints, 'montage');
title('putatively matched points (including outliers)');
%transformation to coordinates
[tform, inlierelephantpoints, inlierscenepoints]= estimateGeometricTransform(matchedelephantpoints, matchedscenepoints,'affine');
figure;
showMatchedFeatures(elephantimage, sceneimage,inlierelephantpoints,inlierscenepoints,'montage');
title('matched points(inliers only)');

elephantpolygon=[1,1; size(elephantimage,2),1; size(elephantimage,2),size(elephantimage,1); 1,size(elephantimage,1); 1,1];
%transforming polygon into coordinate to display in the image
newelephantpolygon=transformPointsForward(tform, elephantpolygon);
%display detected object
figure;
imshow(sceneimage);
hold on;
line(newboxpolygon(:,1), newboxpolygon(:,2), 'Color','y');
line(newelephantpolygon(:,1), newelephantpolygon(:,2), 'Color','g');
title('detected elephant and box');


%detecting another object
elephantimage1=imread('calculator.jpeg');
elephantimage1=rgb2gray(elephantimage1);
figure;
imshow(elephantimage1);
title('image of elephant');
%detecting features from elephant
elephantpoints1=detectSURFFeatures(elephantimage1);
figure;
imshow(elephantimage1);
plot(selectStrongest(elephantpoints1,100));
title('100 strong features');
%extracting features
[elephantfeatures1, elephantpoints1]=extractFeatures(elephantimage1,elephantpoints1);
%match features
elephantpairs1 = matchFeatures(elephantfeatures1, scenefeatures,'MaxRatio',0.9);
matchedelephantpoints1= elephantpoints1(elephantpairs1(:,1),:);
matchedscenepoints= scenepoints(elephantpairs1(:,2),:);
figure;
showMatchedFeatures(elephantimage1, sceneimage, matchedelephantpoints1,matchedscenepoints, 'montage');
title('putatively matched points (including outliers)');
%transformation to coordinates
[tform, inlierelephantpoints1, inlierscenepoints]= estimateGeometricTransform(matchedelephantpoints1, matchedscenepoints,'affine');
figure;
showMatchedFeatures(elephantimage1, sceneimage,inlierelephantpoints1,inlierscenepoints,'montage');
title('matched points(inliers only)');

elephantpolygon1=[1,1; size(elephantimage1,2),1; size(elephantimage1,2),size(elephantimage1,1); 1,size(elephantimage1,1); 1,1];
%transforming polygon into coordinate to display in the image
newelephantpolygon1=transformPointsForward(tform, elephantpolygon1);
%display detected object
figure;
imshow(sceneimage);
hold on;
line(newboxpolygon(:,1), newboxpolygon(:,2), 'Color','y');
line(newelephantpolygon1(:,1), newelephantpolygon1(:,2), 'Color','g');
line(newelephantpolygon(:,1), newelephantpolygon(:,2), 'Color','g');
title('detected elephant and box and calculator');

%detecting another object
glueimage1=imread('glue.jpeg');
glueimage1=rgb2gray(glueimage1);
figure;
imshow(glueimage1);
title('image of glue');
%detecting features from glue
gluepoints1=detectSURFFeatures(glueimage1);
figure;
imshow(glueimage1);
plot(selectStrongest(gluepoints1,100));
title('100 strong features');
%extracting features
[gluefeatures1, gluepoints1]=extractFeatures(glueimage1,gluepoints1);
%match features
gluepairs1 = matchFeatures(gluefeatures1, scenefeatures,'MaxRatio',0.9);
matchedgluepoints1= gluepoints1(gluepairs1(:,1),:);
matchedscenepoints= scenepoints(gluepairs1(:,2),:);
figure;
showMatchedFeatures(glueimage1, sceneimage, matchedgluepoints1,matchedscenepoints, 'montage');
title('putatively matched points (including outliers)');
%transformation to coordinates
[tform, inliergluepoints1, inlierscenepoints]= estimateGeometricTransform(matchedgluepoints1, matchedscenepoints,'affine');
figure;
showMatchedFeatures(glueimage1, sceneimage,inliergluepoints1,inlierscenepoints,'montage');
title('matched points(inliers only)');

gluepolygon1=[1,1; size(glueimage1,2),1; size(glueimage1,2),size(glueimage1,1); 1,size(glueimage1,1); 1,1];
%transforming polygon into coordinate to display in the image
newgluepolygon1=transformPointsForward(tform, gluepolygon1);
%display detected object
figure;
imshow(sceneimage);
hold on;
line(newboxpolygon(:,1), newboxpolygon(:,2), 'Color','y');
line(newelephantpolygon1(:,1), newelephantpolygon1(:,2), 'Color','g');
line(newelephantpolygon(:,1), newelephantpolygon(:,2), 'Color','g');
line(newgluepolygon1(:,1), newgluepolygon1(:,2), 'Color','g');
title('detected elephant and box and calculator and glue');

%detecting another object
paperweightimage1=imread('paperweight.jpeg');
paperweightimage1=rgb2gray(paperweightimage1);
figure;
imshow(paperweightimage1);
title('image of paperweight');
%detecting features from paperweight
paperweightpoints1=detectSURFFeatures(paperweightimage1);
figure;
imshow(paperweightimage1);
plot(selectStrongest(paperweightpoints1,100));
title('100 strong features');
%extracting features
[paperweightfeatures1, paperweightpoints1]=extractFeatures(paperweightimage1,paperweightpoints1);
%match features
paperweightpairs1 = matchFeatures(paperweightfeatures1, scenefeatures,'MaxRatio',0.9);
matchedpaperweightpoints1= paperweightpoints1(paperweightpairs1(:,1),:);
matchedscenepoints= scenepoints(paperweightpairs1(:,2),:);
figure;
showMatchedFeatures(paperweightimage1, sceneimage, matchedpaperweightpoints1,matchedscenepoints, 'montage');
title('putatively matched points (including outliers)');
%transformation to coordinates
[tform, inlierpaperweightpoints1, inlierscenepoints]= estimateGeometricTransform(matchedpaperweightpoints1, matchedscenepoints,'affine');
figure;
showMatchedFeatures(paperweightimage1, sceneimage,inlierpaperweightpoints1,inlierscenepoints,'montage');
title('matched points(inliers only)');

paperweightpolygon1=[1,1; size(paperweightimage1,2),1; size(paperweightimage1,2),size(paperweightimage1,1); 1,size(paperweightimage1,1); 1,1];
%transforming polygon into coordinate to display in the image
newpaperweightpolygon1=transformPointsForward(tform, paperweightpolygon1);
%display detected object
figure;
imshow(sceneimage);
hold on;
line(newboxpolygon(:,1), newboxpolygon(:,2), 'Color','y');
line(newelephantpolygon1(:,1), newelephantpolygon1(:,2), 'Color','g');
line(newelephantpolygon(:,1), newelephantpolygon(:,2), 'Color','g');
line(newgluepolygon1(:,1), newgluepolygon1(:,2), 'Color','g');
line(newpaperweightpolygon1(:,1), newpaperweightpolygon1(:,2), 'Color','g');
title('detected elephant and box and calculator and glue and paperweight');


%detecting another object
glassimage1=imread('glass.jpeg');
glassimage1=rgb2gray(glassimage1);
figure;
imshow(glassimage1);
title('image of glass');
%detecting features from glass
glasspoints1=detectSURFFeatures(glassimage1);
figure;
imshow(glassimage1);
plot(selectStrongest(glasspoints1,100));
title('100 strong features');
%extracting features
[glassfeatures1, glasspoints1]=extractFeatures(glassimage1,glasspoints1);
%match features
glasspairs1 = matchFeatures(glassfeatures1, scenefeatures,'MaxRatio',0.9);
matchedglasspoints1= glasspoints1(glasspairs1(:,1),:);
matchedscenepoints= scenepoints(glasspairs1(:,2),:);
figure;
showMatchedFeatures(glassimage1, sceneimage, matchedglasspoints1,matchedscenepoints, 'montage');
title('putatively matched points (including outliers)');
%transformation to coordinates
[tform, inlierglasspoints1, inlierscenepoints]= estimateGeometricTransform(matchedglasspoints1, matchedscenepoints,'affine');
figure;
showMatchedFeatures(glassimage1, sceneimage,inlierglasspoints1,inlierscenepoints,'montage');
title('matched points(inliers only)');

glasspolygon1=[1,1; size(glassimage1,2),1; size(glassimage1,2),size(glassimage1,1); 1,size(glassimage1,1); 1,1];
%transforming polygon into coordinate to display in the image
newglasspolygon1=transformPointsForward(tform, glasspolygon1);
%display detected object
figure;
imshow(sceneimage);
hold on;
line(newboxpolygon(:,1), newboxpolygon(:,2), 'Color','y');
line(newelephantpolygon1(:,1), newelephantpolygon1(:,2), 'Color','g');
line(newelephantpolygon(:,1), newelephantpolygon(:,2), 'Color','g');
line(newgluepolygon1(:,1), newgluepolygon1(:,2), 'Color','g');
line(newglasspolygon1(:,1), newglasspolygon1(:,2), 'Color','g');
line(newpaperweightpolygon1(:,1), newpaperweightpolygon1(:,2), 'Color','g');
title('detected elephant and box and calculator and glue and paperweight and glass');


%detecting another object
calenderimage1=imread('calender.jpeg');
calenderimage1=rgb2gray(calenderimage1);
figure;
imshow(calenderimage1);
title('image of calender');
%detecting features from calender
calenderpoints1=detectSURFFeatures(calenderimage1);
figure;
imshow(calenderimage1);
plot(selectStrongest(calenderpoints1,100));
title('100 strong features');
%extracting features
[calenderfeatures1, calenderpoints1]=extractFeatures(calenderimage1,calenderpoints1);
%match features
calenderpairs1 = matchFeatures(calenderfeatures1, scenefeatures,'MaxRatio',0.9);
matchedcalenderpoints1= calenderpoints1(calenderpairs1(:,1),:);
matchedscenepoints= scenepoints(calenderpairs1(:,2),:);
figure;
showMatchedFeatures(calenderimage1, sceneimage, matchedcalenderpoints1,matchedscenepoints, 'montage');
title('putatively matched points (including outliers)');
%transformation to coordinates
[tform, inliercalenderpoints1, inlierscenepoints]= estimateGeometricTransform(matchedcalenderpoints1, matchedscenepoints,'affine');
figure;
showMatchedFeatures(calenderimage1, sceneimage,inliercalenderpoints1,inlierscenepoints,'montage');
title('matched points(inliers only)');

calenderpolygon1=[1,1; size(calenderimage1,2),1; size(calenderimage1,2),size(calenderimage1,1); 1,size(calenderimage1,1); 1,1];
%transforming polygon into coordinate to display in the image
newcalenderpolygon1=transformPointsForward(tform, calenderpolygon1);
%display detected object
figure;
imshow(sceneimage);
hold on;
line(newboxpolygon(:,1), newboxpolygon(:,2), 'Color','y');
line(newelephantpolygon1(:,1), newelephantpolygon1(:,2), 'Color','g');
line(newelephantpolygon(:,1), newelephantpolygon(:,2), 'Color','g');
line(newgluepolygon1(:,1), newgluepolygon1(:,2), 'Color','g');
line(newcalenderpolygon1(:,1), newcalenderpolygon1(:,2), 'Color','g');
line(newpaperweightpolygon1(:,1), newpaperweightpolygon1(:,2), 'Color','g');
line(newglasspolygon1(:,1), newglasspolygon1(:,2), 'Color','g');
title('detected elephant and box and calculator and glue and paperweight and glass and calender');

%detecting another object
bookimage1=imread('book.jpeg');
bookimage1=rgb2gray(bookimage1);
figure;
imshow(bookimage1);
title('image of book');
%detecting features from book
bookpoints1=detectSURFFeatures(bookimage1);
figure;
imshow(bookimage1);
plot(selectStrongest(bookpoints1,100));
title('100 strong features');
%extracting features
[bookfeatures1, bookpoints1]=extractFeatures(bookimage1,bookpoints1);
%match features
bookpairs1 = matchFeatures(bookfeatures1, scenefeatures,'MaxRatio',0.9);
matchedbookpoints1= bookpoints1(bookpairs1(:,1),:);
matchedscenepoints= scenepoints(bookpairs1(:,2),:);
figure;
showMatchedFeatures(bookimage1, sceneimage, matchedbookpoints1,matchedscenepoints, 'montage');
title('putatively matched points (including outliers)');
%transformation to coordinates
[tform, inlierbookpoints1, inlierscenepoints]= estimateGeometricTransform(matchedbookpoints1, matchedscenepoints,'affine');
figure;
showMatchedFeatures(bookimage1, sceneimage,inlierbookpoints1,inlierscenepoints,'montage');
title('matched points(inliers only)');

bookpolygon1=[1,1; size(bookimage1,2),1; size(bookimage1,2),size(bookimage1,1); 1,size(bookimage1,1); 1,1];
%transforming polygon into coordinate to display in the image
newbookpolygon1=transformPointsForward(tform, bookpolygon1);
%display detected object
figure;
imshow(sceneimage);
hold on;
line(newboxpolygon(:,1), newboxpolygon(:,2), 'Color','y');
line(newelephantpolygon1(:,1), newelephantpolygon1(:,2), 'Color','g');
line(newelephantpolygon(:,1), newelephantpolygon(:,2), 'Color','g');
line(newgluepolygon1(:,1), newgluepolygon1(:,2), 'Color','g');
line(newbookpolygon1(:,1), newbookpolygon1(:,2), 'Color','g');
line(newpaperweightpolygon1(:,1), newpaperweightpolygon1(:,2), 'Color','g');
line(newglasspolygon1(:,1), newglasspolygon1(:,2), 'Color','g');
line(newcalenderpolygon1(:,1), newcalenderpolygon1(:,2), 'Color','g');
title('detected elephant and box and calculator and glue and paperweight and glass and book and calender');

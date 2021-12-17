%% 3.2 Intensity Transformation Function
%% imadjust
f = imread('breastXray.tif');
g1 = imadjust(f, [0 1], [1 0]);
g2 = imadjust(f, [0.5 0.75], [0 1]);
g3 = imadjust(f, [], [], 2);
figure, imshow(g3);
%% stretchlim
g4 = imadjust(f, stretchlim(f), []);
g5 = imadjust(f, stretchlim(f), [1 0]);
figure, imshow(f);
figure, imshow(g4);
figure, imshow(g5);
%% Lograthmic Transformation
f = imread('fourier_transform.tif');
figure, imshow(f);
logf = log(1 + double(f));
g = im2uint8(mat2gray(logf));
figure, imshow(g);
%% Specifying Arbitrary Intensity Transformations
r = linspace(0, 1, 16);
f = imread('lunar-shadows.tif');
fdoub = im2double(f);
figure, imshow(f);
T = r.^2;
g = interp1(r, T, fdoub);
figure, imshow(g);
%% Custom Functions for Manipulating Image Intensities
f = imread('bonescan.tif');
fdouble = im2double(f);
m = mean2(fdouble);
E = 0.9;
figure, imshow(fdouble);
g = intensityTransformations(fdouble, 'stretch', m, E);
figure, imshow(g);
r = 0:1/255:1;
T = 1./(1 + m./r).^E;
figure, plot(T);
%% A function for Intensity Scaling
X = [1 2 3 ;4 5 6;7 8 9];
idx = find(X >= 3 & X < 6);
[r, c] = find(X >= 3 & X < 6);
disp([r,c]);
intensityScaling
%% 3.3 Histogram Processing
f = imread('liver_cells.jpg');
f = rgb2gray(f);
%figure, imshow(f);
h = imhist(f, 30)/numel(f)
horz = linspace(0, 255, 30);
figure, bar(horz, h, 'FaceColor', [0 106 78]/255, 'EdgeColor', [0 212 156]/255, 'LineWidth', 0.75);
ax = gca;
ax.Color = [190 228 223]/255;
ax.YTick = 0:max(h(:))/4:max(h(:));
ax.FontName = 'Times Ten';
ax.FontSize = 8;
%% Histogram Equalization
f = imread('flower.jpeg');
figure, imshow(f);
g = histeq(f, 256);
figure, imshow(g);
figure, imhist(f);
figure, imhist(g);
hnorm = imhist(f)/numel(f);
cdf = cumsum(hnorm);
r = linspace(0,1,256);
figure, plot(r, cdf);
%% Histogram Matching
f = im2double(imread('chestXray.jpg'));
figure, imshow(f);
load goldenChestXrayHistogram
figure, plot(f, goldenChestXrayHistogram);
%% Adaptive Histogram Equalization
f = imread('hidden-symbols.tif');
figure, imshow(f); 
fe = histeq(f, 100);
figure, imshow(fe);
g = adapthisteq(f,'ClipLimit',0.4,'Distribution','exponential','NumTiles',[12 12]);
figure, imshow(g);






%% 3.4 Linear Spatial Filtering
%% 3.5 Nonlinear Spatial Filtering
%% 3.6 Using Fuzzy Sets for Intensity Transformations and Spatial Filtering

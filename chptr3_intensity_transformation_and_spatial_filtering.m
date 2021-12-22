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
f = im2double(rgb2gray(imread('four-squares.jpg')));
figure, imshow(f);
w = ones(31);
gd = imfilter(f, w);
figure, imshow(gd, []);
gr = imfilter(f, w, 'replicate');
figure, imshow(gr, []);
gs = imfilter(f, w, 'symmetric');
figure, imshow(gs, []);
gc = imfilter(f, w, 'circular');
figure, imshow(gc, []);
f8 = im2uint8(f);
g8r = imfilter(f8,w,'replicate');
figure, imshow(g8r, []);
%% Fspecial and Imfilter for image smoothing
f = imread('test_pattern.tif');
figure, imshow(f);
[M N] = size(f);
sig = 0.01*M;
r = ceil(6*sig);
r = r -1;
w1 = fspecial('gaussian',r,sig);
g1 = imfilter(f, w1, 'replicate');
figure, imshow(g1);
%% Using functions Fspecial and imfilter for image sharpening
w = fspecial('laplacian',0);
f = imread('moon-blurry.tif');
figure, imshow(f);
g1 = imfilter(f ,w, 'replicate');
figure, imshow(g1, []);
f2 =im2double(f);
g2 = imfilter(f2, w, 'replicate');
figure, imshow(g2, []);
g = f2 - g2;
figure, imshow(g);
%% Manually Specifying Kernels and Compare Enhancement Techniques
f = im2double(imread('moon-blurry.tif'));
figure, imshow(f);
w4 = fspecial('laplacian',0);
w8 = [1 1 1; 1 -8 1;1 1 1];
g4 = f - imfilter(f, w4, 'replicate');
g8 = f - imfilter(f, w8, 'replicate');
figure, imshow(g4);
figure, imshow(g8);
%% Highpass filters from lowpass filters.
lp1d = fir1(128,0.1);
figure, plot(lp1d);
w1LP2d = (lp1d')*lp1d;
w2LP2d = ftrans2(lp1d);
figure, mesh(w1LP2d(1:2:end, 1:2:end));
figure, mesh(w2LP2d(1:2:end, 1:2:end));
f = rgb2gray(im2double(imread('zoneplate.jpg')));
figure, imshow(f);
gLP1 = imfilter(f, w1LP2d, 'replicate');
gLP2 = imfilter(f, w2LP2d, 'replicate');
figure, imshow(gLP1);
figure, imshow(gLP2);
%% Unsharp Masking Filters
f = rgb2gray(imread('blurryImage.jpg'));
figure, imshow(f);
g1 = imsharpen(f);
%figure, imshow(g1);
g2 = imsharpen(f, 'Radius', 5);
%figure, imshow(g2);
g3 = imsharpen(f, 'Radius', 5, 'Amount', 2, 'Threshold', 0.05);
figure, imshow(g3);
%% 3.5 Nonlinear Spatial Filtering
%% 3.6 Using Fuzzy Sets for Intensity Transformations and Spatial Filtering

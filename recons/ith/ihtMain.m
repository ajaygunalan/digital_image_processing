%% Assume X is unkown;
clear all;
clc;
temp = [0; 1; 0; 2];
x = [0; 0; 0; 0];
phi =[1 2 3 4; 5 6 7 8;];
y = [10; 22];
% ans = algo_omp(2, phi, y);
% x= CS_IHT(y, phi,2);
x = IHT_Mine(y, phi, 2, 4);
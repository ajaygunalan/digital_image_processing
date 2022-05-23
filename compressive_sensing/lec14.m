clear all, close all, clc;
%% 
a = 0.9;
x = sort(4*(rand(25,1)-0.5));   % Random data from [-2,2]
b = a*x + 0.1*randn(size(x));   % Line Y = 0.9x with noise
atrue = x\b;                    % Least-square slop (no outliers)
b(end) = -5.5;                  % Introduce outlier

%% Plot data
hold on;
set(gca, 'FontSize', 28);
xlabel('x');
ylabel('b');
set(gcf, 'Position', [1500 100 1600 1600]);

scatter(x(1:end-1), b(1:end-1), 100, 'ko', 'MarkerFaceColor', 'r');
scatter(x(end), b(end), 100, 'ko', 'MarkerFaceColor', 'c');
xgrid = -2:0.01:2;
axis([-2 2 -6 2]);
plot(xgrid, xgrid*atrue, 'r--', 'LineWidth', 1.5); %L2 fit (norm)
l1 = legend('Data', 'Outlier', 'True Model');
set(l1, 'Location', 'SouthWest');

%% Plot L2 fit
aL2 = x\b;          % al1 is slope to be optimized
plot(xgrid, xgrid*aL2, 'c--', 'LineWidth', 2); % L2 fit (outlier)
l1 = legend('Data', 'Outlier', 'True Model', 'L2 fit');
set(l1,'Location', 'SouthWest');

%% Solve for L1 mini solution
cvx_begin;
    variable aL1; %aL1 is slope to be optimized
    minimize(norm(aL1*x-b, 1)); %minimize L1 error
cvx_end;
%%

plot(xgrid, xgrid*aL1, 'k', 'LineWidth', 2); % L1 fit
l1 = legend('Data', 'Outlier', 'True Model', 'L2 fit', 'L1 fit')


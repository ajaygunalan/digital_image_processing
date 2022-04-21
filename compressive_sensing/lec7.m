clear all, close all, clc;
%% Generate audio signal of two tones.
n = 4096;
t = linspace(0, 1, n);
x = cos(2*97*pi*t) + cos(2*777*pi*t);
xt = fft(x);
PSD = xt.*conj(xt)/n;

%% Random Sample Signal
p = 128; % num. random samples, p=n/32
perm = round(rand(p, 1)*n);
y = x(perm); % compressed measurment

%% Plot 1
time_window = [1024 1280]/4096;

figure
subplot(2,2,2)
freq = n/(n)*(0:n); %create the x-axis of the frequencies in Hz.
L = 1:floor(n/2); % only plot the first half of freq
plot(freq(L), PSD(L), 'k', 'LineWidth', 2);
xlabel('Frequency, Hz');
set(gca, 'Fontsize', 24)
axis([0 1024 0 1200]);

subplot(2,2,1)
plot(t,x,'k', 'LineWidth', 2);
hold on;
plot(perm/n, y, 'cx', 'LineWidth', 3);
xlabel('Time, s'); set(gca, 'Fontsize', 24)
axis([time_window -2 2]);

set(gcf, 'Position', [1500 100 1800 1200]);

%% Solve Compressed Sensing Problem
Psi = dct(eye(n, n)); %Build PSI
Theta = Psi(perm, :); % Measure rows of Psi

s = simcosamp(Theta, y', 10, 1.e-10, 10); % CS vis matching pursuit
xrecon = idct(s); %reconstruct full signal

%% Plot 2
subplot(2,2,3)
plot(t,xrecon,'c', 'LineWidth', 2);
ylim([-2 2]);
xlabel('Time, s');
set(gca, 'Fontsize', 18)
axis([time_window -2 2]);

subplot(2,2,4)
xtrecon = fft(xrecon , n); %Computes the (fast) discrete fourier
PSDrecon = xtrecon.*conj(xtrecon)/n; %Power spectrum (jow)
plot(freq(L), PSDrecon(L), 'c', 'LineWidth', 2);
xlabel('Frequency, Hz');
set(gca, 'Fontsize', 24 )
axis([0 1024 0 1200]);
%%

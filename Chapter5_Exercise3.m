% Chapter 5
% Exercise 3

clc; close all; clear all;

mu = 130;
sigma = 15;

x = 87:185;
dist = makedist('Normal', mu, sigma);
t = truncate(dist, 96, 160);

pdfnorm = pdf(dist, x);
cdfnorm = cdf(dist, x);
pdftrunc = pdf(t, x);
cdftrunc = cdf(t, x);

p = cdfnorm(find(x == 180))-cdfnorm(find(x == 160));
ptrunc = cdftrunc(find(x == 180))-cdftrunc(find(x == 160));

disp(p);
disp(ptrunc);

subplot(1,2,1);
plot(x, pdfnorm, x, pdftrunc, '--', 'linewidth', 1.5);
grid on; grid minor;

subplot(1,2,2);
plot(x, cdfnorm, x, cdftrunc, '--', 'linewidth', 1.5);
grid on; grid minor;
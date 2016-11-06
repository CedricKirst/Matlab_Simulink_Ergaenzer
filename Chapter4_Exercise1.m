%Chapter 4
%Exercise 1

clc; close all; clear all;
addpath('Data');

fileID = fopen('Exercise1');

CELLS = textscan(fileID, '%*s  %f %s %*s %s %*s %*f %*f %*f %f %*[^\n]', 'Delimiter', ',');

Time = CELLS{1, 1};
sLatitude = CELLS{1, 2};
nLatitude = zeros(length(Time), 1);
sLongitude = CELLS{1, 3};
nLongitude = zeros(length(Time), 1);
Altitude = CELLS{1, 4};
Distance = zeros(length(Time)-1, 1);
Velocity = zeros(length(Time)-1, 1);
r = zeros(length(Time), 1);

clear CELLS;

for i = 1:length(Time)
    r(i) = 6371 + Altitude(i);
    
    longdeg = sLongitude{i}(1:3);
    longmin = sLongitude{i}(4:8);
    
    nLongitude(i) = (str2double(longdeg)+str2double(longmin)/60);
    
    latdeg = sLatitude{i}(1:2);
    latmin = sLatitude{i}(3:7);
    
    nLatitude(i) = (str2double(latdeg)+str2double(latmin)/60);
    if (i<=length(Distance))
        a = sind(nLatitude(i+1)/2-nLatitude(i)/2)^2;
        b = cosd(nLatitude(i)) * cosd(nLatitude(i+1)) * sind(nLatitude(i+1)/2-nLatitude(i)/2)^2;
        
        Distance(i) = 2*r(i) * atan(sqrt((a+b)/(1-a+b)));
        Velocity(i) = Distance(i)/(Time(i+1)-Time(i));
    end
        
end 

[X, Y, Z] = pol2cart(nLatitude, nLongitude, r);
Time = Time(1:length(Time)-1);

figure('Name', 'Ergebnisse');

subplot(2, 2, 1);
plot3(X, Y, Z);
grid on;

subplot(2,2,3:4);
plot(Time, Velocity);
fclose(fileID);
grid on


figure('Name', 'Animation');
axis([20 20.6 105.7 105.85 6400 6700]);
grid on;


%Chapter 4
%Exercise 1

clc; close all; clear all;
addpath('Data');

[Time, sLatitude, sLongitude, Altitude] = textread('Exercise1.txt', '%*s  %f %s %*s %s %*s %*f %*f %*f %f %*[^\n]', 'delimiter', ',');



nLatitude = zeros(length(Time), 1);
nLongitude = zeros(length(Time), 1);
Distance = zeros(length(Time)-1, 1);
Velocity = zeros(length(Time)-1, 1);
r = zeros(length(Time), 1);


for i = 1:length(Time)
    r(i) = 6371000 + Altitude(i);
    
    longdeg = sLongitude{i}(1:3);
    longmin = sLongitude{i}(4:10);
    
    nLongitude(i) =pi/180 * (str2double(longdeg)+str2double(longmin)/60);
    
    latdeg = sLatitude{i}(1:2);
    latmin = sLatitude{i}(3:9);
    
    nLatitude(i) =pi/180 * (str2double(latdeg)+str2double(latmin)/60);
    if (i<=length(Distance))
        a = (sin(nLatitude(i+1)/2-nLatitude(i)/2))^2;
        b = cos(nLatitude(i)) * cos(nLatitude(i+1)) * (sin(nLongitude(i+1)/2-nLongitude(i)/2))^2;
        
        if (i==1)
            Distance(i) = 2*r(i) * atan(sqrt((a+b)/(1-a+b)));
        else
            Distance(i) = Distance(i-1) + 2*r(i) * atan(sqrt((a+b)/(1-a+b)));
        end
        if(i~=length(Time)-1)
            Velocity(i) = (Distance(i+1)-Distance(i))/(Time(i+1)-Time(i));
        end
    end
        
end 

[X, Y, Z] = sph2cart(nLatitude, nLongitude, r);
Time = Time(1:length(Time)-1);

f1 = figure('Name', 'Ergebnisse');
screen_size = get(0, 'ScreenSize');
set(f1, 'Position', [0 0 screen_size(3) screen_size(4) ] );

subplot(2, 2, 1);
plot3(X, Y, Z, '-s', 'LineWidth', 1.5, 'MarkerEdgeColor', 'k');
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Flight Trajectory (cartesic coordinates)');
grid minor;
view([-30, 70]);

subplot(2,2,2);
plot3(nLatitude, nLongitude, r, '-s', 'LineWidth', 1.5, 'MarkerEdgeColor', 'k');
xlabel('Latitude');
ylabel('Longitude');
zlabel('Radius');
title('(Flight Trajectory earth coordinates)');
grid minor;

subplot(2,2,3:4);
plot(Time, Distance, '-rs',  'LineWidth', 1.5, 'MarkerEdgeColor', 'k');
xlabel('Time');
ylabel('Distance');
title('Distance over Time');
grid minor;


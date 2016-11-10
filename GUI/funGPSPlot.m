function [ X, Y, Z, Time, Distance ] = funGPSPlot( GPSfile )
%Plots GPS-data out of textfile
addpath('Data');

[Time, sLatitude, sLongitude, Altitude] = textread(GPSfile, '%*s  %f %s %*s %s %*s %*f %*f %*f %f %*[^\n]', 'delimiter', ',');

nLatitude = zeros(length(Time), 1);
nLongitude = zeros(length(Time), 1);
Distance = zeros(length(Time)-1, 1);
Velocity = zeros(length(Time)-1, 1);
r = zeros(length(Time), 1);


for i = 1:length(Time)
    r(i) = 6371 + Altitude(i);
    
    longdeg = sLongitude{i}(1:3);
    longmin = sLongitude{i}(4:8);
    
    nLongitude(i) = pi/180 * (str2double(longdeg)+str2double(longmin)/60);
    
    latdeg = sLatitude{i}(1:2);
    latmin = sLatitude{i}(3:7);
    
    nLatitude(i) =pi/180 * (str2double(latdeg)+str2double(latmin)/60);
    if (i<=length(Distance))
        a = sin(nLatitude(i+1)/2-nLatitude(i)/2)^2;
        b = cos(nLatitude(i)) * cos(nLatitude(i+1)) * sin(nLatitude(i+1)/2-nLatitude(i)/2)^2;
        
        if (i==1)
            Distance(i) = 2*r(i) * atan(sqrt((a+b)/(1-a+b)));
        else
            Distance(i) = Distance(i-1) + 2*r(i) * atan(sqrt((a+b)/(1-a+b)));
        end
        
        Velocity(i) = Distance(i)/(Time(i+1)-Time(i));
    end
        
end 

[X, Y, Z] = pol2cart(nLatitude, nLongitude, r);
Time = Time(1:length(Time)-1);

end


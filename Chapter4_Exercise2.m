%Chapter 4
%Exercise 2

clc; clear all; close all;

addpath('TXTData');
addpath('Methods');
addpath('Methods/Archive');

cd 'TXTData';
files = dir('*.txt');

for i = 1:length(files)
    data{1, i} = files(i).name;
    
    fileID = fopen(files(1).name);
    tempdata = textscan(fileID, '%f');
    fclose(fileID);
    
    for k = 1:length(tempdata{1,1})
        data{k+1, i} = tempdata{1,1}(k);
    end
end

cd('/home/cedric/Uni/Matlab_Simulink_Ergänzer');

javaaddpath('/home/cedric/Uni/Matlab_Simulink_Ergänzer/Methods/Archive/MXL.jar');
javaaddpath('/home/cedric/Uni/Matlab_Simulink_Ergänzer/Methods/Archive/jxl.jar');
xlwrite('Data.xls', data);

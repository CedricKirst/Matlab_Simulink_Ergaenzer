%calculate prime numbers using for loop

clc; clear all; close all;

count = 0;
lower = 0;
upper = 100;

tic;
if(lower <= 3)
    count =3;
    lower = 4;
end

for i =  lower:upper
    
    prime = true;
    
    for j = 2 : round(sqrt(i))
        if(~mod(i, j))
            prime = false;
        end
    end
    
    if(prime)
        count = count + 1;
    end
    
end
toc;

fprintf('Anzahl der Primzahlen im angegebenen Bereich:\t%i\n', count);
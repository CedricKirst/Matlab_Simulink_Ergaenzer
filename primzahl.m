%calculate prime numbers using for loop

clc; clear all; close all;

count = 1;
lower = 0;
upper = 999999;
primes = -2*ones(upper,1);
primes(1) = 2;
primiter = 1;

tic;
for i =  2:upper
    
    prime = true;
    
    for j = 1 : length(primes)
        if(primes(j) == -2)
            break;
        elseif(~mod(i, primes(j)))
            prime = false;
            break;
        end
    end
    
    if(prime)
        count = count + 1;
        primes(j) = i;
    end
    
end
toc;

fprintf('Anzahl der Primzahlen im angegebenen Bereich:\t%i\n', count);
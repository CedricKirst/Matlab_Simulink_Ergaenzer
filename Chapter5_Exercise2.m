%Chapter 5
%Exercise 2

A = [1 3;-2 7;1 2];
b = [5;9;4];
lb = [0;0];
H = [1 -2;-2 2];
f = [-3;-5];

options = optimoptions('quadprog','Algorithm','interior-point-convex');
[x,fval,exitflag,output,lambda] = quadprog(H,f,A,b,[],[],lb,[],[],options);

%Chapter 5
%Exercise 1 - Control Design

clc;close all; clear all;format long;

A = [0 1;2 3];
B = [0;1];
C = [1 0;0 1];
D = [0;0];
Ps = [-3;-5];

Ks = place(A,B,Ps);
sys = ss((A-B*Ks), B,C,D);


Delta_t = 0.001;
t_final = 2;
N_iter = floor(t_final/Delta_t);
x = zeros(2,N_iter+1);
t = zeros(1,N_iter);
u = zeros(1,N_iter);

x(:,1) = [1;-3];

for k = 1:N_iter
    u(k) = -Ks*x(:,k);
    x(:,k+1) = x(:,k) + (A*x(:,k) + B*u(k))*Delta_t;
    t(k+1) = t(k) + Delta_t;    
end

figure('Name', 'Control responce and States');
subplot(2,2,1);
plot(t(1:k), x(1,1:k),'r', t(1:k), x(2,1:k), 'b', 'LineWidth', 1.5);
grid minor;
title('States over Time');

subplot(2,2,2);
plot(t(1:k),u(1:k),'k', 'LineWidth', 1.5);
grid minor;
title('Control Responces over Time');

subplot(2,2,3:4);
pzmap(sys);
grid on;

%Chapter 3
%Exercise 2
%Euler's approximation for a differential equation



%(i)

h = 0.01;
t = 0 : 0.01 : 2;
y = zeros(length(t), 1);

y(1) = 1;

for i = 2 : length(t)
    y(i) = y(i-1) + h*(t(i-1)^2-y(i-1)^2);
end

subplot(2,1,1);
hold on;
title('dy/dt = t² - y²');
xlabel('t');
ylabel('y');
plot(t, y);
grid on;
hold off;

%(ii)
i = 2;
while(i <= length(t))
    y(i) = y(i-1) + h*(t(i-1) - norm(y(i-1)));
    
    i = i+1;
end

subplot(2,1,2);
hold on;
title('dy/dt = t - |y|');
xlabel('t');
ylabel('y');
plot(t, y);
grid on;
hold off;

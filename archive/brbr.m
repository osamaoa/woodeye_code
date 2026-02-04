clc
clear

t = 1;
d = 25;
v = 0.3;
E = 200e3;
L = 1000;

G = E/2/(1+v);

I = 1/12*t^3*d;
Kv = 1/3*d*t^3;

3.53/L^2*sqrt(E*I*G*Kv)
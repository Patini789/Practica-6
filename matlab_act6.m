L = 2e-3;%(2 mH)
R = 10;%(10 Ohms)
C = 10e-6;%(10 uF)
Uin = 32;%(32 V)

% Parámetros del PWM
f = 100e3;
T = 1/f;
D = 0.4;

A = [0, -1/L; 
     1/C, -1/(R*C)];
B = [Uin/L; 
     0];

d = @(t) double(mod(t, T) < (D * T));
sistema = @(t, x) A*x + B*d(t);


x0 = [0; 0];
tspan = [0 0.005];     

opciones = odeset('MaxStep', T/10); 

[t, x] = ode45(sistema, tspan, x0, opciones);

figure('Name', 'Respuesta del Convertidor CD-CD');

subplot(2,1,1);
plot(t, x(:,1), 'b', 'LineWidth', 1.2);
title('Corriente');
xlabel('(s)');
ylabel('(A)');
grid on;

subplot(2,1,2);
plot(t, x(:,2), 'r', 'LineWidth', 1.2);
title('Voltaje');
xlabel('(s)');
ylabel('(V)');
grid on;
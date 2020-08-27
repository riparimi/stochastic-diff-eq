function SIR_determ
% Simulation of a deterministic SIR model using a differential
% equation solver.

params.m = 1e-4; % host death rate
params.b = 0.02; % infection rate
params.v = 0.1;  % pathogen-induced mortality rate
params.r = 0.3;  % rate of recovery

initial.S = 50;  % number of susceptible individuals
initial.I = 1;   % number of infected individuals
initial.R = 0;   % number of recovered individuals

end_time = 100;  % end of simulation time span starting a 0

[t, y] = ode45(@(t, x) derivative(t, x, params), ...
               [0 end_time], ...
               [initial.S; initial.I; initial.R], ...
               []);
           
% extract result vectors
outS = y(:,1);
outI = y(:,2);
outR = y(:,3);

% plot the results
subplot(3, 1, 1);
plot(t, outS);
xlabel('t');
ylabel('S(t)');

subplot(3, 1, 2);
plot(t, outI);
xlabel('t');
ylabel('I(t)');

subplot(3, 1, 3);
plot(t, outR);
xlabel('t');
ylabel('R(t)');


function f = derivative (t, x, params)
% Calculates the derivatives of the SIR model. The output is a list with
% the derivatives dS/dt, dI/dt and dR/dt at time t.

S = x(1);
I = x(2);
R = x(3);
ds = params.m * (S+I+R) - params.m * S - params.b * I * S;
di = params.b * I * S - (params.m + params.v + params.r) * I;
dr = params.r * I - params.m * R;
f = [ds; di; dr];

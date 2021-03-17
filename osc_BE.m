% BK70A0600 Computational Methods in Mechanics
% Excercise 4.14
% Jesse Myller 0503199

clear all; close all

% Preparing symbolic solving of the equations
syms un vn un1 vn1 omega dt     % Solving the equations symbolically
eq1 = (un == un1-dt*vn1);           % Initializing equations
eq2 = (vn == vn1+dt*omega^2*un1);

syms fu(dt, un, vn, omega) fv(dt, un, vn, omega)
[fu(dt, un, vn, omega), fv(dt, un, vn, omega)] = solve([eq1, eq2], [un1, vn1]);   % Equation to calculate un+1 is found in fu and the equation to calculate vn+1 is found in fv

% Initializing known values (values taken from a simple example in course
omega = 2;
P = 2*pi/omega;
dt = P/20;      % Change 20 to 2000 for second test
T = 3*P;        % Increase this value to 300 to see the effect of increasing the amount of timesteps
N_t = floor(T/dt);
t = linspace(0, N_t*dt, N_t+1);

% Initial conditions
X_0 = 2;
u = X_0;
v = 0;

% Initializing variables for calculations
energy = [];
a = 1;          % Helper variable to add the energies in correct positions withing the matrices

% Calculating energies in a loop
for i = 0:dt:N_t*dt
    [P, K] = osc_energy(u, v, omega);   % Energy values calculated using the earlier made function
    energy(a) = P+K;    % Total energy is the sum of potential and kinetic energy
    
    a = a+1;
    un = (u + dt*v)/(dt^2*omega^2 + 1);             % I was unable to make use of the symbolic solutions straight, so I had to copy and paste the results here for the plots
    vn = (- dt*u*omega^2 + v)/(dt^2*omega^2 + 1);
    u = un;         % Use of helper variables is needed when both functions might use the value calculated from the other function in accident
    v = vn;
end

plot(t,energy)  % Plotting the results
xlabel('t');
ylabel('Total energy');
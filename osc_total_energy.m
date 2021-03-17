% BK70A0600 Computational Methods in Mechanics
% Excercise 4.10
% Jesse Myller 0503199

clear all; close all

% Initializing known values (values taken from a simple example in course
% book)
omega = 2;
P = 2*pi/omega;
dt = P/20;
T = 3*P;
N_t = floor(T/dt);
t = linspace(0, N_t*dt, N_t+1);

% Initial conditions
X0 = 2;
uFE = X0;
vFE = 0;
uEC = X0;
vEC = 0;

% Initializing variables for calculations
energyFE = [];
energyEC = [];
a = 1;          % Helper variable to add the energies in correct positions withing the matrices

% Calculating energies in a loop
for i = 0:dt:N_t*dt
    [PFE, KFE] = osc_energy(uFE, vFE, omega);   % Forward Euler method values
    energyFE(a) = PFE+KFE;
    
    [PEC, KEC] = osc_energy(uEC, vEC, omega);   % Euler-Cromer method values
    energyEC(a) = PEC+KEC;
    
    a = a+1;
    % Calculating the next values for u and v
    uFE2 = uFE+dt*vFE;          % Forward Euler method needs extra helper variables as both n+1 values use the previous values of themselves
    vFE2 = vFE-dt*omega^2*uFE;
    uFE = uFE2;                 % Placing the value from helper variables into the actual variables used in calculations
    vFE = vFE2;

    vEC = vEC-dt*omega^2*uEC;   % Euler-Cromer method is more simple to program as u uses the v(n+1) value in its calculation
    uEC = uEC+dt*vEC;
end

% Plotting the energies in subplots to better see the differences between
% methods
plot(subplot(2,1,1), t, energyFE)   % Plotting the results of Forward Euler method
xlabel('t');
ylabel('Total energy');
title('Forward Euler');

plot(subplot(2,1,2), t, energyEC)   % Plotting the results of the Euler-Cromer method
xlabel('t');
ylabel('Total energy');
title('Euler-Cromer');
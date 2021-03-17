% BK70A0600 Computational Methods in Mechanics
% Excercise 4.4
% Jesse Myller 0503199

clear all; close all

% Initializing known values
N0 = 100;   % Population size at the beginning
dt = 10;    % Timestep [months], needs to be large so the first few graphs are not already close enough to wanted
T = 60;     % Length of explored phenomenon [months]
r = 0.1;    % Growth
M = 500;    % Population maximum

% Test run to see if everything works as in the example
% f = @(u, t) 0.1*(1 - u/500)*u;
% [u, t] = ode_FE(f, N0, dt, T);
% 
% plot(t,u)

loopcond = 1;   % Initializing variable to control loop
k = 1;
f = @(u, t) 0.1*(1 - u/500)*u;

while 1
    dtk = 2^-k*dt;      % Current time step
    dtkb = 2^-(k-1)*dt; % Previous time step
    [tk, uk] = ode_FE(f, N0, dtk, T);       % Calculating values for current time step
    [tkb, ukb] = ode_FE(f, N0, dtkb, T);    % Calculating values for previous time step
    
    % Plotting both graphs on same figure
    plot(uk, tk, 'b')   % Plotting current time step
    
    hold on; grid on;   % Ensuring both graphs are drawn on same figure
    xlabel('t');        % Labels help understand the graph better
    ylabel('N(t)');
    
    plot(ukb, tkb, 'r') % Plotting previous time step
    hold off;           % Taking hold off makes sure previous graphs won't stay in the graph during the loop
    
    fprintf('Current time step dtk = %4.4f\n', dtk)
    loopcond = input('To end loop, enter (0): ');   % User may end loop when results are within desired range
    if isempty(loopcond)    % If nothing is given before enter is pressed, this if statement ensures the loop continues
        loopcond = 1;
    end
    if loopcond == 0    % When 0 is given, loop ends
        break
    end
    k = k+1;            % Increasing k incrementally to reduce step size when needed
    close all;
end
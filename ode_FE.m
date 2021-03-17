function [u, t] = ode_FE(f, U_0, dt, T)
% This function is found in the course book
N_t = floor(T/dt);
u = zeros(N_t+1, length(U_0));
t = linspace(0, N_t*dt, length(u));
u(1,:) = U_0;   % Initial values
t(1) = 0;
for n = 1:N_t
    u(n+1,:) = u(n,:) + dt*f(u(n,:), t(n));
end
end
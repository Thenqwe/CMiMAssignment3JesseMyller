function [P, K] = osc_energy(u, v, omega)
% This function takes u, v and omega as inputs and outputs the calculated
% values for Potential energy (P) and Kinetic energy (K)
P = 1/2*omega^2*u^2;
K = 1/2*v^2;
end
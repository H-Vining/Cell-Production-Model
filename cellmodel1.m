function dx = cellmodel1(t,x,N,xmax,f,mumax,kd)
%Used to set up the equations and run through them
% t = time vector, x = vector of cell density, N = number of stages,
%xmax = maximum cell density, f = self renewal probability,
%mumax = maximal growth rate, kd = death rate
sumx = sum(x);
dx = zeros(N,1);
dx(1) = (2*f-1)*mumax*(1-sumx/xmax)*x(1);
dx(2) = 2*(1-f)*mumax*(1-sumx/xmax)*x(1)-mumax*(1-sumx/xmax)*x(2);
for k = 3:(N-1)
    dx(k) = 2*mumax*(1-sumx/xmax)*x(k-1)-mumax*(1-sumx/xmax)*x(k);
end
dx(N) = 2*mumax*(1-sumx/xmax)*x(N-1)-kd*x(N);
end


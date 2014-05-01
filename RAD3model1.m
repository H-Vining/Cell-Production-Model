function dx = RAD3model1(t,x,xmax,f,mumax,kd, RA, D3, RAmin, D3min,td)
%Used to set up the equations and run through them
% t = time vector, x = vector of cell density, N = number of stages,
%xmax = maximum cell density, f = self renewal probability,
%mumax = maximal growth rate, kd = death rate, RA = RA amount
%D3 = D3 amount, steplimit1 = amount of RA or D3 needed to start dividing,
%amount of 
sumx = sum(x);
dx = zeros(4,1);
%add constant instead for 2 divisions?
if RA>0 || D3>0
    if RA>RAmin || D3>D3min
        dx(1) = (2*f-1)*mumax*(1-sumx/xmax)*x(1) - kd*x(1);
        dx(2) = 2*(1-f)*mumax*(1-sumx/xmax)*x(1)+(2^((1/td))-2^(t/td))*mumax*(1-sumx/xmax)*x(2)-kd*x(2);
    else
        dx(1) = (2*f-1)*mumax*(1-sumx/xmax)*x(1) - kd*x(1)+2*mumax*(1-sumx/xmax)*x(2);
        dx(2) = 2*(1-f)*mumax*(1-sumx/xmax)*x(1)+(2^((1/td))-2^(t/td))*mumax*(1-sumx/xmax)*x(2)-kd*x(2);
    end
else
    dx(1) = (2*f)*mumax*(1-sumx/xmax)*x(1) - kd*x(1);
end
if RA>RAmin && D3 > D3min
    RAval = RA/(RA + D3);
    D3val = D3/(RA+D3);
    dx(3) = 2*mumax*(1-sumx/xmax)*x(2)*RAval-kd*x(3);
    dx(4) = 2*mumax*(1-sumx/xmax)*x(2)*D3val-kd*x(4);
elseif D3>D3min
    dx(4) = 2*mumax*(1-sumx/xmax)*x(2)-kd*x(4);
elseif RA>RAmin
    dx(3) = 2*mumax*(1-sumx/xmax)*x(2)-kd*x(3);
end
end


function dx = RAD3model1(t,x,xmax,f,mumax,kd, RA, D3, RAmin, D3min)
%Used to set up the equations and run through them
% t = time vector, x = vector of cell density, N = number of stages,
%xmax = maximum cell density, f = self renewal probability,
%mumax = maximal growth rate, kd = death rate, RA = RA amount
%D3 = D3 amount, steplimit1 = amount of RA or D3 needed to start dividing,
%amount of 
sumx = sum(x(1:4));
dx = zeros(5,1);
x(5)=x(5)-mumax*sumx/xmax;
if RA>0 || D3>0
    dx(1) = (2*f-1)*x(5)*x(1) - kd*x(1);
    dx(2) = 2*(1-f)*x(5)*x(1)+x(5)*x(2)-kd*x(2);
    if RA>0&&RA<RAmin&&D3<D3min
        dx(5) = -(abs((RA-RAmin)/RAmin))*x(5);
    end
    if D3>0&& D3<D3min&&RA<RAmin
        dx(5) = -(abs((D3-D3min)/D3min))*x(5);
    end
else
    dx(1) = (2*f)*x(5)*x(1) - kd*x(1);
    dx(5) = 0;
end
if RA>RAmin && D3 > D3min
    RAval = RA/(RA + D3);
    D3val = D3/(RA+D3);
    dx(3) = 2*x(5)*x(2)*RAval-kd*x(3);
    dx(4) = 2*x(5)*x(2)*D3val-kd*x(4);
elseif D3>D3min
    dx(4) = 2*x(5)*x(2)-kd*x(4);
elseif RA>RAmin
    dx(3) = 2*x(5)*x(2)-kd*x(3);
end
end


function dx = RAD3model1(t,x,HL60Cell,RA,D3)
%Used to set up the equations and run through them
% t = time vector, x = vector of cell density, N = number of stages,
%xmax = maximum cell density, f = self renewal probability,
%mumax = maximal growth rate, kd = death rate, RA = RA amount
%D3 = D3 amount, RAmin = minimum amount of RA needed to get to final 
%differentiation stage, D3min = minimum amount of D3 needed to get to final
%differentiation stage
xmax=HL60Cell.xmax;
f=HL60Cell.f;
mumax=HL60Cell.mumax;
kd=HL60Cell.kd;
RAmin=HL60Cell.RAmin;
D3min=HL60Cell.D3min;
sumx = sum(abs(x(1:5)));
dx = zeros(6,1);
if (RA>0 || D3>0)&& RA<RAmin && D3<D3min
    if RA>0
        RAchange = ((RA-RAmin)/RAmin);
        dx(6) = RAchange*((1-x(6)/mumax))*x(6);
    end
    if D3>0
        D3change = ((D3-D3min)/D3min);
        dx(6) = D3change*((1-x(6)/mumax))*x(6);
    end
    dx(1) = (2*f)*mumax*(1-sumx/xmax)*x(1)-x(6)*(1-sumx/xmax)*x(1) +...
        2*(1)*(1-sumx/xmax)*mumax*x(2)- kd*x(1);
    dx(2) = 2*(1-f)*x(6)*(1-sumx/xmax)*x(1)+...
        (2*f-1)*(1-sumx/xmax)*x(6)*x(2)-kd*x(2);
elseif (RA>0 || D3>0)&& (RA>=RAmin || D3>=D3min)
    if RA>RAmin
        dx(6) = ((RA-RAmin)/RAmin)*((1-x(6)/mumax))*x(6);
    end
    if D3>D3min
        dx(6) = ((D3-D3min)/D3min)*((1-x(6)/mumax))*x(6);
    end
    dx(1) = 2*f*mumax*(1-sumx/xmax)*x(1)-x(6)*(1-sumx/xmax)*x(1) - kd*x(1);
    dx(2) = 2*(1-f)*(1-sumx/xmax)*x(6)*x(1)-(1-sumx/xmax)*x(6)*x(2)-kd*x(2);
else
    dx(6) = 0;
    dx(1) = (2*f)*x(6)*x(1)*(1-sumx/xmax) - kd*x(1);
end
if RA>RAmin && D3>D3min
    dx(5) = 2*mumax*x(2)*(1-sumx/xmax)-kd*x(5);
elseif D3>D3min
    dx(4) = 2*mumax*x(2)*(1-sumx/xmax)-kd*x(4);
elseif RA>RAmin
    dx(3) = 2*mumax*x(2)*(1-sumx/xmax)-kd*x(3);
end
end


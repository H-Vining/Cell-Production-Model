function RAD3input(xmax,f,mumax,kd,xfirststage, RA, D3, RAmin, D3min)
%Shows the cell density versus time for a given cell with these parameters
% xmax = maximum cell density, f = self renewal probability, mumax =
% maximal growth rate, kd = death rate, xfirststage = initial cell 
%density in first stage, RA = amount of RA, D3 = amount of D3, RAmin =
%amount of RA needed to reach final stage, D3min = amount of D3 needed to
%reach final stage
initcon = [];
initval = [];
for i = 1:5
    initcon = [initcon, 1e-4];
    if i == 1
        initval = [initval,xfirststage];
    elseif i~= 1 && i<3
        initval = [initval,0];
    elseif i <5
        initval = [initval,0];
    else
        initval = [initval,mumax*(1-sum(initval(1:4))/xmax)];
    end
end
options = odeset('RelTol',1e-4, 'AbsTol',initcon);
[T, X] = ode45(@(t,x) RAD3model1(t,x,xmax,f,mumax,kd,RA,D3,RAmin,D3min), [0,145], initval,options);
hold on
XR = X(:,1);
X2 = X(:, 2);
X3 = X(:, 3);
X4 = X(:, 4);
plot(T*mumax, XR(:,1)/xmax, 'b');
plot(T*mumax, X3(:,1)/xmax, 'r');
plot(T*mumax, X2(:,1)/xmax, 'g');
plot(T*mumax, X4(:,1)/xmax, 'm');
xlabel('Tau, dimensionless time')
ylabel('xsum*, dimensionless cell density of stages')
title(['Time versus Cell Density for Self-Renewal Rate of', num2str(f)])
hold off
end
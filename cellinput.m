function cellinput(N,xmax,f,mumax,kd,xfirststage,xmidstage,xlaststage)
%Shows the cell density versus time for a given cell with these parameters
% N = number of stages, xmax = maximum cell density, f = self renewal
% probability,mumax = maximal growth rate, kd = death rate, xfirststage = 
%initial cell density in first stage, xmidstage = initial cell density 
%in stages 2 to N, xlaststage = initial cell density in last stage
initcon = [];
initval = [];
for i = 1:N
    initcon = [initcon, 1e-4];
    if i == 1
        initval = [initval,xfirststage];
    elseif i~= 1 && i~= N
        initval = [initval,xmidstage];
    else
        initval = [initval,xlaststage];
    end
end
options = odeset('RelTol',1e-4, 'AbsTol',initcon);
[T, X] = ode45(@(t,x) cellmodel1(t,x,N,xmax,f,mumax,kd), [0,145], initval,options);
hold on
XR = X(:,1);
for j = 2:(N)
    XR(:,1) = XR(:,1)+X(:,j);
end
plot(T*mumax, XR(:,1)/xmax);
xlabel('Tau, dimensionless time')
ylabel('xsum*, dimensionless cell density of stages')
title(['Time versus Cell Density for Self-Renewal Rate of', num2str(f)])
hold off
end
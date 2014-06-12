function [xfin, tfin] = RAD3input(HL60Cell,graph)
%Shows the cell density versus time for a given cell
% HL60Cell = struct for an HL60 cell with various relevant paramaters
% graph is a boolean that gives whether or not the user wants a graph
initcon = [];
initval = [];
for i = 1:6
    initcon = [initcon, 1e-4];
    if i <6
        initval = [initval,HL60Cell.x(i)];
    else
        initval = [initval,HL60Cell.mumax*(1-sum(initval(1:5))/HL60Cell.xmax)];
    end
end
options = odeset('RelTol',1e-4, 'AbsTol',initcon);
t1 = linspace(0, HL60Cell.start,HL60Cell.start+1);
[T0, X0] = ode45(@(t,x) RAD3model1(t,x,HL60Cell,0,0), t1,...
    initval,options);
endof = length(X0);
xend = X0(endof,:);
initcon = [];
initval = [];
for i = 1:6
    initcon = [initcon, 1e-4];
    if i <6
        initval = [initval,xend(i)];
    else
        initval = [initval,HL60Cell.mumax*(1-sum(initval(1:5))/HL60Cell.xmax)];
    end
end
options = odeset('RelTol',1e-4, 'AbsTol',initcon);
t2 = linspace(HL60Cell.start,HL60Cell.end,(HL60Cell.end-HL60Cell.start)+1);
[T1, X1] = ode45(@(t,x) RAD3model1(t,x,HL60Cell,HL60Cell.RA,HL60Cell.D3),...
    t2, initval,options);
xfin = [X0(:,1:5);X1(:,1:5)];
tfin = [T0;T1];
if graph
    hold on
    XR = xfin(:, 1);
    X2 = xfin(:, 2);
    X3 = xfin(:, 3);
    X4 = xfin(:, 4);
    X5 = xfin(:, 5);
    plot(tfin*HL60Cell.mumax, XR(:,1)/HL60Cell.xmax, 'b');
    plot(tfin*HL60Cell.mumax, X3(:,1)/HL60Cell.xmax, 'r');
    plot(tfin*HL60Cell.mumax, X2(:,1)/HL60Cell.xmax, 'g');
    plot(tfin*HL60Cell.mumax, X4(:,1)/HL60Cell.xmax, 'm');
    plot(tfin*HL60Cell.mumax, X5(:,1)/HL60Cell.xmax, 'c');
    xlabel('Tau, dimensionless time')
    ylabel('xsum*, dimensionless cell density of stages')
    title(['Time versus Cell Density for Self-Renewal Rate of',...
        num2str(HL60Cell.f)])
    hold off
end
end
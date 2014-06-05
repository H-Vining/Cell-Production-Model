function xfin = RAD3input(HL60Cell,graph)
%Shows the cell density versus time for a given cell
% HL60Cell = struct for an HL60 cell with various relevant paramaters
% graph is a boolean that gives whether or not the user wants a graph
initcon = [];
initval = [];
for i = 1:5
    initcon = [initcon, 1e-4];
    if i <5
        initval = [initval,HL60Cell.x(i)];
    else
        initval = [initval,HL60Cell.mumax*(1-sum(initval(1:4))/HL60Cell.xmax)];
    end
end
options = odeset('RelTol',1e-4, 'AbsTol',initcon);
[T1, X1] = ode45(@(t,x) RAD3model1(t,x,HL60Cell,0,0), [0,HL60Cell.start],...
    initval,options);
endof = length(X1);
xend = X1(endof,:);
initcon = [];
initval = [];
for i = 1:5
    initcon = [initcon, 1e-4];
    if i <5
        initval = [initval,xend(i)];
    else
        initval = [initval,HL60Cell.mumax*(1-sum(initval(1:4))/HL60Cell.xmax)];
    end
end
options = odeset('RelTol',1e-4, 'AbsTol',initcon);
[T2, X2] = ode45(@(t,x) RAD3model1(t,x,HL60Cell,HL60Cell.RA,HL60Cell.D3),...
    [HL60Cell.start,HL60Cell.end], initval,options);
xfin = [X1(:,1:4);X2(:,1:4)];
tfin = [T1;T2];
if graph
    hold on
    XR = xfin(:,1);
    X2 = xfin(:, 2);
    X3 = xfin(:, 3);
    X4 = xfin(:, 4);
    plot(tfin*HL60Cell.mumax, XR(:,1)/HL60Cell.xmax, 'b');
    plot(tfin*HL60Cell.mumax, X3(:,1)/HL60Cell.xmax, 'r');
    plot(tfin*HL60Cell.mumax, X2(:,1)/HL60Cell.xmax, 'g');
    plot(tfin*HL60Cell.mumax, X4(:,1)/HL60Cell.xmax, 'm');
    xlabel('Tau, dimensionless time')
    ylabel('xsum*, dimensionless cell density of stages')
    title(['Time versus Cell Density for Self-Renewal Rate of',...
        num2str(HL60Cell.f)])
    hold off
end
end
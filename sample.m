%Runs the cell program for several variants of the input parameters and
%compares results at the same values of time, as well as saves the data
%at the end of the program.
xmax = input('Enter the maximum cell density:');
f = input('Enter the self renewal probability:');
mumax = input('Enter the maximum growth rate:');
kd = input('Enter the cell death rate:');
xinit=input('Enter as a vector the initial cell density of each stage:\n');
RA = input('Enter the amount of RA added:');
D3 = input('Enter the amount of D3 added:');
RAmin = input('Enter the minimum amount of RA to reach the final stage:');
D3min = input('Enter the minimum amount of D3 to reach the final stage:');
ts = input('Enter the time when RA and/or D3 is added:');
te = input('Enter the time the simulations stop:');
HL = HL60struct(xmax,f,mumax,kd,xinit,RA,D3,RAmin,D3min,ts,te);
running = 1;
while running
    HL60save = {};
    timesave = {};
    vnew = [];
    disp('Choose one of the following to perturb:')
    disp('1: maximum growth rate');
    disp('2: death rate');
    disp('3: initial cell density');
    disp('4: RA amount');
    disp('5: D3 amount');
    disp('6: maximum cell density');
    disp('7: self renewal probability');
    disp('8: time RA and/or D3 is added');
    disp('9: minimum RA amount needed to reach final stage');
    disp('10: minimum D3 amount needed to reach final stage');
    choice = input('Enter number of choice to perturb:');
    while (choice>10||choice<1)||choice~=floor(choice)
        choice = input('Invalid input: Please enter a valid input:');
    end
    perturb = input('Enter as number >0 and <1 amount to perturb:');
    while perturb<=0 && perturb>=1
        perturb = input('Invalid input - enter again:');
    end
    repeat = input('Enter how many iterations are wanted:');
    while repeat <=0
        repeat = input('Invalid input: Enter again:');
    end
    if choice == 1
        name = 'growth rate';
        for j = 1:repeat;
            [x,t] = RAD3input(HL,0);
            HL60save = [HL60save, x];
            timesave = [timesave, t];
            vnew = [vnew, HL.mumax];
            HL.mumax = mumax+(mumax*perturb-2*mumax*rand*perturb);
        end
        HL.mumax = mumax;
    elseif choice ==2
        name = 'death rate';
        for j = 1:repeat;
            [x,t] = RAD3input(HL,0);
            HL60save = [HL60save, x];
            timesave = [timesave, t];
            vnew = [vnew, HL.kd];
            HL.kd = kd+(kd*perturb-2*kd*rand*perturb);
        end
        HL.kd = kd;
    elseif choice ==3
        name = 'initial cell density';
        for j = 1:repeat;
            [x,t] = RAD3input(HL,0);
            HL60save = [HL60save, x];
            timesave = [timesave, t];
            vnew = [vnew, HL.x];
            HL.x = xinit+(xinit*perturb-2*xinit*rand*perturb);
        end
        HL.x = xinit;
    elseif choice ==4
        name = 'RA amount';
        for j = 1:repeat;
            [x,t] = RAD3input(HL,0);
            HL60save = [HL60save, x];
            timesave = [timesave, t];
            vnew = [vnew, HL.RA];
            HL.RA = RA+(RA*perturb-2*RA*rand*perturb);
        end
        HL.RA = RA;
    elseif choice == 5
        name = 'D3 amount';
        for j = 1:repeat;
            [x,t] = RAD3input(HL,0);
            HL60save = [HL60save, x];
            timesave = [timesave, t];
            vnew = [vnew, HL.D3];
            HL.D3 = D3+(D3*perturb-2*D3*rand*perturb);
        end
        HL.D3 = D3;
    elseif choice ==6
        name = 'maximum cell density';
        for j = 1:repeat;
            [x,t] = RAD3input(HL,0);
            HL60save = [HL60save, x];
            timesave = [timesave, t];
            vnew = [vnew, HL.xmax];
            HL.xmax = xmax+(xmax*perturb-2*xmax*rand*perturb);
        end
        HL.xmax = xmax;
    elseif choice ==7
        name = 'self renewal probability';
        for j = 1:repeat;
            [x,t] = RAD3input(HL,0);
            HL60save = [HL60save, x];
            timesave = [timesave, t];
            vnew = [vnew, HL.f];
            HL.f = f+(f*perturb-2*f*rand*perturb);
            while HL.f>=1
                HL.f = f+(f*perturb-2*f*rand*perturb);
            end
        end
        HL.f = f;
    elseif choice ==8
        name = 'time RA and/or D3 is added';
        for j = 1:repeat;
            [x,t] = RAD3input(HL,0);
            HL60save = [HL60save, x];
            timesave = [timesave, t];
            vnew = [vnew, HL.start];
            HL.start = ts+(ts*perturb-2*ts*rand*perturb);
        end
        HL.start = ts;
    elseif choice ==9
        name = 'minimum RA amount needed to reach the final stage';
        for j = 1:repeat;
            [x,t] = RAD3input(HL,0);
            HL60save = [HL60save, x];
            timesave = [timesave, t];
            vnew = [vnew, HL.RAmin];
            HL.RAmin = RAmin+(RAmin*perturb-2*RAmin*rand*perturb);
        end
        HL.RAmin = RAmin;
    else
        name = 'minimum D3 amount needed to reach the final stage';
        for j = 1:repeat;
            [x,t] = RAD3input(HL,0);
            HL60save = [HL60save, x];
            timesave = [timesave, t];
            vnew = [vnew, HL.D3min];
            HL.D3min = D3min+(D3min*perturb-2*D3min*rand*perturb);
        end
        HL.D3min = D3min;
    end
    filename = input('Please enter name of file:','s');
    fid = fopen(filename,'at');
    fprintf(fid,'Data for a perturbation of %d%% in %s\n',perturb*100,...
        name);
    for a = 1:length(HL60save)
        fprintf(fid,'Data for run %d where the %s is a value of %.3d\n',...
            a, name, vnew(a));
        fprintf(fid,'%-10s %-10s %-10s %-10s %-10s\n', 'Time', ...
            'Stage 1','Stage 2','RA Final','D3 Final');
        for b = 1:length(HL60save{a})
            fprintf(fid,'%-10.3d %-10.3d %-10.3d %-10.3d %-10.3d\n',...
                timesave{a}(b),HL60save{a}(b,:));
        end
    end
    fclose(fid);
    graph = input('Do you want a plot? yes=1,no=0:');
    while graph~=0&&graph~=1
        graph = input('Enter a valid input:');
    end
    if graph
        f = figure;
        hold on
        for a = 1:length(HL60save)
            XR = HL60save{a}(:,1);
            X2 = HL60save{a}(:, 2);
            X3 = HL60save{a}(:, 3);
            X4 = HL60save{a}(:, 4);
            if choice == 6
                plot(timesave{a}, XR(:,1)/vnew(a), 'b');
                plot(timesave{a}, X3(:,1)/vnew(a), 'r');
                plot(timesave{a}, X2(:,1)/vnew(a), 'g');
                plot(timesave{a}, X4(:,1)/vnew(a), 'm');
            else
                plot(timesave{a}, XR(:,1)/HL.xmax, 'b');
                plot(timesave{a}, X3(:,1)/HL.xmax, 'r');
                plot(timesave{a}, X2(:,1)/HL.xmax, 'g');
                plot(timesave{a}, X4(:,1)/HL.xmax, 'm');
            end
        end
        xlabel('Time (in days)')
        ylabel('xsum*, dimensionless cell density of stages')
        title(['Time versus Cell Density for a perturbation of ',name,...
            ' of ',num2str(perturb*100),' percent for ',...
            num2str(repeat),' different trials.'])
        hold off
        saveplot = input('Save this plot? 1 for yes, 0 for no:');
        if saveplot ~=1&&saveplot~=0
            saveplot = input('Invalid input, enter again:');
        end
        if saveplot
            file = input('Enter the filename:','s');
            saveas(f, file);
        end
    end
    running = input('Enter 1 to run again or 0 to stop:');
    while running ~=0&&running~=1
        running=input('Enter a valid input:');
    end
end
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
    munew = [];
    kdnew = [];
    xinew = [];
    RAnew = [];
    D3new = [];
    xmnew = [];
    fnew = [];
    RAmnew = [];
    D3mnew = [];
    perturb = [];
    for i = 1:9;
        perturba = rand*.5;
        perturb = [perturb, perturba];
    end
    name1 = 'growth rate';
    name2 = 'death rate';
    name3 = 'initial cell density';
    name4 = 'RA amount';
    name5 = 'D3 amount';
    name6 = 'maximum cell density';
    name7 = 'self renewal probability';
    name8 = 'minimum RA amount needed to reach the final stage';
    name9 = 'minimum D3 amount needed to reach the final stage';
    repeat = input('Enter how many iterations are wanted:');
    while repeat <=0
        repeat = input('Invalid input: Enter again:');
    end
    for j = 1:repeat;
        [x,t] = RAD3input(HL,0);
        HL60save{j}(:,1) = t;
        HL60save{j}(:,2:5) = x;
        munew = [munew, HL.mumax];
        kdnew = [kdnew, HL.kd];
        xinew = [xinew, HL.x];
        RAnew = [RAnew, HL.RA];
        D3new = [D3new, HL.D3];
        xmnew = [xmnew, HL.xmax];
        fnew = [fnew, HL.f];
        RAmnew = [RAmnew, HL.RAmin];
        D3mnew = [D3mnew, HL.D3min];
        HL.mumax = mumax+(mumax*perturb(1)-2*mumax*rand*perturb(1));
        HL.kd = kd+(kd*perturb(2)-2*kd*rand*perturb(2));
        HL.x = xinit+(xinit*perturb(3)-2*xinit*rand*perturb(3));
        HL.RA = RA+(RA*perturb(4)-2*RA*rand*perturb(4));
        HL.D3 = D3+(D3*perturb(5)-2*D3*rand*perturb(5));
        HL.xmax = xmax+(xmax*perturb(6)-2*xmax*rand*perturb(6));
        HL.f = f+(f*perturb(7)-2*f*rand*perturb(7));
        while HL.f>=1
            HL.f = f+(f*perturb(7)-2*f*rand*perturb(7));
        end
        HL.RAmin = RAmin+(RAmin*perturb(8)-2*RAmin*rand*perturb(8));
        HL.D3min = D3min+(D3min*perturb(9)-2*D3min*rand*perturb(9));
    end
    HL.mumax = mumax;
    HL.kd = kd;
    HL.x = xinit;
    HL.RA = RA;
    HL.D3 = D3;
    HL.xmax = xmax;
    HL.f = f;
    HL.RAmin = RAmin;
    HL.D3min = D3min;
    filename = input('Please enter name of file:','s');
    %fid = fopen(filename,'at');
    %for a = 1:length(HL60save)
        %fprintf(fid,'Data for run %d\n',a);
        %fprintf(fid,'%-10s %-10s %-10s %-10s %-10s\n', 'Time', ...
        %    'Stage 1','Stage 2','RA Final','D3 Final');
        %for b = 1:length(HL60save{a})
        %    fprintf(fid,'%-10.3d %-10.3d %-10.3d %-10.3d %-10.3d\n',...
        %        timesave{a}(b),HL60save{a}(b,:));
        %end
    %end
    %fclose(fid);
    begin = HL60save{1};
    save(filename,'begin','-ascii')
    for k = 2:length(HL60save)
        next = HL60save{k};
        save(filename,'next','-append','-ascii')
    end
    graph = input('Do you want a plot? yes=1,no=0:');
    while graph~=0&&graph~=1
        graph = input('Enter a valid input:');
    end
    if graph
        morepoint = 1;
        while morepoint
            fprintf('Choose a time after RA/D3 is put in at %d',HL.start);
            tpoint = input(':');
            fig = figure;
            hold on
            
            XR = [];
            X2=[];
            X3 = [];
            X4 = [];
            xrt = [];
            xr2 = [];
            xr3 = [];
            xr4 = [];
            for a = 1:length(HL60save)
                b = 1;
                while HL60save{a}(b,1)<500
                    before = b;
                    b = b+1;
                end
                c = b;
                tf = c;
                while HL60save{a}(c,1)<tpoint
                    tf = c;
                    c = c+1;
                end
                if (HL60save{a}(c,1)-tpoint)<(tpoint-HL60save{a}(tf,1))
                    tf = c;
                end
                XR = [XR, HL60save{a}(before, 2)/xmnew(a)];
                X2 = [X2, HL60save{a}(before, 3)/xmnew(a)];
                X3 = [X3, HL60save{a}(before, 4)/xmnew(a)];
                X4 = [X4, HL60save{a}(before, 5)/xmnew(a)];
                xrt = [xrt, HL60save{a}(tf, 2)/xmnew(a)];
                x2t = [x2t, HL60save{a}(tf, 3)/xmnew(a)];
                x3t = [x3t, HL60save{a}(tf, 4)/xmnew(a)];
                x4t = [x4t1, HL60save{a}(tf, 5)/xmnew(a)];
            end
            vect = 0:0.01:1;
            [n1, x1] = hist(XR, vect);
            [n2, x2] = hist(X2, vect);
            [n3, x3] = hist(X3, vect);
            [n4, x4] = hist(X3, vect);
            xlabel('xsum*')
            ylabel('number of trials')
            title(['Histogram for ', num2str(repeat),...
                ' different trials.'])
            hold off
            saveplot = input('Save this plot? 1 for yes, 0 for no:');
            if saveplot ~=1&&saveplot~=0
                saveplot = input('Invalid input, enter again:');
            end
            if saveplot
                file = input('Enter the filename:','s');
                saveas(fig, file);
            end
            close all
            morepoint = input('Do you want another point? yes=1,no=0:');
            if morepoint~=1&&morepoint~=0
                morepoint = input('Invalid input: enter again:');
            end
        end
    end
    running = input('Enter 1 to run again or 0 to stop:');
    while running ~=0&&running~=1
        running=input('Enter a valid input:');
    end
end
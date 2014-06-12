function parameters = samplefixed(HL)
%Runs the cell program for several variants of the input parameters and
%compares results at the same values of time, as well as saves the data
%at the end of the program.
%HL is an HL60 struct.
HLo = HL;
HL60save = {};
parameters = {};
xinew = {};
for i = 1:9;
    perturba = rand*.5;
    perturb(i) = perturba;
end
repeat = input('Enter how many iterations are wanted:');
while repeat <=0
    repeat = input('Invalid input: Enter again:');
end
for j = 1:repeat;
    HLo.mumax = HL.mumax+(HL.mumax*perturb(1)-...
        2*HL.mumax*rand*perturb(1));
    HLo.kd = HL.kd+(HL.kd*perturb(2)-2*HL.kd*rand*perturb(2));
    HLo.x = HL.x+(HL.x*perturb(3)-2*HL.x*rand*perturb(3));
    HLo.RA = HL.RA+(HL.RA*perturb(4)-2*HL.RA*rand*perturb(4));
    HLo.D3 = HL.D3+(HL.D3*perturb(5)-2*HL.D3*rand*perturb(5));
    HLo.xmax = HL.xmax+(HL.xmax*perturb(6)-2*HL.xmax*rand*perturb(6));
    HLo.f = HL.f+(HL.f*perturb(7)-2*HL.f*rand*perturb(7));
    while HL.f>=1
        HLo.f = HL.f+(HL.f*perturb(7)-2*HL.f*rand*perturb(7));
    end
    HLo.RAmin = HL.RAmin+(HL.RAmin*perturb(8)-...
        2*HL.RAmin*rand*perturb(8));
    HLo.D3min = HL.D3min+(HL.D3min*perturb(9)-...
        2*HL.D3min*rand*perturb(9));
    munew(j) = HLo.mumax;
    kdnew(j) = HLo.kd;
    xinew{j} = HLo.x;
    RAnew(j) = HLo.RA;
    D3new(j) = HLo.D3;
    xmnew(j) = HLo.xmax;
    fnew(j) = HLo.f;
    RAmnew(j) = HLo.RAmin;
    D3mnew(j) = HLo.D3min;
    parameters{j} = HLo;
    [x,t] = RAD3input(HLo,0);
    HL60save{j}(:,2) = t;
    HL60save{j}(:,1) = j;
    HL60save{j}(:,3:7) = x;
end
filename = input('Please enter name of file:','s');
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
    first =1;
    while morepoint
        fprintf('Choose a time after RA/D3 is put in at %d',HL.start);
        tpoint = input(':');
        before = 1;
        while HL60save{1}(before,2)<HL.start
            before = before+1;
        end
        tf = before;
        while HL60save{1}(tf,2)<tpoint
            tf = tf+1;
        end
        for a = 1:length(HL60save)
            if first
                bsumx = sum(HL60save{a}(before,3:7));
                XR(a) = HL60save{a}(before, 3)/bsumx;
                X2(a) = HL60save{a}(before, 4)/bsumx;
                X3(a) = HL60save{a}(before, 5)/bsumx;
                X4(a) = HL60save{a}(before, 6)/bsumx;
                X5(a) = HL60save{a}(before, 7)/bsumx;
            end
            sumx = sum(HL60save{a}(tf,3:7));
            xrt(a) = HL60save{a}(tf, 3)/sumx;
            x2t(a) = HL60save{a}(tf, 4)/sumx;
            x3t(a) = HL60save{a}(tf, 5)/sumx;
            x4t(a) = HL60save{a}(tf, 6)/sumx;
            x5t(a) = HL60save{a}(tf, 7)/sumx;
        end
        XRcell = {XR,X2,X3,X4,X5};
        xrtcell = {xrt,x2t,x3t,x4t,x5t};
        vect = 0:0.01:1;
        if first
            fig = figure;
            for stage = 1:5
                subplot(2,3,stage);
                hist(XRcell{stage}, vect);
                axis([-0.01 1.01 0 10])
                axis 'auto y'
                xlabel(['Fraction in Stage ', num2str(stage),...
                    ' at time ', num2str(HL60save{1}(before,2))])
                ylabel('Number of Trials')
                title([num2str(repeat),' trials in Stage ',...
                    num2str(stage),' at time ', ...
                    num2str(HL60save{1}(before,2))])
            end
            saveplot=input('Save this plot? 1 for yes, 0 for no:');
            if saveplot ~=1&&saveplot~=0
                saveplot = input('Invalid input, enter again:');
            end
            if saveplot
                file = input('Enter the filename:','s');
                saveas(fig, file);
            end
            close all
        end
        fig = figure;
        for stage = 1:5
            subplot(2,3,stage);
            hist(xrtcell{stage}, vect);
            axis([-0.01 1.01 0 10])
            axis 'auto y'
            xlabel(['Fraction in Stage ',num2str(stage),' at time ',...
                num2str(HL60save{1}(tf,2))])
            ylabel('Number of Trials')
            title([num2str(repeat),' trials in Stage ',num2str(stage),...
                ' at time ', num2str(HL60save{1}(tf,2))])
        end
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
        first =0;
    end
end
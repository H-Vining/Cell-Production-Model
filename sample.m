%Runs the cell program for several variants of the input parameters and
%compares results at the same values of time
xmax = 3*10^6;
f = 0.7;
mumax = 0.35;
kd = 0.03*.35;
xinit = [25,0,0,0];
RA = 0.3;
D3 = 0.1;
RAmin = 0.15;
D3min = 0.2;
ts = 500;
te = 1000;
%xmax = input('Enter the maximum cell density:');
%f = input('Enter the self renewal probability:');
%mumax = input('Enter the maximum growth rate:');
%kd = input('Enter the cell death rate:');
%xinit = input('Enter as a vector the initial cell density of each stage:');
%RA = input('Enter the amount of RA added');
%D3 = input('Enter the amount of D3 added');
%RAmin = input('Enter the minimum amount of RA to reach the final stage:');
%D3min = input('Enter the minimum amount of D3 to reach the final stage:');
%ts = input('Enter the time when RA and/or D3 is added:');
%te = input('Enter the time the simulations stop:');
HL60save = {};
kdnew = [];
HL = HL60struct(xmax,f,mumax,kd,xinit,RA,D3,RAmin,D3min,ts,te);
%running = 1;
%while running
%choice = 0;
%while choice==0
%disp('Choose one of the following to perturb:')
%disp('1: maximum growth rate');
%disp('2: death rate');
%disp('3: initial cell density;);
%disp('4: RA amount');
%disp('5: D3 amount');
%choice = input('Enter number of choice to perturb:');
%if choice == 1
%munew = [];
%
%perturb = input('Enter as number >0 and <1 amount to perturb:');
%if perturb<0 || perturb>1
%


for i = 1:100
    x = RAD3input(HL,0);
    HL60save = [HL60save, x];
    kdnew = [kdnew, HL.kd];
    HL.kd = 2*kd*rand;
end
HL.kd = 0.03*.35;
munew = [];
for j = 1:100;
    x = RAD3input(HL,0);
    HL60save = [HL60save, x];
    munew = [munew, HL.mumax];
    HL.mumax = 2*mumax*rand;
end
HL.mumax = 0.35;
filename = input('Please enter name of file:','s');
fid = fopen(filename,'w');
for a = 1:length(HL60save)
    fprintf(fid, 'Data for run %d\n', a);
    for b = 1:length(HL60save{a})
        fprintf(fid,'%d %d %d %d\n',HL60save{a}(b,:));
    end
end
fclose(fid);
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
HL = HL60struct(xmax,f,mumax,kd,xinit,RA,D3,RAmin,D3min,ts,te);
for i = 1:100
    x = RAD3input(HL,0);
    
end
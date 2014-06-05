function HL60Cell = HL60struct(xmax,f,mumax,kd,xinit,RA,D3,RAmin,D3min,ts,te)
%HL60Cell is a cell structure such that
% HL60Cell.xmax is the maximum cell density
% HL60Cell.f is the self renewal probability
% HL60Cell.mumax is the maximum growth rate
% HL60Cell.kd is the death rate
% HL60Cell.x is the initial cell density in each stage (size 4 vector)
% HL60Cell.RA is the amount of RA added
% HL60Cell.D3 is the amount of D3 added
% HL60Cell.RAmin is the minimum amount of RA needed to reach final stage
% HL60Cell.D3min is the minimum amount of D3 needed to reach final stage
% HL60Cell.start is the time the RA and/or D3 is added to the cell
% HL60Cell.end is the time one stops tracking the cell density
% population

HL60Cell = struct('xmax',xmax,'f',f,'mumax',mumax,'kd',kd,'x',xinit,...
    'RA',RA,'D3',D3,'RAmin',RAmin,'D3min',D3min,'start',ts,'end',te);

end


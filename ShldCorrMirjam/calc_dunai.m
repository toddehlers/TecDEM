function [P_nuc, P_mu_stopped, P_mu_fast, Ptot] = calc_dunai(Altitude,Latitude,siz)



%******************************************
%       Constants
%******************************************

p0_mbar = 1013.25;
b0_K__m = 6.5e-3;
T0_K = 288.15;
g0_m__s2 = 9.80665;
Rd_J__kg = 287.05;
Lambda_mu_fast = 1300;
Lambda_mu_stop = 247;

PNuc0 = 4.9;
PMuonS0 = 0.106;
PMuonF0 = 0.093;

Alkofer= 1;

%******************************************
%       Calculations
%******************************************

P0 = PNuc0 + PMuonS0 + PMuonF0;
f_mu_fast = PMuonF0 / (PNuc0 + PMuonS0 + PMuonF0) ;
f_mu_stop = PMuonS0 / (PNuc0 + PMuonS0 + PMuonF0) ;


A = (atan(2.*tan(Latitude.*pi./180))).*180./pi;
B = p0_mbar.*((1-b0_K__m.*Altitude./T0_K).^(g0_m__s2./Rd_J__kg./b0_K__m));
C = 10.*B./g0_m__s2;
Atmospheric_depth = 10.*p0_mbar./g0_m__s2;
D = Atmospheric_depth - C;
E = 0.5555+(0.445./((1+exp(-(A-62.698)./4.1703)).^0.335));
F =129.55+19.85./((1+exp(-(A-62.05)./(-5.43))).^3.59);
whos
G = E.*exp(D./F);

Nz_tot = E.*exp(D./F).*(1-f_mu_fast-f_mu_stop)+exp(D./Lambda_mu_stop).*f_mu_stop+(1+0.0581.*Altitude./1000).*f_mu_fast;
Nz_mu_stop = exp(D./Lambda_mu_stop).*Alkofer;
Nz_mu_fast = 1+0.0581.*Altitude./1000;

P_nuc = P0.*G.*(1-f_mu_fast-f_mu_stop);

P_mu_stopped = P0.*Nz_mu_stop.*f_mu_stop;

P_mu_fast =P0.*Nz_mu_fast.*f_mu_fast;

Ptot = P0.* Nz_tot;


P_nuc = reshape(P_nuc,siz);
P_mu_stopped = reshape(P_mu_stopped,siz);
P_mu_fast = reshape(P_mu_fast,siz);
Ptot = reshape(Ptot,siz);

end
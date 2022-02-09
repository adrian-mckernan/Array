close all;
 
fc = 2.4;  % freq in 'GHz'
la = 300/fc;%% wavelength in 'mm'
N = 5; % number of elements in the array 
en = 1:N;%  'en' represents element number starting with '0'.
len = length(en); %%% Length of the array
al = length(en); %%% array size
k = 2*pi/la; %% the wave number
d=67;
theta = 0:1:180; %%% angle of arrival of plane wave.

%%% for beam steering by theta_0 s
sa = 90;
beta = -k*d*cosd(sa); %% progressive  phase

phi = rad2deg(k*d*cosd(theta)) + rad2deg(beta);

%% equation 10 
for ii = 1:len
    af_1(ii,:) = exp(1i*(en(ii)-1)*deg2rad(phi));
end

afs = sum(af_1,1);

ep = abs(cosd(90 + theta));  %%% dipole element pattern
rp = ep.*afs;
afm = abs(rp);
afn = afm/max(afm); 

plot(theta,afn,'r');
grid on
hold on
saveas(gcf,'5_element_theory.png')


figure;
theta_radians = deg2rad(theta);
MagE = 10*log10(afn);
polarplot(theta_radians,MagE)
rlim([min(MagE) max(MagE)])
title('5 Element dipole')


figure;
theta_radians = deg2rad(theta);
MagE = 5*(afn);
polarplot(theta_radians,MagE)
rlim([min(MagE) max(MagE)])
title('5 Element dipole')


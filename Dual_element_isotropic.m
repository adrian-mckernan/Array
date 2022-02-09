close all
clear all
fc = 2.4;  % freq in 'GHz'
la = 300/fc;%% wavelength in 'mm'
N = 2; % number of elements in the array 
en = 1:N;%  'en' represents element number starting with '0'.
len = length(en); %%% Length of the array
al = length(en); %%% array size
k = 2*pi/la; %% the wave number
d = la/2; %%% separation between elements
theta = 0:1:360; %%% angle of arrival of plane wave.
%%% for beam steering by theta_0 s
sa = 90;
beta = -k*d*cosd(sa); %% progressive  phase
phi = rad2deg(k*d*cosd(theta)) + rad2deg(beta);

%% Equation 10 
for ii = 1:len
    af_1(ii,:) = exp(1i*(en(ii)-1)*deg2rad(phi));
end
afs = sum(af_1,1);
% Element Factor of ideal isotropic element
ep = ones(size(theta));%%% uniform  element pattern
rp = ep.*afs;   % resultant pattern
afm = abs(rp);  % get the magbiurde of the array
afn = afm/max(afm); 

figure;
theta_radians = deg2rad(theta);
polarplot(theta_radians,afm,'b')
rlim([min(afm) max(afm)])
hold on;
polarplot(theta_radians,abs(afs),'--r')
polarplot(theta_radians,ep,'m')
legend('Isotropic Element', 'Array Factor', 'Array Pattern','Location','NorthEastOutside')
saveas(gcf,'2_element_theory.png');



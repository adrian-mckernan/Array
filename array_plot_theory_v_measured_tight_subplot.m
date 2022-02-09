close all
clear all

%%
% Import Measured array patterns
filenames = {
'5ELA_P1E1_P2E2_P3E3_4E4_P5E5_ProgPhase_m180_.txt' 
'5ELA_P1E1_P2E2_P3E3_4E4_P5E5_ProgPhase_m155_1.txt'        
'5ELA_P1E1_P2E2_P3E3_4E4_P5E5_ProgPhase_m127_.txt' 
'5ELA_P1E1_P2E2_P3E3_4E4_P5E5_ProgPhase_m90_.txt'    
'5ELA_P1E1_P2E2_P3E3_4E4_P5E5_ProgPhase_0_.txt'       
'5ELA_P1E1_P2E2_P3E3_4E4_P5E5_ProgPhase90.txt'  
'5ELA_P1E1_P2E2_P3E3_4E4_P5E5_ProgPhase_127_.txt'  
};
 sa = [0 30 45 60 90 120 135 ] ;
 fh= figure;
ha = tight_subplot(3,3,[.1 .03],[.1 .05],[.01 .01]);
plotdata = {};
for i=1:length(filenames)
    filename = filenames{i};
    data = importOrbitTxt(filename);
    plotdata = {plotdata data};
%     subplot(2,4,i)
    axes(ha(i));
    ha(i).FontSize = 20; 
    phi = zeros(size(data.Azimuth_deg));
    theta = 90 - data.Azimuth_deg;
    theta_radians = deg2rad(theta);
%     theta_radians = unwrap(theta_radians);
    MagM = data.Amplitude;
    polarplot(theta_radians,MagM,'LineWidth',4)
    rlim([-30 10])
%     rlim([min(MagM) max(MagM)])
%     title(filename)
    ax = gca;
    ax.ThetaLim = [0 180];
    ax.ThetaZeroLocation = 'left';
    ax.ThetaDir = 'clockwise';
    steering_angle = sa(i);
    [beta,MagE,theta_radians] = plot_theroy_dipole(steering_angle);
    display([beta steering_angle])
    hold on;
    polarplot(theta_radians,MagE,'LineWidth',4)
%     legend('Measured', 'Calculated','Location','NorthOutside')
    txt = [char(952) ' = ' int2str(steering_angle)  char(176)];
    t = title(txt, 'Units', 'normalized', 'Position', [0.5, -0.3, 0],'FontSize', 20);

end


% subplot(2,4,8)
 axes(ha(end-1));
set(ha(end-1),'Visible','Off')
 axes(ha(end));
plot(1,1,'LineWidth',4)
hold on 
plot(1,1,'LineWidth',4)
set(ha(end),'Visible','Off')
lg = legend('Measured', 'Calculated','Position',[.55 .1 .15 .15]);
lg.FontSize = 20;
fh.WindowState = 'maximized';
pause(5)

%%
lg.Position= [0.55 0.1 .15 .15];
saveas(gcf,'Measured_vs_Calulates_array_patterns.png')
%%

function [beta,MagE,theta_radians]  = plot_theroy_dipole(steering_angle)

    fc = 2.4;  % freq in 'GHz'
    la = 300/fc;%% wavelength in 'mm'
    N = 5; % number of elements in the array 
    en = 1:N;%  'en' represents element number starting with '0'.
    len = length(en); %%% Length of the array
    al = length(en); %%% array size
    k = 2*pi/la; %% the wave number
    d=67;
    theta = 0:1:180; %%% angle of arrival of plane wave.
    beta = -k*d*cosd(steering_angle); %% progressive  phase
    % disp(rad2deg(beta))
    phi = rad2deg(k*d*cosd(theta)) + rad2deg(beta);

    for ii = 1:len
        af_1(ii,:) = exp(1i*(en(ii)-1)*deg2rad(phi));
    end

    afs = sum(af_1,1);

    % ep = ones(size(theta));%%% uniform  element pattern
    ep = abs(cosd(90 + theta));  %%% dipole element pattern
    rp = ep.*afs;
    afm = abs(rp);
    afn = afm/max(afm); 
    theta_radians = deg2rad(theta);
    MagE = 10*log10(afm);
    

end
%%

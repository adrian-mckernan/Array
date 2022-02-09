function [beta,MagE,theta_radians]  = plot_n_element_dipole_array(number_elements,steering_angle)

    fc = 2.4;  % freq in 'GHz'
    la = 300/fc;%% wavelength in 'mm'
    N = number_elements; % number of elements in the array 
    en = 1:N;%  'en' represents element number starting with '0'.
    len = length(en); %%% Length of the array
    al = length(en); %%% array size
    k = 2*pi/la; %% the wave number
    d=67;
    theta = 0:1:180; %%% angle of arrival of plane wave.
    beta = -k*d*cosd(steering_angle); %% progressive  phase   
    phi = rad2deg(k*d*cosd(theta)) + rad2deg(beta);

    for ii = 1:len
        af_1(ii,:) = exp(1i*(en(ii)-1)*deg2rad(phi));
    end

    afs = sum(af_1,1);

    
    ep = abs(cosd(90 + theta));  %%% dipole element pattern
    rp = ep.*afs;
    afm = abs(rp);
    afn = afm/max(afm); 
    theta_radians = deg2rad(theta);
    MagE = 10*log10(afm);
    
    polarplot(theta_radians,MagE)
    rlim([min(MagE) max(MagE)])
    ttl = num2str(number_elements);
    str_ang = num2str(steering_angle);
    prog_phase = num2str(rad2deg(beta));
    title([ttl ' Element dipole, steering angle ' str_ang char(176) ', progressive phase ' prog_phase char(176)])
end
% Source Loction
source = [0;0;20000];

% Reference Points - 1 to N
N = 4;
p1 = [-2000;-2000;0];
p2 = [-2000;2000;0];
p3 = [2000;-2000;0];
p4 = [2000;2000;0];
p = [p1,p2,p3,p4];

% Generate Time of Flight
t1 = norm(p1-source)/3e8;
t2 = norm(p2-source)/3e8;
t3 = norm(p3-source)/3e8;
t4 = norm(p4-source)/3e8;
t = [t1,t2,t3,t4];

% Lets model the timing error. There are three sources of error:
% 1) Extracting the TOF by cross-correlation. Our model suggests this
%    can be done to nearest sample.
% 2) Stream misalignment due to PPS skew. Testing showed that the skew
%    was normally distributed ~ N(0, 11.17e-9).
% 3) VCTCXO Drift.

% Error Due to Drift
n = 30.72e6;
f1 = 30.72e6;
f2 = 30720000.5;
err_ps = n*((1/f2)-(1/f1));
z_err = [];

% Model Error over Time
tmax = 120;
step = 0.2;
for i = 0:step:tmax
    
    T = 1/(30.72e6);
    t1_n = T*round((t1 + i*err_ps + normrnd(0, 11.17e-9))/T);
    t2_n = T*round((t2 + i*err_ps + normrnd(0, 11.17e-9))/T);
    t3_n = T*round((t3 + i*err_ps + normrnd(0, 11.17e-9))/T);
    t4_n = T*round((t4 + i*err_ps + normrnd(0, 11.17e-9))/T);
    t_n = [t1_n, t2_n, t3_n, t4_n];
    
    % Compute Position Error
    p0 = trilat_3d(p,t_n.*3e8,N);
    err = abs(p0-source);
    z_err = [z_err, err(3)];    
end

% Plot Output
figure
plot(0:step:tmax, z_err)
xlabel('Time Elapsed (s)');
ylabel('Z Error (m)');
title('VCTCXO Drift Induced Altitude Error');

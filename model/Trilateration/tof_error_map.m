% Reference Points - 1 to N
N = 4;
p1 = [-2000;-2000;0];
p2 = [-2000;2000;0];
p3 = [2000;-2000;0];
p4 = [2000;2000;0];
p = [p1,p2,p3,p4];

% Source Path
x = -4000:50:4000;
y = -4000:50:4000;
z = 20e3;

% Generate Mesh
[X,Y] = meshgrid(x,y);
dim = size(X);
Z_ERR = zeros(dim);

% Traverse Search Area
for i = 1:1:dim(1)
   for j = 1:1:dim(1)

        % Source Location 
        source = [X(i,j); Y(i,j); z];

        % Compute True Time of Flight
        t1 = norm(p1-source)/3e8;
        t2 = norm(p2-source)/3e8;
        t3 = norm(p3-source)/3e8;
        t4 = norm(p4-source)/3e8;
        t = [t1,t2,t3,t4];
        
        % Add Timing Error
        T = 1/(30.72e6);
        t1_n = T*round((t1 + normrnd(0, 11.17e-9))/T);
        t2_n = T*round((t2 + normrnd(0, 11.17e-9))/T);
        t3_n = T*round((t3 + normrnd(0, 11.17e-9))/T);
        t4_n = T*round((t4 + normrnd(0, 11.17e-9))/T);
        t_n = [t1_n, t2_n, t3_n, t4_n];
        
        % Compute Position Error (to m)
        p0 = trilat_3d(p,3e8.*t_n,N);
        err = abs(p0-source);
        Z_ERR(i,j) = round(err(3));
   end
end

% Display Results
figure
surf(X,Y,Z_ERR)

% Filter Data
H = fspecial('average', 16);
Z_FILT = filter2(H,Z_ERR);

% Display Filtered Results
figure
surf(X,Y,Z_FILT)




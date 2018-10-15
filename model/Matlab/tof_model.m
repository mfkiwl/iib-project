% Source Loction
source = [2000;3000;14000];

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

% Introduce Timing Error
T = 1/(30.72e6);
t1 = t1 - 2*T;
t2 = t2 - 2*T;
t3 = t3 + 2*T;
t4 = t4 + 2*T;

% Generate Distance Vector
r = 3e8.*[t1,t2,t3,t4];

% Estimate Position
p0 = trilat_3d(p,r,N);
abs_err = abs(p0-source);
err_mag = norm(abs_err);

% Print Solution
disp(sprintf('RESULTS:'));
disp(sprintf('Actual Position: (%g, %g, %g)', source));
disp(sprintf('Position Estimate: (%g, %g, %g)', p0));
disp(sprintf('Estimate Error: (%g, %g, %g)', abs_err));
disp(sprintf('Absolute Error: %g m', err_mag));

figure;
hold on
grid on
xlabel('X (m)');
ylabel('Y (m)');
title('Time of Flight Position Estimate');

% Plot the Reference Points
plot([p1(1),p2(1),p3(1),p4(1)],[p1(2),p2(2),p3(2),p4(2)],'MarkerSize',25,'Marker','.','LineStyle','none');

% Plot the True & Estimated Source Positions
plot(source(1), source(2),'MarkerSize',25,'Marker','.','LineStyle','none');
plot(p0(1), p0(2),'MarkerSize',25,'Marker','.','LineStyle','none');

% Plot Spheres
figure;
[X,Y,Z] = sphere;
hold on;
surf(r(1)*X+p1(1),r(1)*Y+p1(2),r(1)*Z+p1(3));
surf(r(2)*X+p2(1),r(2)*Y+p2(2),r(2)*Z+p2(3));
surf(r(3)*X+p3(1),r(3)*Y+p3(2),r(3)*Z+p3(3));
surf(r(4)*X+p4(1),r(4)*Y+p4(2),r(4)*Z+p4(3));
%xlim([-5000,5000]);
%ylim([-5000,5000]);
%zlim([-5000,5000]);


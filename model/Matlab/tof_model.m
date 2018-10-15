% Source Loction
source = [150;100;18];

% Reference Points - 1 to N
p1 = [-500*sqrt(3);-600;0];
p2 = [0;1000;0];
p3 = [500*sqrt(3);-500;0];
p4 = [100;200;0];
N = 4;
p = [p1,p2,p3,p4];


% Generate Distances
r1 = norm(p1-source);
r2 = norm(p2-source);
r3 = norm(p3-source);
r4 = norm(p4-source);
r = [r1,r2,r3,r4];

% Estimate Position
p0 = trilat_3d(p,r,N)
error = norm(p0-source)

% Plot 2D Layout
hold on
grid on
plot([p1(1),p2(1),p3(1),p4(1)],[p1(2),p2(2),p3(2),p4(2)],'MarkerSize',25,'Marker','.','LineStyle','none');
plot(source(1), source(2),'MarkerSize',25,'Marker','.','LineStyle','none');
plot(p0(1), p0(2),'MarkerSize',25,'Marker','.','LineStyle','none');



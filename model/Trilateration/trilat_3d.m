function ret = trilat_3d(p,r,N)
%% Function Description
% p = (3xN) matrix of reference positions  
% r = (Nx1) vector of distances from source to reference
% N = Number of reference points
% Returns a (3x1) vector containing the position estimate.
%
% Based on https://ieeexplore.ieee.org/document/5354370

% 3D Space
n = 3;

%% Step 1: Calculate Useful Variables

    % Calculate a,B,c
    a = zeros(n,1);
    B = zeros(n,n);
    c = zeros(n,1);
    for i = 1:N
        a = a + ((p(:,i)*transpose(p(:,i))*p(:,i)) - ((r(i)^2).*p(:,i)));
        B = B + (-2.*p(:,i)*transpose(p(:,i)) - (transpose(p(:,i))*p(:,i))*eye(n) + (r(i)^2).*eye(n));
        c = c + p(:,i);
    end
    a = a/N;
    B = B/N;
    c = c/N;

    % Calculate f,H
    f = a + B*c + 2*c*transpose(c)*c;
    H = zeros(n,n);
    for i = 1:N
        H = H + (c*transpose(c) - p(:,i)*transpose(p(:,i)));     
    end
    H = H*(2/N);

    % Calculate f', H'
    fprime = zeros(n-1,1);
    Hprime = zeros(n-1,n);
    for i = 1:n-1
        fprime(i) = f(i) - f(n);
        Hprime(i,:) = H(i,:) - H(n,:);
     end

    % Calculate Q,U
    [Q,U] = qr(Hprime);

    % Calculate v
    v = transpose(Q)*fprime;

    %% Step 2: Calculate qtq from (15)
    qtq = 0;
    for i = 1:N
        qtq = qtq + (r(i)^2) + transpose(c)*c - transpose(p(:,i))*p(:,i);
    end
    qtq = qtq/N;

    %% Step 3: For 3D calculate q3 from (16) 
    % [a+b*q(3)]^2 + [c+d*q(3)]^2 + q(3)^2 = qtq
    
    q = zeros(n,2); 
    poly_a = (U(1,2)*v(2))/(U(1,1)*U(2,2)) - (v(1)/U(1,1));
    poly_b = ((U(1,2)*U(2,3))/(U(1,1)*U(2,2))) - (U(1,3)/U(1,1));
    poly_c = v(2)/U(2,2);
    poly_d = U(2,3)/U(2,2);

    q(3,:) = roots([1 + poly_b^2 + poly_d^2,...
           2*(poly_a*poly_b + poly_c*poly_d),...
           poly_a^2 + poly_c^2 - qtq]);

    %% Step 4: For 3D calculate q1 and q2 from (13)
    q(1,:) = poly_a + poly_b * q(3,:);
    q(2,:) = 0 - poly_c - poly_d * q(3,:);

    %% Step 5: Calculate p0 from (4)
    pos = q + [c,c];

    %% Step 6: Return Positive Estimate
    if(pos(3,1)>0)
        ret = pos(:,1);
    else
        ret = pos(:,2);
    end

end
n=4;
m=5;
c=4;
H = diag([zeros(1,1),ones(1, n), zeros(1, m)]);
f = [zeros(1,n+1), c*ones(1, m)];
A = [-ones(n,1), 10*ones(n,1), -eye(n)]
b = -ones(n,1);

lb = [-inf*ones(n+1,1); zeros(m,1)]
ub = [inf*ones(n+1+m,1)]
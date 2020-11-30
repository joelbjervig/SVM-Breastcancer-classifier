

x0 =[1,2]

func = "x(1)*exp(x(2)*t,x(1),x(2), t";
%x0 = 0 ;%"initial value"



levmarq(func,x0);
%syms x y z
%f = x*y + 2*z*x;
%hessian(f,[x,y,z])
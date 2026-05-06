clc
clear;
format short;














































f = @(x1, x2)(x1.^2 + 2*x2.^2);
x=[3;3];
gradf=@(x1,x2)[2*x1;4*x2];
tol=1e-6;
a=0.1;
Max_itr=100;







for i=1:Max_itr
    grad=gradf(x(1),x(2));
    if norm(grad)<tol
        fprintf('converged');
        break;
    end
    x=x-(a*grad);
end
disp(x)
disp(f(x(1),x(2)))
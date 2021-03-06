function sp = natural_spline(knote,y,xx)
%%% Useage sp = natural_spline(x,y,xx)
%%% program to calculate the natural spline of a function
%%% using the sparse matrix operations of MATLAB
%%% use the same structure as MATLAB's spline function return (pp form)
%%% but also including the result for yy and xx

%% set some initial structure
sp = struct();
sp.breaks = knote;
if exist('xx','var')
    sp.xx = xx;
end
sp.pieces = length(knote) - 1;
sp.order = 4;
sp.dim = 1;

%% build the matrix to solve M
% see http://www.bb.ustc.edu.cn/jpkc/xiaoji/szjsff/jsffkj/chapt1_6_1.htm
h = knote(2:end) - knote(1:end-1);
lambda = h(2:end) ./ (h(1:end-1) + h(2:end));
mu = 1 - lambda;
d1 = h(1:end-1) + h(2:end) ;
d2 = (y(3:end) - y(2:end-1))./h(2:end) ;
d2 = d2 - (y(2:end-1) - y(1:end-2))./h(1:end-1);
d = 6 ./ d1 .* d2;
% matrix to solve
A = eye(length(lambda));
A = 2 * A + diag(lambda(1:end-1),1) + diag(mu(2:end),-1);
% as is natural spline, M0, Mn = 0
M0 = 0;
Mn = 0;
b = d;
b(1) = d(1) - mu(1)*M0;
b(end) = b(end) - mu(end)*Mn;

%% solve for M
b = b';
M = A\b;
M = [0; M; 0];


%% calculate the coeficient
coef = ones(sp.pieces,4);
for i = 1:sp.pieces
    coef(i,1) = M(i)/(6*h(i)); % for (x(i+1)-x)^3
    coef(i,2) = M(i+1)/(6*h(i)); % for (x-x(i))^3
    coef(i,3) = y(i) / h(i) - h(i) * M(i)/6; % for (x(i+1)-x)
    coef(i,4) = y(i+1) / h(i) - h(i) * M(i+1)/6; % for (x-x(i))
end
sp.coefs = coef;

%% calculate yy
if exist('xx','var')
    yy = [];
    %knote
    for xi= xx
        yy = [yy envIntp(coef,knote,xi)];
    end
    sp.yy = yy;
end

end


function y = envIntp(coef,x,xi)
%%% calculate the value of points from spline
for i=1:length(x)-1
    if (ge(xi,x(i)) && le(xi,x(i+1)))
        y = coef(i,1)*(x(i+1)-xi)^3 + coef(i,2)*(xi-x(i))^3 + coef(i,3)*(x(i+1)-xi) + coef(i,4)*(xi-x(i));
        break;
    end
end

end
function [yy,xx,errmax] = S_nat(f,x,N)
%%% Useage yy = S_nat(f,x,N)
%%% return the yy value on selected gird points xij = xi+(j-1)/(N-1)delta_x
    
    %% gen y and xx list
    y = f(x(1));
    xx = [];
    xx_span = (0:(N-1)) ./ (N-1);
    for i=2:length(x)
        y = [y f(x(i))];
        xx = [xx x(i-1)+xx_span.*(x(i)-x(i-1))];
    end

    %% gen yy_true list
    yy_true = xx;
    for i=1:length(xx)
        yy_true(i) = f(xx(i));
    end
    
    %% do the spline
    sp = natural_spline(x,y,xx);
    yy = sp.yy;
    
    %% calculate error
    errmax = [];
    for i = 1:length(x)-1
        currErr = max(abs(yy((N-1)*(i-1)+1:(N-1)*i) - yy_true((N-1)*(i-1)+1:(N-1)*i)));
        errmax = [errmax currErr];
        
    end
end
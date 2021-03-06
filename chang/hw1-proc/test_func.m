%%% top script to solve homework's problem
diary('result.txt')
diary on
% functions to test
listFunc = {@(x)exp(x), ...
    @(x)cos(2.*pi*x), ...
    @(x)cos(20.*pi*x), ...
    @(x)sqrt(x)};
nameFunc = {'$f(x) = e^x$', ...
    '$f(x) = \cos(2 \pi x)$', ...
    '$f(x) = \cos(20 \pi x)$', ...
    '$f(x) = \sqrt{x}$'};

x = 0:0.1:1;
N = 100;
for i = 1:length(listFunc)
    f = listFunc{i};
    y_true = f(x);
    [yy,xx,errmax] = S_nat(f,x,N);
    yy_buildin = spline(x,y_true,xx);
    yy_true = f(xx);
    % print the error pre block
    fprintf('\nFunction: %s\n',nameFunc{i});
    fprintf('ERR for each block\n');
    fprintf('block \t\t errmax\n');
    for j = 1:length(errmax)
        fprintf('%.2f,%.2f\t%6E\n',x(j),x(j+1),errmax(j));
    end
    
    % plot out
    fig = figure;
    hold on
    plot(x,y_true,'o')
    plot(xx,yy_true,'g')
    plot(xx,yy,'b')
    plot(xx,yy_buildin,'r')    
    legend('knots','True value','My Own script','MATLAB build-in')
    title(nameFunc{i},'Interpreter','latex','fontsize',24)
    xlabel('x')
    ylabel('f(x)')
    fname = sprintf('func_%d',i);
    savefig(fname);
    print(fig,fname,'-depsc','-tiff');
    print(fig,fname,'-dpng');
    close(fig);
end

% increase the size of knots(5 times)
x = 0:0.02:1;
N = 100;
for i = 1:length(listFunc)
    f = listFunc{i};
    y_true = f(x);
    [yy,xx,errmax] = S_nat(f,x,N);
    yy_buildin = spline(x,y_true,xx);
    yy_true = f(xx);
    % print the error pre block
    fprintf('\nFunction: %s\n',nameFunc{i});
    fprintf('ERR for each block\n');
    fprintf('block \t\t errmax\n');
    for j = 1:length(errmax)
        fprintf('%.2f,%.2f\t%6E\n',x(j),x(j+1),errmax(j));
    end
    
    % plot out
    fig = figure;
    hold on
    plot(x,y_true,'o')
    plot(xx,yy_true,'g')
    plot(xx,yy,'b')
    plot(xx,yy_buildin,'r')    
    legend('knots','True value','My Own script','MATLAB build-in')
    title(nameFunc{i},'Interpreter','latex','fontsize',24)
    xlabel('x')
    ylabel('f(x)')
    fname = sprintf('funcL_%d',i);
    savefig(fname);
    print(fig,fname,'-depsc','-tiff');
    print(fig,fname,'-dpng');
    close(fig);
end




diary off

x = 0:0.001:1;
e1 = exp(x) - 1 - x;
e2 = exp(x) - 1 - 1.5* x;
fig1 = figure;
plot(x,e1)
hold on 
grid on
plot(x,e2)
xlabel('x')
ylabel('Error')
legend('e_1 = e^x - (1 + x)','e_2 = e^x - (1 + cx)')
fname='q5_b';
title('Error Curve for 1^{st} order Taylor approximation')
savefig(fname);
print(fig1,fname,'-depsc','-tiff');
print(fig1,fname,'-dpng');
close(fig1);


e1 = exp(x) - 1 - x - 0.5 * x.^2;
c1 = 164- 60 * exp(1);
c2 = 80*exp(1) - 650./3.;
e2 = exp(x) - 1 - c1 * x - c2 * x.^2;
fig2 = figure;
plot(x,e1)
hold on 
grid on
plot(x,e2)
xlabel('x')
ylabel('Error')
legend('e_1 = e^x - (1 + x + 0.5x^2)','e_2 = e^x - (1 + c_1x + c_2x^2)')
fname='q5_c';
title('Error Curve for 2^{nd} order Taylor approximation')
savefig(fname);
print(fig2,fname,'-depsc','-tiff');
print(fig2,fname,'-dpng');
close(fig2);
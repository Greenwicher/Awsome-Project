

% using the symbolic computation to solve algebraic equation
f = sym('3*8+2*(exp(2+log(PL))+exp(2.5+log(2/(1-0.7/0.4*(PL-2)/PL)))+exp(3+log(2/(1-0.7/0.1*(PL-2)/PL))))-3*exp(2+log(PL))*PL-2*(exp(2.5+log(2/(1-0.7/0.4*(PL-2)/PL)))-exp(2+log(PL)))*2/(1-0.7/0.4*(PL-2)/PL)-(exp(3+log(2/(1-0.7/0.1*(PL-2)/PL)))-exp(2.5+log(2/(1-0.7/0.4*(PL-2)/PL))))*2/(1-0.7/0.1*(PL-2)/PL)');

% generate the solution
PL = solve(f, 'PL')
PL = double(PL(2));

% assign values to parameter
F = 8;
MC = 2;
CL = log(4.9);
CM = log(6.9);
CH = log(14.4);
a = -0.6;
b = -0.4;
c = -0.2;

% compute other variable
QL = exp(CL+log(PL));
QM = exp(CM+log(MC/(1-a/b*(PL-MC)/PL)));
QH = exp(CH+log(MC/(1-a/c*(PL-MC)/PL)));
PM = MC/(1-a/b*(PL-MC)/PL);
PH = MC/(1-a/c*(PL-MC)/PL);

%plot the quantity-price graph
line([0 QL], [PL PL]);
line([QL QM],[PM PM]);
line([QM, QH],[PH PH]);
line([QL QL],[PL PM], 'LineStyle', ':');
line([QM QM],[PM PH], 'LineStyle', ':');
line([QH QH],[2 PH], 'LineStyle', ':');
text(QL,PL, sprintf('(%4.2f, %4.2f)', QL, PL));
text(QM,PM, sprintf('(%4.2f, %4.2f)', QM, PM));
text(QH,PH, sprintf('(%4.2f, %4.2f)', QH, PH));
xlabel('water demand ( m^3/month )');
ylabel('water price ( yuan/m^3)')

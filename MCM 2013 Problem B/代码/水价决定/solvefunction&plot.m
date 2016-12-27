

% f = sym('3F+MC*(exp(CL+log(PL))+exp(CM+log(MC/(1-a/b*(PL-MC)/PL)))+exp(CH+log(MC/(1-a/c*(PL-MC)/PL))))-3*PL*exp(CL+log(PL))-2*(exp(CM+log(MC/(1-a/b*(PL-MC)/PL)))-exp(CL+log(PL)))*MC/(1-a/b*(PL-MC)/PL)');
% version 1
% f = sym('30+2*(exp(2.5+log(PL))+exp(2+log(2/(1-0.1/0.4*(PL-2)/PL)))+exp(1.5+log(2/(1-0.1/0.7*(PL-2)/PL))))-3*exp(2.5+log(PL))*PL-2*(exp(2+log(2/(1-0.1/0.4*(PL-2)/PL)))-exp(2.5+log(PL)))*2/(1-0.1/0.4*(PL-2)/PL)-(exp(1.5+log(2/(1-0.1/0.7*(PL-2)/PL)))-exp(2+log(2/(1-0.1/0.4*(PL-2)/PL))))*2/(1-0.1/0.7*(PL-2)/PL)');

% F = sym('F');
% QL = sym('QL');
% QM = sym('QM');
% QH = sym('QH');
% PL = sym('PL');
% PM = sym('PM');
% PH = sym('PH');
% a = sym('a');
% b = sym('b');
% c =sym('c');

% f =sym('3*F+MC*(exp(CL+log(PL))+exp(CM+log(MC/(1-a/b*(PL-MC)/PL)))+exp(CH+log(MC/(1-a/c*(PL-MC)/PL))))-3*PL*exp(CL+log(PL))-2*(exp(CM+log(MC/(1-a/b*(PL-MC)/PL)))-exp(CL+log(PL)))*MC/(1-a/b*(PL-MC)/PL)');

% version 2
% f = sym('30+2*(exp(1.5+log(PL))+exp(2+log(2/(1-0.7/0.4*(PL-2)/PL)))+exp(2.5+log(2/(1-0.7/0.1*(PL-2)/PL))))-3*PL*exp(1.5+log(PL))-2*(exp(2+log(2/(1-0.7/0.4*(PL-2)/PL)))-exp(1.5+log(PL)))*2/(1-0.7/0.4*(PL-2)/PL)');

% version 3
% f = sym('30+2*(exp(1.5+log(PL))+exp(2+log(2/(1-0.6/0.4*(PL-2)/PL)))+exp(2.5+log(2/(1-0.6/0.2*(PL-2)/PL))))-3*PL*exp(1.5+log(PL))-2*(exp(2+log(2/(1-0.6/0.4*(PL-2)/PL)))-exp(1.5+log(PL)))*2/(1-0.6/0.4*(PL-2)/PL)');

% version 4
% f = sym('3*8+2*(exp(1.5892+log(PL))+exp(1.9315+log(2/(1-0.6/0.4*(PL-2)/PL)))+exp(2.6672+log(2/(1-0.6/0.2*(PL-2)/PL))))-3*PL*exp(1.5892+log(PL))-2*(exp(1.9315+log(2/(1-0.6/0.4*(PL-2)/PL)))-exp(1.5892+log(PL)))*2/(1-0.6/0.4*(PL-2)/PL)');

% version 5
% f = sym('3*8+2*(exp(1.5+log(PL))+exp(2+log(2/(1-0.2/0.4*(PL-2)/PL)))+exp(2.5+log(2/(1-0.2/0.2*(PL-2)/PL))))-3*PL*exp(1.5+log(PL))-2*(exp(2+log(2/(1-0.2/0.4*(PL-2)/PL)))-exp(1.5+log(PL)))*2/(1-0.2/0.4*(PL-2)/PL)');

% version 6
% f = sym('3*8+2*(exp(1.5+log(PL))+exp(2+log(2/(1-0.6/0.4*(PL-2)/PL)))+exp(2.5+log(2/(1-0.6/0.2*(PL-2)/PL))))-3*PL*exp(1.5+log(PL))-2*(exp(2+log(2/(1-0.6/0.4*(PL-2)/PL)))-exp(1.5+log(PL)))*2/(1-0.6/0.4*(PL-2)/PL)-(exp(1.5+log(2/(1-0.1/0.7*(PL-2)/PL)))-exp(2+log(2/(1-0.1/0.4*(PL-2)/PL))))*2/(1-0.6/0.2*(PL-2)/PL)');

% version 7  (0.6 0.4 0.2)  (1.5 2 2.5) F=8 MC=2
F = 8;
MC = 2;
CL = log(4.9);
CM = log(6.9);
CH = log(14.4);
a = -0.6;
b = -0.4;
c = -0.2;
% Target Version
% f = sym('3*8+2*(exp(1.5+log(PL))+exp(2+log(2/(1-0.6/0.4*(PL-2)/PL)))+exp(2.5+log(2/(1-0.6/0.2*(PL-2)/PL))))-3*exp(1.5+log(PL))*PL-2*(exp(2+log(2/(1-0.6/0.4*(PL-2)/PL)))-exp(1.5+log(PL)))*2/(1-0.6/0.4*(PL-2)/PL)-(exp(2.5+log(2/(1-0.6/0.2*(PL-2)/PL)))-exp(2+log(2/(1-0.6/0.4*(PL-2)/PL))))*2/(1-0.6/0.2*(PL-2)/PL)');

% Tagrget 2 Version
f = sym('3*8+2*(exp(2+log(PL))+exp(2.5+log(2/(1-0.7/0.4*(PL-2)/PL)))+exp(3+log(2/(1-0.7/0.1*(PL-2)/PL))))-3*exp(2+log(PL))*PL-2*(exp(2.5+log(2/(1-0.7/0.4*(PL-2)/PL)))-exp(2+log(PL)))*2/(1-0.7/0.4*(PL-2)/PL)-(exp(3+log(2/(1-0.7/0.1*(PL-2)/PL)))-exp(2.5+log(2/(1-0.7/0.4*(PL-2)/PL))))*2/(1-0.7/0.1*(PL-2)/PL)');

PL = solve(f, 'PL')
PL = double(PL(2));
QL = exp(CL+log(PL));
QM = exp(CM+log(MC/(1-a/b*(PL-MC)/PL)));
QH = exp(CH+log(MC/(1-a/c*(PL-MC)/PL)));
PM = MC/(1-a/b*(PL-MC)/PL);
PH = MC/(1-a/c*(PL-MC)/PL);

% x1 = linspace(0, QL, 10000);
% x2 = linspace(QL, QM, 10000);
% x3 = linspace(QM, QH, 10000);
% plot(x1,PL);
% hold on
% plot(x2,PM);
% plot(x3,PH);

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


% grid on

hold off
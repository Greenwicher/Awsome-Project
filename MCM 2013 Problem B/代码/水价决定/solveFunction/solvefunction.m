

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
f = sym('30+2*(exp(1.5+log(PL))+exp(2+log(2/(1-0.6/0.4*(PL-2)/PL)))+exp(2.5+log(2/(1-0.6/0.2*(PL-2)/PL))))-3*PL*exp(1.5+log(PL))-2*(exp(2+log(2/(1-0.6/0.4*(PL-2)/PL)))-exp(1.5+log(PL)))*2/(1-0.6/0.4*(PL-2)/PL)');
PL = solve(f, 'PL')
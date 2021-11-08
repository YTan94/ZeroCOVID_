function xdot = Zero_s2_T(tn,x,par1,par2,c_d,c_s)

S=x(1); E=x(2); I1=x(3); A=x(4);  I2=x(5);  Qs=x(6); ...
    QE=x(7); QI=x(8); Id=x(9); H=x(10); R=x(11); D=x(12); Q=x(13);...
    Cum_Id=x(14); Cum_T=x(15); Cum_MId=x(16);




beta=par1(1);
c=par1(2);

b=par2(1);
tau_1=par2(2);
tau_2=par2(3);
a=par2(4);
gamma_A=par2(5);
T=par2(6);
T_Q=par2(7);
eta=par2(8);

alpha=1;

gamma_d=par2(10);
gamma_H=par2(11);
xi1=par2(12);
xi2=par2(13);
u1=par2(14);
u2=par2(15);
p_H=par2(16);
p_D=par2(17);

N=par1(3);

N_p=S+E+I1+A;

%Z_PCR=1/T*N;
Z_PCR=1/T*(N-Qs-QE-QI-Id-H-D-R-I2);

M_A=A/N_p*Z_PCR*eta*alpha;
M_I1=I1/N_p*Z_PCR*eta*alpha;
%M_I2=I2/N_p*Z_PCR*alpha;
M_I2=I2*1/2;



M_Id=M_A+M_I1+M_I2;


M_Q=eta*QI;



Z_s=M_Id*(c_d*(1-beta)+c_s*(1-beta^2));
Z_E=M_Id*(c_d*beta+c_s*beta^2)*tau_1/(tau_1+tau_2);
Z_I1=M_Id*(c_d*beta+c_s*beta^2)*tau_2*a/(tau_1+tau_2);
Z_A=M_Id*(c_d*beta+c_s*beta^2)*tau_2*(1-a)/(tau_1+tau_2);

Z_s=M_Id*(c_d*(1-beta));
Z_E=M_Id*(c_d*beta)*tau_1/(tau_1+tau_2);
Z_I1=M_Id*(c_d*beta)*tau_2*a/(tau_1+tau_2);
Z_A=M_Id*(c_d*beta)*tau_2*(1-a)/(tau_1+tau_2);


% if A-M_A<Z_A
%     Z_A=A-M_A;
% end
%     
% if I1-M_I1<Z_I1
%     Z_I1=I1-M_I1;
% end
%     
N_np=S+E+I1+A+I2;


xdot=[-beta*c*(I1+b*A+I2)*S/N_np-Z_s+1/T_Q*Qs; %S 1
    beta*c*(I1+b*A+I2)*S/N_np-1/tau_1*(E-Z_E)-Z_E;  %2 E
    a*1/tau_1*(E-Z_E)-1/tau_2*(I1-Z_I1-M_I1)-Z_I1-M_I1; %I1 3
    (1-a)*1/tau_1*(E-Z_E)-gamma_A*(A-Z_A-M_A)-Z_A-M_A;%A 4
    1/tau_2*(I1-Z_I1-M_I1)-M_I2;% I2 5
    Z_s-1/T_Q*Qs; %Qs 6
    Z_E-1/tau_1*QE; %Qe 7
    Z_I1+Z_A+1/tau_1*QE-M_Q; %QI 8
    M_I1+M_A+M_I2+M_Q-1/gamma_d*(1-p_H)*Id-xi1*p_H/u1*Id; %Id 9
    xi1*p_H/u1*Id-xi2*p_D/u2*H-(1-p_D)/gamma_H*H; %H 10
    gamma_A*(A-Z_A-M_A)+1/gamma_d*(1-p_H)*Id+(1-p_D)/gamma_H*H; %R 11
    xi2*p_D/u2*H; %D 12 %156
    Z_s+Z_E+Z_I1+Z_A+M_I1+M_A+M_I2;%Q 13
    M_I1+M_A+M_I2+M_Q;%Cum cases 14 %15087
    Z_s+Z_E+Z_I1+Z_A;%traced 15 %0
    M_I1+M_A+M_I2]; % new  tested 16 %0

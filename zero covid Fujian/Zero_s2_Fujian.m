function xdot = Zero_s2_Fujian(tn,x,par1,par2,c_d,c_s)

S=x(1); E=x(2); I1=x(3); A=x(4);  I2=x(5);  Qs=x(6); ...
    QE=x(7); QI=x(8); Id=x(9); H=x(10); R=x(11); D=x(12); Q=x(13);...
    Cum_Id=x(14); Cum_T=x(15); Cum_MId=x(16);

beta=par1(1);
c1=par1(2);
c2=par1(3);
alpha=1; %proportion of tranced
c_alpha=1;


c_d=c_alpha*(c2*2-2.676);
c_s=c_d*(c_d-1);



N=par2(1);
b=par2(2);
tau_1=par2(3);
tau_2=par2(4);
a=par2(5);
gamma_A=par2(6);
T=par2(7);
T_Q=par2(8);
eta=par2(9);
p_H=par2(10);
gamma_d=par2(11);
gamma_H=par2(12);
xi1=par2(13);
xi2=par2(14);
u1=par2(15);
u2=par2(16);
p_D=par2(17);
gamma_I2=par2(18);
alpha_2=par2(19); %proportion for testing


% if tn<12
%     alpha_2 =alpha2_stage1;
% else
%     alpha_2 =alpha2_stage2;
% end

N_p=S+E+I1+A;
Z_PCR=1/T*(N-Q-I2);
M_A=A/N_p*Z_PCR*eta*alpha;
M_I1=I1/N_p*Z_PCR*eta*alpha;


M_I2=I2*alpha_2/gamma_I2;

M_Id=M_A+M_I1+M_I2;


M_Q=eta*QI;
Z_s=M_Id*(c_d*(1-beta)+c_s*(1-beta^2));
Z_E=M_Id*(c_d*beta+c_s*beta^2)*tau_1/(tau_1+tau_2);
Z_I1=M_Id*(c_d*beta+c_s*beta^2)*tau_2*a/(tau_1+tau_2);
Z_A=M_Id*(c_d*beta+c_s*beta^2)*tau_2*(1-a)/(tau_1+tau_2);
% if A-M_A<Z_A
%     Z_A=A-M_A;
% end  
% if I1-M_I1<Z_I1
%     Z_I1=I1-M_I1;
% end

N_np=S+E+I1+A+I2;

xdot=[-beta*c2*(I1+b*A+I2)*S/N_np-Z_s+1/T_Q*Qs; %S 1
    beta*c2*(I1+b*A+I2)*S/N_np-1/tau_1*(E-Z_E)-Z_E;  %2 E
    a*1/tau_1*(E-Z_E)-1/tau_2*(I1-Z_I1-M_I1)-Z_I1-M_I1; %I1 3
    (1-a)*1/tau_1*(E-Z_E)-gamma_A*(A-Z_A-M_A)-Z_A-M_A;%A 4
    1/tau_2*(I1-Z_I1-M_I1)-M_I2;%Id I2 5
    Z_s-1/T_Q*Qs; %Qs 6
    Z_E-1/tau_1*QE; %Qe 7
    Z_I1+Z_A+1/tau_1*QE-M_Q; %QI 8
    M_I1+M_A+M_I2+M_Q-1/gamma_d*(1-p_H)*Id-xi1*p_H/u1*Id; %Id 9
    xi1*p_H/u1*Id-xi2*p_D/u2*H-(1-p_D)/gamma_H*H; %H 10
    gamma_A*(A-Z_A-M_A)+1/gamma_d*(1-p_H)*Id+(1-p_D)/gamma_H*H; %R 11
    xi2*p_D/u2*H; %D 12 
    Z_s+Z_E+Z_I1+Z_A+M_I1+M_A+M_I2;%Q 13
    M_I1+M_A+M_I2+M_Q;%Cum cases 14
    Z_s+Z_E+Z_I1+Z_A;%traced 15
    M_I1+M_A+M_I2]; % new  tested 16


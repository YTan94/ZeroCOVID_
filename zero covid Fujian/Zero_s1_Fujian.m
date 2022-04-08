function xdot = Zero_s1_Fujian(tn,x,par1,par2)

S=x(1); E=x(2); I1=x(3); A=x(4);  I2=x(5);  R=x(6); 

beta=par1(1);
c1=par1(2);
c2=par1(3);
alpha=1;
c_alpha=1;


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
alpha_2=par2(19);

xdot=[-beta*c1*(I1+b*A+I2)*S/N; %S 1
    beta*c1*(I1+b*A+I2)*S/N-1/tau_1*E;  %2
    a*1/tau_1*E-1/tau_2*I1; %I1 3
    (1-a)*1/tau_1*E-gamma_A*A;%A 4
    1\tau_2*I1;%Id I2
    gamma_A*A];%R 6
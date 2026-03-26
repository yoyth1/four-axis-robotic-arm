 syms x1 x2 x3 x4 x5 a1 a2 a3 a4 a5;
 syms nx  ox ax px ny oy ay py nz oz  az pz;

A=[nx, ox, ax,px;ny, oy, ay,py;nz, oz, az,pz;0,  0,  0,  1];

%  
%  
%  x1=50*pi/180;
%  x2=60*pi/180;
%  x3=70*pi/180;
%  x4=80*pi/180;
%  x5=90*pi/180;

 x1=20*pi/180-90*pi/180;
 x2=30*pi/180-90*pi/180;
 x3=40*pi/180+75*pi/180;
 x4=50*pi/180+105*pi/180;
 x5=60*pi/180-90*pi/180;

 a1=29;
 a2=150;
 a3=134.6;
 a4=0;
 a5=0;

 T1 = [cos(x1),    0,      -sin(x1),         a1*cos(x1);
       sin(x1),    0,       cos(x1),         a1*sin(x1);
       0,         -1,         0,             0;
       0,          0,         0,             1];
   
 T2 = [cos(x2),    -sin(x2),       0,        a2*cos(x2);
       sin(x2),     cos(x2),       0,        a2*sin(x2);
       0,          0,         1,             0;
       0,          0,         0,             1];
      
 T3 = [cos(x3),    -sin(x3),       0,        a3*cos(x3);
       sin(x3),     cos(x3),       0,        a3*sin(x3);
       0,          0,         1,             0;
       0,          0,         0,             1];
   
 T4 = [cos(x4),    0,        sin(x4),        0;
       sin(x4),    0,       -cos(x4),        0;
       0,          1,         0,             0;
       0,          0,         0,             1];
       
   
%  T5 = [1,          0,         0,         0;
%        0,           1,         0,        0;
%        0,          0,         1,         80;
%        0,          0,         0,         1];
 T5 = [cos(x5),    0,        sin(x5),        0;
       sin(x5),    0,       -cos(x5),        0;
       0,          1,         0,             80;
       0,          0,         0,             1];
   
   
   
T14=T1*T2*T3*T4;
%    -1         0         0         0
%          0   -0.7660    0.6428    -220.3
%          0    0.6428    0.7660     236.3
%          0         0         0         1
   
   
   
 i_T5=inv(T5);
 i_T1=inv(T1);
 i_T4=inv(T4);
 i_T2=inv(T2);
 i_T3=inv(T3);
 
% 
% simplify(T1*T2*T3*T4)
% simplify(A*i_T5)
 
% simplify(T1*T2*T3*T4*T5)

T=T1*T2*T3*T4*T5


% simplify(T2*T3*T4)       化简矩阵  






% 求方程组解
%  


% 
% eq1=cos(x1)*(a1 + a3*cos(x2 + x3) + a2*cos(x2))==px - 80*ox;
% eq2=sin(x1)*(a1 + a3*cos(x2 + x3) + a2*cos(x2))==py - 80*oy;
% eq3= - a3*sin(x2 + x3) - a2*sin(x2)==pz - 80*oz;
% eq4= oz== cos(x2 + x3 + x4);
% eq5=nz*sin(x5) - az*cos(x5)==0;
% [a,b,c,d,e]=solve(eq1,eq2,eq3,eq4,eq5,[x1,x2,x3,x4,x5])



%  eq5=nz*tan(x5) - az==0;
%  e=solve(eq5,tan(x5))
%  



%  eq1=cos(x1)*(a1 + a3*cos(x2 + x3) + a2*cos(x2))==px - 80*ox;
%  eq2=sin(x1)*(a1 + a3*cos(x2 + x3) + a2*cos(x2))==py - 80*oy;
% solve(eq2,eq1,[x1])
% simplify(solve(eq2,eq1,[x1]))


% eq2=sin(x1)*(a1 + a3*cos(x2 + x3) + a2*cos(x2))==py - 80*oy;
% eq3= - a3*sin(x2 + x3) - a2*sin(x2)==pz - 80*oz;
% [b,c]=solve(eq2,eq3,[x2,x3]);
% simplify([b,c])
% 
% 
% x1=0.1;
%  px=25.34;
%  py=253.5;
%  pz=133.9;
%  oy=-0.9506;
%  oz=-0.2955;
%  a1=29;
%  a2=150;
%  a3=134.6;
% [ 2*atan((((160*oy*py - a1^2*sin(x1)^2 + a2^2*sin(x1)^2 + a3^2*sin(x1)^2 - 6400*oz^2*sin(x1)^2 - pz^2*sin(x1)^2 - 6400*oy^2 - py^2 - 160*a1*oy*sin(x1) + 2*a1*py*sin(x1) + 2*a2*a3*sin(x1)^2 + 160*oz*pz*sin(x1)^2)*(a1^2*sin(x1)^2 - 160*oy*py - a2^2*sin(x1)^2 - a3^2*sin(x1)^2 + 6400*oz^2*sin(x1)^2 + pz^2*sin(x1)^2 + 6400*oy^2 + py^2 + 160*a1*oy*sin(x1) - 2*a1*py*sin(x1) + 2*a2*a3*sin(x1)^2 - 160*oz*pz*sin(x1)^2))^(1/2) + 160*a2*oz*sin(x1)^2 - 2*a2*pz*sin(x1)^2)/(a1^2*sin(x1)^2 - 160*oy*py + a2^2*sin(x1)^2 - a3^2*sin(x1)^2 + 6400*oz^2*sin(x1)^2 + pz^2*sin(x1)^2 + 6400*oy^2 + py^2 + 160*a1*oy*sin(x1) - 160*a2*oy*sin(x1) - 2*a1*py*sin(x1) + 2*a2*py*sin(x1) - 2*a1*a2*sin(x1)^2 - 160*oz*pz*sin(x1)^2)), -2*atan(((160*oy*py - a1^2*sin(x1)^2 + a2^2*sin(x1)^2 + a3^2*sin(x1)^2 - 6400*oz^2*sin(x1)^2 - pz^2*sin(x1)^2 - 6400*oy^2 - py^2 - 160*a1*oy*sin(x1) + 2*a1*py*sin(x1) + 2*a2*a3*sin(x1)^2 + 160*oz*pz*sin(x1)^2)*(a1^2*sin(x1)^2 - 160*oy*py - a2^2*sin(x1)^2 - a3^2*sin(x1)^2 + 6400*oz^2*sin(x1)^2 + pz^2*sin(x1)^2 + 6400*oy^2 + py^2 + 160*a1*oy*sin(x1) - 2*a1*py*sin(x1) + 2*a2*a3*sin(x1)^2 - 160*oz*pz*sin(x1)^2))^(1/2)/(a1^2*sin(x1)^2 - 160*oy*py - a2^2*sin(x1)^2 - a3^2*sin(x1)^2 + 6400*oz^2*sin(x1)^2 + pz^2*sin(x1)^2 + 6400*oy^2 + py^2 + 160*a1*oy*sin(x1) - 2*a1*py*sin(x1) + 2*a2*a3*sin(x1)^2 - 160*oz*pz*sin(x1)^2))]
% [-2*atan((((160*oy*py - a1^2*sin(x1)^2 + a2^2*sin(x1)^2 + a3^2*sin(x1)^2 - 6400*oz^2*sin(x1)^2 - pz^2*sin(x1)^2 - 6400*oy^2 - py^2 - 160*a1*oy*sin(x1) + 2*a1*py*sin(x1) + 2*a2*a3*sin(x1)^2 + 160*oz*pz*sin(x1)^2)*(a1^2*sin(x1)^2 - 160*oy*py - a2^2*sin(x1)^2 - a3^2*sin(x1)^2 + 6400*oz^2*sin(x1)^2 + pz^2*sin(x1)^2 + 6400*oy^2 + py^2 + 160*a1*oy*sin(x1) - 2*a1*py*sin(x1) + 2*a2*a3*sin(x1)^2 - 160*oz*pz*sin(x1)^2))^(1/2) - 160*a2*oz*sin(x1)^2 + 2*a2*pz*sin(x1)^2)/(a1^2*sin(x1)^2 - 160*oy*py + a2^2*sin(x1)^2 - a3^2*sin(x1)^2 + 6400*oz^2*sin(x1)^2 + pz^2*sin(x1)^2 + 6400*oy^2 + py^2 + 160*a1*oy*sin(x1) - 160*a2*oy*sin(x1) - 2*a1*py*sin(x1) + 2*a2*py*sin(x1) - 2*a1*a2*sin(x1)^2 - 160*oz*pz*sin(x1)^2)),  2*atan(((160*oy*py - a1^2*sin(x1)^2 + a2^2*sin(x1)^2 + a3^2*sin(x1)^2 - 6400*oz^2*sin(x1)^2 - pz^2*sin(x1)^2 - 6400*oy^2 - py^2 - 160*a1*oy*sin(x1) + 2*a1*py*sin(x1) + 2*a2*a3*sin(x1)^2 + 160*oz*pz*sin(x1)^2)*(a1^2*sin(x1)^2 - 160*oy*py - a2^2*sin(x1)^2 - a3^2*sin(x1)^2 + 6400*oz^2*sin(x1)^2 + pz^2*sin(x1)^2 + 6400*oy^2 + py^2 + 160*a1*oy*sin(x1) - 2*a1*py*sin(x1) + 2*a2*a3*sin(x1)^2 - 160*oz*pz*sin(x1)^2))^(1/2)/(a1^2*sin(x1)^2 - 160*oy*py - a2^2*sin(x1)^2 - a3^2*sin(x1)^2 + 6400*oz^2*sin(x1)^2 + pz^2*sin(x1)^2 + 6400*oy^2 + py^2 + 160*a1*oy*sin(x1) - 2*a1*py*sin(x1) + 2*a2*a3*sin(x1)^2 - 160*oz*pz*sin(x1)^2))]
 
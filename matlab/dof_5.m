clear;
clc;
                     %定义机械臂连杆参数
L(1) = Link('revolute', 'd', 0, 'a', 29,    'alpha', -pi/2,   'offset',-pi/2,     'qlim',[-180,180]/180*pi);
L(2) = Link('revolute', 'd', 0, 'a', 150,   'alpha', 0,       'offset',-pi/2,     'qlim',[-40,110]/180*pi);
L(3) = Link('revolute', 'd', 0, 'a', 134.6, 'alpha', 0,       'offset',75*pi/180, 'qlim',[-90,90]/180*pi);
L(4) = Link('revolute', 'd', 0, 'a', 0, 'alpha',90*pi/180,'offset',105*pi/180,'qlim',[-90,90]/180*pi);         
L(5) = Link('revolute', 'd',80, 'a', 0,     'alpha',90*pi/180,'offset',-90*pi/180,'qlim',[-150,150]/180*pi);




bot = SerialLink(L, 'name', '5-dof'); %将机械臂杆件串联起来
% bot.base = transl(0,0,0); %世界坐标系定为（0，0，1）
% bot.display();            %查看D-H参数
% bot.teach ;               %示教
%               %正逆运动学验证
% T1 = bot.fkine([20*pi/180 30*pi/180 40*pi/180 50*pi/180 60*pi/180])%给关节赋一组值
% q1 = bot.ikine(T1,'mask',[1 1 1 1 1 0]);                         
% bot.plot(q2);


              %工作空间分析
num = 5000;     %定义循环次数 
p = zeros(num,3);%先声明0矩阵可加快运行速度
for i=1:num      %关节变量随机赋值
    q1 = L(1).qlim(1) + rand * (L(1).qlim(2) - L(1).qlim(1));
    q2 = L(2).qlim(1) + rand * (L(2).qlim(2) - L(2).qlim(1));
    q3 = L(3).qlim(1) + rand * (L(3).qlim(2) - L(3).qlim(1));
    q4 = L(4).qlim(1) + rand * (L(4).qlim(2) - L(4).qlim(1));
    q5 = L(5).qlim(1) + rand * (L(5).qlim(2) - L(5).qlim(1));
    q = [q1 q2 q3 q4 q5];
    T = bot.fkine(q);   % SerialLink.fkine正向运动学
    P(i,:) = transl(T); %记录该组关节变量对于的空间位置 
end


plot3( P(:,1), P(:,2), P(:,3),'b.','markersize',1); %在三维空间内绘制50000个点
hold on;        %添加新绘图的时候保留当前绘图
grid on;        %在画图的时候添加网格线
view([45 45]);  %视图














bot.plot([0 0 0 0 0]);



% 
%            %正 逆 运动学           
% q = [0 1 0 1 ];
% T1 = bot.fkine(q);  %初始位置
% % pause      %  暂停   等待响应
% q2 = bot.ikine(T1,'mask',[1 1 1 1 1 0])   %当反解的机器人对象的自由度少于6时，要用mask vector进行忽略某个关节自由度
% bot.plot(q2);
% 




% q = [0*pi/180 0*pi/180 0*pi/180 0*pi/180 0*pi/180];  %初始关节角为4
% T1 = bot.fkine(q)


% T2 = transl(0,0,1840);  %变换位置
% q1 = bot.ikunc(T1);
% q2 = bot.ikunc(T2);
% pause  %按下空格后继续运行
% bot.plot(q1);L(1) = Link('standard','d', 100, 'a', 0, 'alpha', pi/2,'offset',0,'qlim',[0,0]/180*pi);
% 


% L(1)=Link([-pi/2,0,29,-pi/2,0])
% L(2)=Link([-pi/2,0,150,0,0])
% L(3)=Link([75*pi/360,0,134.6,0,0])
% L(4)=Link([25,0,80,0,0])


% L(1)=Link([pi/2,0,0,pi/2,0])
% L(2)=Link([0,100,0,-pi/2,1])
% L(3)=Link([0,0,0,pi/2,0])
% L(4)=Link([0,30,0,0,0])


%                运动仿真
% T1 = [0,0,0,0,0];
% T2 = [pi,pi/4,pi/4,pi/3,pi/3];
% step = 50;    %插入一秒50次
% [q,qd,qdd] = jtraj(T1,T2,step); %五次多项式关节空间轨迹规划
% 
% bot.plot(q,'trail','b');  %运行后在命令行窗口再复制运行一次，trail轨迹，b蓝色0个值
% bot.plot(q,'trail','b');  %运行后在命令行窗口再复制运行一次，trail轨迹，b蓝色0个值
% plot(q,qd,qdd)

set(0,'DefaultFigureWindowStyle','docked')
set(0,'defaultaxesfontsize',20)
set(0,'defaultaxesfontname','Times New Roman')
set(0,'DefaultLineLineWidth',2)

clear all;
close all;

x=0;
v=0;
t=0;

%declare variables for F=ma and 5 percent chance aand other useful
%variables
m=1;
F=1;
dt=1;
nt=1000;
np=1;
re=0;

%tau is 2 percent of the time (1000 steps)
ta=1000*0.02;

%to find the percent use the equation p=1-e^(t/ta)
p=1-exp(-dt/ta);

%create vectors for x and v
x=zeros(np,1);
v=zeros(np,1);

%loop to calculate values and create and update plot
for i=2:nt
    
    %have to calculate v and x
    %to calculate time take the time at the point of i and derive t (dt)
    t(i)=t(i-1)+dt;
    %to find v take the old position of the electron and add the new value,
    %F=m*(dv/dt)
    v(:,i) = v(:,i-1) + F/m * dt;
    %to find x take the value at the old i apply velocity and the integral
    %of F/m*dt with respect to t, this gets the additional distance added
    %on
    x(:,i) = x(:,i-1) + (v(:,i-1)*dt) + (F/m * dt^2 * 1/2);
    
    r=rand(np,1)<p;
    v(r,i)=re*v(r,i);
    avg_v(i,:)=mean(v,2);
    
    %Create the plots
    subplot(3,1,1)
    plot(t,v,'-')
    hold on
    subplot(3,1,1)
    plot(t,avg_v,'g*');
    hold off
    xlabel('Time')
    ylabel('Velocity')
    title(['Average Velocity:' num2str(avg_v(i))])
    
    subplot(3,1,2)
    plot(x(1,:),v(1,:),'r-');
    hold on
    subplot(3,1,2)
    plot(x(1,:),avg_v(1,:),'g*');
    hold off
    xlabel('x')
    ylabel('v')    

    subplot(3,1,3)
    plot(t,x,'-');
    xlabel('time')
    ylabel('x')
    
    pause(0.01)
end

display('Average V')
mean(v)
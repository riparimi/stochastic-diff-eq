% Euler-Maruyama method for a SARS epidemic model
% dx = lambda*(x*(n-x))dt + mu*x dW, x(1)=x1
%
% KC Ang (April 2007)

function [X]=sars1(mu,Paths)
x1=2; % initial value (from data)
n=208455; % final value (from data)
lambda = 0.005; % set parameter values
T = 1; R = 2^10; N = 111*R;
dt = T/N; Dt = R*dt; L = N/R;
X = zeros(1,L); % initialize solution vector
for i = 1:Paths
x = zeros(1,L);
xt = x1;
randn('state',sum(i*clock)); % vary state
dW = sqrt(dt)*randn(1,N); % Brownian increments
for j = 1:L
winc = sum(dW((j-1)*R+1:j*R));
xt = xt + lambda*xt*(n-xt)*Dt + mu*g(xt)*winc;
x(j)=xt;
end
if sum(x)>0
if i == 1
X = x;
else
X = (X+x)/2;
end
end
end

% real data
covid_ny = readtable('data-yqfdF.csv');
covid_cases_ny = table2array(covid_ny(:,2));
covid_sum = cumsum(covid_cases_ny);

plot(covid_sum,'rx','LineWidth',2);
hold on
X=[x1,X]
plot(X,'b-','LineWidth',2);
hold off
xlabel('t (days)','FontSize',12);
ylabel('No of infected persons','FontSize',12,'Rotation',90);
title('COVID epidemic with g(x)=x','FontSize',12);
text(5,215,'Data x','Color','r','FontWeight','bold');
text(5,200,'Model --','Color','b','FontWeight','bold');
%
err=0.0;
for i=1:70
err=err+(X(i)-covid_sum(i))^2;
end
err=sqrt(err)/70;
fprintf('Average Error = %10.6f \n',err);
% -------------------------------------------------------------
% function g
function y = g(x)
y=x;
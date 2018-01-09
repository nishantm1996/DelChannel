function [] = plotcap_fast ()
C = zeros(1,10);
%Cavg = zeros(1,100);
for N=1:1;
count = 0;
for i=0.01:0.01:1
    count = count + 1;
    C(N,count) = 2*delcap_fast(50,i)./(50);
end
end
% for j=1:10
%     Cavg(j) = (C(1,j)+C(2,j)+C(3,j)+C(4,j))/4;
% end
x = 0.01:0.01:1;
y1 = (1-x)./9;
for N=1:1
plot(x,C(N,:)); hold on;
end
plot(x,y1); hold on;
%plot(x,Cavg(:));
grid on;
end

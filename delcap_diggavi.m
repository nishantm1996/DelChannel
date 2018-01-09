p = 0.1:0.1:1; d = 0:0.005:0.5;
x = 0:0.01:5e2;
C = zeros(numel(p),numel(d)); Cub = zeros(1,numel(d)); Cdc = zeros(1,numel(d));
for j=1:numel(p)
for i=1:numel(d)
q = 1-(1-p(j))/(1-d(i)*(2*p(j)-1));
phiNa = p(j).*exp(-x) + ((1-p(j)).^2).*exp(-2.*x)./(1-p(j).*exp(-x));
phiNb = (1-p(j)).*exp(-x)./(1-p(j).*exp(-x));
R = -x./log(2) - (1-d(i)).*log2(phiNb.*(1-q) + phiNa.*q);
C(j,i) = max(R);
end
end
for i=1:numel(d)
    Cub(i) = max(C(:,i));
    Cdc(i) = delcap_fast(50,i)./(50);
end
plot(d,Cub,'-*r'); grid on; hold on; plot(d,1-d,'-b'); plot(d,Cub,'k');
plot(d,(1-d)./9,'-.g'); plot(d,1+d.*log2(d)+(1-d).*log2(1-d),'-om');
legend('Markov Union Bound (LB)','BEC (UB)','Blahut Arimoto','Drinea (LB)','BSC = IID = Markov, p = 0.5 (LB)');
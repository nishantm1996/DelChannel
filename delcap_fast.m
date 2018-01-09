function C = delcap_fast (N,d)
P = 0.0001*ones(N,N+1);
% Pxgy = zeros(N,N+1);
Pxgy = zeros(N,N);
Px = 0.001*ones(1,N);
Px(N) = 1-0.001*(N-1);
for i=1:(N)
    for j=1:(i+1)
        P(i,j) = nchoosek(i,j-1)*(d^(i-j+1))*((1-d)^(j-1));
    end
end
P(:,2) = P(:,2) + P(:,1);
P = P(:,2:N+1);
Py = Px*P;
for i=1:(N)
    for j=1:(N)
        Pxgy(i,j) = (P(i,j).*Px(i))./Py(j);
    end
end
[rowsize,colsize] = size(P);
% C = blahut_arimoto(P,rowsize,colsize,Pxgy,0.001);
C = BlahutArimoto(P,d);
end
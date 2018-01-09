function C = bsc_fast (d)
P = [(1-d) d;d (1-d)];
Pxgy = zeros(2,2);
Px = [0.001 0.999];
Py = Px*P;
for i=1:2
    for j=1:2
        Pxgy(i,j) = (P(i,j).*Px(i))./Py(j);
    end
end
[rowsize,colsize] = size(P);
C = blahut_arimoto(P,rowsize,colsize,Pxgy,0.001);
% C = BlahutArimoto(P);
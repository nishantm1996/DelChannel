function [C r] = BlahutArimoto(p,d)
if ~isempty(find(p < 0))
%     disp('Error: some entry in the input matrix is negative')
    C = 0; return;
end

% Check that the input matrix p does not have zero column
column_sum = sum(p);
if ~isempty(find(column_sum == 0))
%     disp('Error: there is a zero column in the input matrix');
    C = 0; return;
end

% Check that the input matrix p does not have zero row
row_sum = sum(p,2);
if ~isempty(find(row_sum == 0))
%     disp('Error: there is a zero row in the input matrix');
    C = 0; return;
else
    p = diag(sum(p,2))^(-1) * p; % Make sure that the row sums are 1
end

[m n] = size(p);

r = ones(1,m)/m; % initial distribution for channel input
q = zeros(m,n);
error_tolerance = 1e-5/m;
r1 = [];
for i = 1:m
    p(i,:) = p(i,:)/sum(p(i,:));
end
for iter = 1:10000
    for j = 1:n
        q(:,j) = r'.*p(:,j);
        q(:,j) = q(:,j)/sum(q(:,j));
    end

    for i = 1:m
        r1(i) = prod(q(i,:).^p(i,:));
    end

    r1 = r1/sum(r1);
    if norm(r1 - r) < error_tolerance
        break
    else
        r = r1;
    end
end

C = 0;
for i = 1:m
    for j = 1:n
        if r(i) > 0 && q(i,j) > 0
            C = C+ r(i)*p(i,j)* log(q(i,j)/r(i));
        end
    end
end

C = C/log(2); % Capacity in bits
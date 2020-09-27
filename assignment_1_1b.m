%Creates n=10 random lines in 2D space less than a distance of 1 from the origin
%and finds point minimizing sum of squared distances.

n = 10; %number of lines

nhat = unifrnd(-1,1,2,n);
nhat = nhat./repmat(sqrt(sum(nhat(1:2,:).^2)),2,1); %make unit length
d = unifrnd(-1,1,1,n); %constrain distance from origin to be less than 1
L = [nhat;d];

%scale normalized lines back to homogeneous lines with random scale
w = repmat(unifrnd(-10,10,1,n),3,1); 
L = w.*L;

%Solve for least squares point x
x = LSPointLines(L);

%Display results on [-1 1] x [-1 1]
figure;
for i = 1:n
    nhati = nhat(:,i);
    di = d(i);
    x1 = (-di+nhati(2))/nhati(1);
    x2 = (-di-nhati(2))/nhati(1);
    y1 = (-di+nhati(1))/nhati(2);
    y2 = (-di-nhati(1))/nhati(2);
    
    xep = [];yep=[];
    if abs(x1)<1
        xep = [xep;x1];
        yep = [yep;-1];
    end
    if abs(x2)<1
        xep = [xep;x2];
        yep = [yep;1];
    end
    if abs(y1)<1
        xep = [xep;-1];
        yep = [yep;y1];
    end
    if abs(y2)<1
        xep = [xep;1];
        yep = [yep;y2];
    end
    
    line(xep,yep);
    hold on;
end

plot(x(1),x(2),'.','MarkerSize',18);
set(gca,'XAxisLocation','origin');
set(gca,'YAxisLocation','origin');
xlabel('x');
ylabel('y');
set(gca,'FontSize',12);

function x=LSPointLines(L)
    LL = repmat(L, 1);
    n = size(LL, 2);
    for i = 1:n 
        %converts to augmented
        LL(:, i) = LL(:, i)./LL(3, i);
        %normalize the vectors
        LL(:, i) = LL(:, i)./sqrt(LL(1, i)^2 + LL(2, i)^2);
    end
    sum1 = 0;
    for i = 1:n %perform the first summation
        sum1 = sum1 + (LL(1:2, i)*LL(1:2, i)');
    end
    sum2 = 0;
    for i = 1:n
        sum2 = sum2 + (((-1).*LL(3, i))*LL(1:2, i));
    end
    x = (sum1 \ sum2);
end
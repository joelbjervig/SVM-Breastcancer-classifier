clear all;
close all;
clc
T = readtable('wdbc.dat');

% Description of data
% 	a) radius (mean of distances from center to points on the perimeter)
% 	b) texture (standard deviation of gray-scale values)
% 	c) perimeter
% 	d) area
% 	e) smoothness (local variation in radius lengths)
% 	f) compactness (perimeter^2 / area - 1.0)
% 	g) concavity (severity of concave portions of the contour)
% 	h) concave points (number of concave portions of the contour)
% 	i) symmetry 
% 	j) fractal dimension ("coastline approximation" - 1)


% 1. Define auxiliary matrices for general nonseperable
m = height(T)-69;   % number of datapoints: 4. use the first 500 datapoints
n = width(T)-2;     % number of features in the dataset

BorM = zeros(height(T),1);  % binary classes: Benign or Malignent
xi3 = zeros(m,n);    % define matrix for all data (i.e. multidimentional cooridnates)

% data2array
A = table2cell(T);

xi = A(:,3:end);
% for j=1:length(BorM)
%     for k=1:width(xi)
%         xi(j,k+2)= T(j,k+2);
% 
%     end
% end

% store binaries in class vector
for i=1:length(BorM) 
    if T{i,2}=="M"
        BorM(i)=1;
    else % if its not malignent, its benign
        BorM(i)=-1;
    end
end


X_train = cell2mat(xi(1:500,:));    % datapoints trainingdata
y_train = BorM(1:500,:);            % corresponding class for datapoints
X_test = cell2mat(xi(501:end,:));   % testdata is the remaining 69 datapoints
y_test = BorM(501:end,:);           % corresponding class for datapoints
%c=100;
accuracy = zeros(1,1000/100);



H = diag([zeros(1,1),ones(1, n), zeros(1, m)]);
A = [-y_train.*ones(m,1), -diag(y_train)*X_train, -eye(m)];
lb = [-inf*ones(n+1,1); zeros(m,1)];    % lower bound
ub = [inf*ones(n+1+m,1)];               % upper bound

for c=100:100:1000
 
f = [zeros(1,n+1), c*ones(1, m)];
b = -ones(m,1);

%Quadratic programming matrices

%Finding variables with quadprog
train_vars=quadprog(H,f,A,b,[],[],lb,ub);

y_pred = zeros(69,1);
result = y_pred;
w = train_vars(2:31);
b = train_vars(1);
%epsilon = train_vars(32:531);

for i=1:length(X_test)-1
    y_pred(i) = transpose(w)*transpose(X_test(i,:))+b;
    if y_pred(i) >= 1
        y_pred(i) = 1;
    elseif y_pred(i) <= -1
        y_pred(i) = -1;
    end
    
    if y_pred(i)-y_test(i) == 0
        result(i) = 1;
    else
        result(i) = 0;
    end
    
end



TP = 0;
TOT_p = 0;
TN = 0;
TOT_n = 0;

for i=1:length(y_pred)-1
    if y_test(i) == 1
        TOT_p = TOT_p+1;
        if y_pred(i) == 1
            TP = TP + 1;
        end
    else
        TOT_n = TOT_n+1;
        if y_pred(i) == -1
            TN = TN + 1;
        end
    end
    
end


    


sensitivity(c/100) = TP/TOT_p;
specificity(c/100) = TN/TOT_n;

accuracy(c/100) = sum(result)/length(result);


end

plot([100:100:1000], accuracy, [100:100:1000], sensitivity, [100:100:1000], specificity)



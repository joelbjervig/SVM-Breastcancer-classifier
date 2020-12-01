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

BorM = zeros(m,1);  % biary classes: Benign or Malignent
xi3 = zeros(m,n);    % define matric for all data (i.e. multidimentional cooridnates)

% data2array
A = table2array(T);
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
    
    elseif T{i,2}=="B"
        BorM(i)=-1;
    end
end


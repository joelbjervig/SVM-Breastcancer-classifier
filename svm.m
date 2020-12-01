T = readtable('wdbc.dat');
%BorM = zeros(500,1);

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
BorM = zeros(500,1); % Benign or Malignent classifier


for i=1:length(BorM)
    
    
    if T{i,2}=="M"
        BorM(i)=1;
    
    elseif T{i,2}=="B"
        BorM(i)=-1;
    end
end

% %data2array
% A = table2array(T);
A1 = table2cell(T(1:500,3:32));
% xi = zeros(500,30);
% 
% 
% for f=1:30
%     for h=1:500
%         xi(h,f)=A1{h,f};
%     end
% end

xi = cell2mat(A1);


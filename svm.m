T = readtable('wdbc.dat');
BorM = zeros(height(T),1);

for i=1:length(BorM)
    
    
    if T{i,2}=="M"
        BorM(i)=1;
    
    elseif T{i,2}=="B"
        BorM(i)=-1;
    end
end


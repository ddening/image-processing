function [K] = binarize(I, S1, S2)
if nargin < 3
    multi=false;
else
    multi=true;
end

GM = [0, 255];

[row, col] = size(I);

i=1;
j=1;
K = zeros(row, col);

for r=1:row
    for c=1:col
        if multi == true
            if I(i,j) < S1 || I(i,j) < S2
            K(i,j) = GM(2);
            
            else
                K(i,j) = GM(1);
            end
        else
            if I(i,j) > S1
                K(i,j) = GM(1);
            else
                K(i,j) = GM(2);
            end
        end
        j = j+1;
    end
    i=i+1;
    j=1;
end

end


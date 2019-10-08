function [ hash_vector ] = CalculateHashVector( img, blocking, row_cut, column_cut, Q )
% calculate the hash vector by the blocking. The vector is encoded.
% 

len = max(max(blocking));

sum = double(zeros(1, len));
cnt = double(zeros(1, len));
[n, m] = size(img);

for i = 1 : length(row_cut)
    for j = 1 : length(column_cut)
        
        % u, d, l, r
        if i == 1
            u = 1;
        else
            u = row_cut(i-1) + 1;
        end
        d = row_cut(i);
        if j == 1
            l = 1;
        else
            l = column_cut(j-1) + 1;
        end
        r = column_cut(j);
        
        for x = u : d
            for y = l : r
                sum(blocking(i, j)) = sum(blocking(i, j)) + double(img(x, y));
                cnt(blocking(i, j)) = cnt(blocking(i, j)) + 1;
            end
        end
    end
end

%hash_vector = uint8(zeros(1, len));
hash_vector = [];h1=0;h=0;
for i = 1 : len
%     hash_vector(i) = GrayCode(uint8(floor(sum(i) / cnt(i) /16)));
h1 = GrayCode(uint8(floor(sum(i) / cnt(i) /Q)));
     k = log2(Q);
	 k = 8-k;
	 H = [];
	% hash_vector(i) = GrayCode(uint8((sum(i) / cnt(i) /32)));
	h =dec2bin(h1,k);
	for j = 1:length(h)
	hi = str2num(h(j));
	H = [H,hi];
    end
    hash_vector = [hash_vector,H];
end

end

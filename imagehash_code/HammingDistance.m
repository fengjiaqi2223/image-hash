function [ distance ] = HammingDistance( a, b )
% Calculate the Hamming distance of two input vectors.

distance = 0;
%for i = 1 : length(a)
 %  c = bitxor(a(i), b(i));
  % for j = 1 : 8
   %    if bitget(c, j) == 1
    %       distance = distance + 1;
     %  end
  % end
%end
c = bitxor(a, b);
for i = 1 : length(a)
  % c = bitxor(a(i), b(i));
   %for j = 1:length()
   if c (i) == 1
        distance = distance + 1;
   end
end
end
   
  

function [ y ] = GrayCode( x )
% calculate the gray code of the uint8 input.

y = uint8(0);

for i = 8 : -1 : 1
    if bitget(x, i) == 1
        y = bitset(y, i);
        x = x - bitset(0, i);
        x = bitset(0, i) - x - 1;
    end
end

function [ colored_blocking ] = showBlocking(blocking, row_cut, column_cut)
% Input: display the blocking related to a image's cutting, the size of
% blocking should be equal to the size of row_cut and column_cut.

colored_blocking = uint8(zeros(max(row_cut), max(column_cut), 3));

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
        
        color_id = mod(int32(blocking(i, j)), 256);
        color_a = mod(color_id * (color_id + 101), 256);
        color_b = mod(color_a * (color_id + 202), 256);
        color_c = mod(color_b * (color_id + 303), 256);
        
        for x = u : d
            for y = l : r
                colored_blocking(x, y, 1) = color_a;
                colored_blocking(x, y, 2) = color_b;
                colored_blocking(x, y ,3) = color_c;
            end
        end
    end
end
end


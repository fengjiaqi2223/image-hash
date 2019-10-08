function [ row_cut, column_cut ] = ProduceGrid(n, m, grid_n, grid_m, max_disturbance)
% Input: the size of a image and the size of grid, eg grid_n = grid_m = 16. 
% Return: the row and column cut related to the image.

% MOD, u, d, l, r, Magic


dx = int32(n / grid_n);
dy = int32(m / grid_m);

row_cut = int32(dx:dx:n);
for i = 1: (n / dx - 1)
    row_cut(i) = row_cut(i) + int32((rand() * 2 - 1) * max_disturbance);
end

column_cut = int32(dy:dy:m);
for i = 1 : (m / dy - 1)
    column_cut(i) = column_cut(i) + int32((rand() * 2 - 1) * max_disturbance);
end
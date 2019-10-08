function [ blocking ] = ProduceBlocking(n, m, row_cut, column_cut, block_number, T)
% Input: the size of grid, and the number of blocks and the threshold T, 
%        the bigger T is, the bigger a single block is.
% Return: a n*m matrix, where (i, j) indicate the block this grid belongs
% to. 0 <= (i, j) < block_number

rand('state',5);
randset = rand(1,1000);
set_number =1;
blocking = int32(ones(n, m) * -1);

block_id = int32(0);

dir_x = int32([1, 0, -1, 0]);
dir_y = int32([0, 1, 0, -1]);

que_x = int32(zeros(1, n*m));
que_y = int32(zeros(1, n*m));

for i = 1 : m
    for j = 1 : n
        % non-colored grid
        if blocking(i, j) == -1
            
            if block_id == block_number  % got enough blocks already
                for dir = 1 : 4
                    x = i + dir_x(dir);
                    y = j + dir_y(dir);
                    if x >= 1 && x <= n && y >= 1 && y <= m && blocking(x, y) ~= -1
                        blocking(i, j) = blocking(x, y);
                        break;
                    end
                end
            else  % extend a new block
                block_id = block_id + 1;
                que_x(1) = i;
                que_y(1) = j;
                head = int32(1);
                tail = int32(2);
                while head < tail
                    x = que_x(head);
                    y = que_y(head);
                    blocking(x, y) = block_id;
                    head = head + 1;
                    for dir = 1 : 4
                        nx = x + dir_x(dir);
                        ny = y + dir_y(dir);
						set_number=mod(set_number+1,1000)+1;
						r=randset(set_number);
                        if nx >= 1 && nx <= n && ny >= 1 && ny <= m ...
                          && blocking(nx, ny) == -1 && r < T
                            que_x(tail) = nx;
                            que_y(tail) = ny;
                            tail = tail + 1;
                        end
                    end
                end
            end
        end
    end
end

[row_cut, column_cut] = makingGrids(256, 256, 16, 16);
imshow(showBlocking(blocking, row_cut, column_cut));
max(max(blocking))
end


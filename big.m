clc
clear














































M = 1000;
c = [-1 1 0 0 -M];
A = [1 1 1 0 0;
     2 3 0 -1 1];
b = [1;6];
m = size(A,1);
n = size(A,2);
bv_index = [3 5];
Y = [A b];
for s = 1:50
    fprintf('\nIteration %d\n',s);
    cb = c(bv_index);
    xb = Y(:,end);
    z = cb * xb;
    zjcj = cb * Y(:,1:n) - c;
    Table = [zjcj z; Y];
    simplex_table = array2table(Table);
    simplex_table.Properties.VariableNames = ...
        {'x1','x2','s1','s2','a1','sol'};
    disp(simplex_table)
    if all(zjcj >= 0)
        disp('Optimal Solution Reached')
        x_full = zeros(n,1);
        x_full(bv_index) = xb;
        fprintf('\nOptimal Solution:\n')
        disp(x_full)
        fprintf('Optimal Value = %.2f\n',z)
        break
    else
        [~, EV] = min(zjcj);
        fprintf('Entering Variable = %s\n', ...
            simplex_table.Properties.VariableNames{EV});
        if all(Y(:,EV) <= 0)
            disp('Unbounded Solution')
            break
        end
        ratio = inf(m,1);
        for j = 1:m
            if Y(j,EV) > 0
                ratio(j) = xb(j)/Y(j,EV);
            end
        end
        disp('Ratio:')
        disp(ratio)
        [~, LV] = min(ratio);
        fprintf('Leaving Variable Row = %d\n',LV)
        fprintf('Pivot Key = %.2f\n',Y(LV,EV))
        bv_index(LV) = EV;
    end
    pivot = Y(LV,EV);
    Y(LV,:) = Y(LV,:) / pivot;
    for i = 1:m
        if i ~= LV
            Y(i,:) = Y(i,:) - Y(i,EV)*Y(LV,:);
        end
    end
end
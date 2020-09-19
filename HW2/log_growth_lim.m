function [lims, e] = log_growth_lim(x0, r, step_size)
    e = []; % expectations of batches 
    d = []; % differences of expections of batches   
    cnt = 1; % counter of while loop
    tol = 0.0001; % tolerence
    batch_size = step_size;

    % note: there will be cnt+1 expectations

    % 1st batch
    x = log_growth(x0, r, batch_size);
    del_pt = ceil(batch_size*3/4);
    e(cnt) = mean(x(del_pt:end));
    
    % 2nd batch
    new_x0 = x(end);
    x = log_growth(new_x0, r, batch_size);
    e(cnt+1) = mean(x);

    % 1st difference
    d(cnt) = abs(e(cnt+1)-e(cnt));

    % while loop calculating differences
    while (true)
        % stopping criteria
        if (d(cnt) < tol)
            break
        elseif (mod(cnt, 10) == 0)
            batch_size = step_size*floor(cnt/10);
        end
        
        cnt = cnt + 1;
        new_x0 = x(end);
        x = log_growth(new_x0, r, batch_size);
        
        e(cnt+1) = mean(x);
        d(cnt) = abs(e(cnt+1)-e(cnt));
    end
    lims = uniquetol(x, tol);
end

function x = log_growth(x0, r, batch_size)
    x = zeros(1, batch_size);
    x(1) = recur(x0, r);
    for i = 2:batch_size
        x(i) = recur(x(i-1), r);
    end
end

function x1 = recur(x0, r)
    x1 = r*x0*(1-x0);
end

function [bt_mx] = BrownianTree2(n, npts)
    bt_mx = zeros(n, n);

    % seed in center
    x = floor(n/2);
    y = floor(n/2);
    bt_mx(x,y) = 1;

    for i=1:npts
        % sample new point
        if (i>1)
            x = datasample(1:n, 1, 'Replace',false);
            y = datasample(1:n, 1, 'Replace',false);
        end

        while (1)
            ox = x + datasample(-1:1, 1, 'Replace',false);
            oy = y + datasample(-1:1, 1, 'Replace',false);

            if (x<=n && y<=n && x>=1 && y>=1 && bt_mx(x,y))
                if (ox<=n && oy<=n && ox>=1 && oy>=1)
                    bt_mx(ox,oy) = 1;
                    break
                end
            end
            if (~(x<=n && y<=n && x>=1 && y>=1))
                break
            end
        end
    end
end

function stp_data = STP(x, m, max_deltat, p)
    xlen = length(x);
    
    % 1st dimension
    x1 = x(m:xlen);

    % 2nd dimension
    x2 = x(1:(xlen-m+1));
    
    X = [x1, x2];
    Xlen = length(X);
    
    deltats = 0:1:max_deltat;

    stp_data = zeros(1, length(deltats));
    for i=1:length(deltats)
        deltat = deltats(i);

        n = 1:1:(Xlen-deltat);
        dnt = zeros(length(n), 1);
        for j=1:length(n)
            dnt(j) = pdist([x(j,:); x(j+deltat,:)], 'cityblock');
        end
        
        Qp = floor(p*(Xlen-deltat));
        
        dnt_order = sort(dnt, 'ascend');
        stp_data(i) = dnt_order(Qp);
    end
end

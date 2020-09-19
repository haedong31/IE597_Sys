function ENT = entropy(RP, lmin)
    N = length(RP);
    flip_RP = fliplr(RP);

    lprob = zeros(1, N);
    % diagonals (two on RP) length from 1 to N-1
    for i=1:(N-1)
        lprob(i) = (sum(diag(flip_RP, i), 'all') + sum(diag(flip_RP, -i), 'all')) / sum(RP, 'all');
    end

    % main diagonal (one on RP)
    lprob(N) = sum(diag(flip_RP, 0)) / sum(RP, 'all');

    ENT = -sum(lprob(lmin:end) .* log(lprob(lmin:end)));
end

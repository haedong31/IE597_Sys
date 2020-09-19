function DET = determinism(RP, lmin)
    N = length(RP);
    flip_RP = fliplr(RP);

    lprob = zeros(1, N);
    % diagonals (two on RP) length from 1 to N-1
    for i=1:(N-1)
        lprob(i) = i * (sum(diag(flip_RP, i), 'all') + sum(diag(flip_RP, -i), 'all')) / sum(RP, 'all');
    end

    % main diagonal (one on RP)
    lprob(N) = N * sum(diag(flip_RP, 0)) / sum(RP, 'all');

    DET = sum(lprob(lmin:end)) / sum(lprob);
end

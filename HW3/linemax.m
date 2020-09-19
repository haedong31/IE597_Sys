function LMAX = linemax(RP)
    N = length(RP);
    flip_RP = fliplr(RP);

    l = zeros(1, N);
    for i=1:(N-1)
        l(i) = (sum(diag(flip_RP, i), 'all') + sum(diag(flip_RP, -i), 'all'));
    end
    l(N) = sum(diag(flip_RP, 0));

    LMAX = max(l);
end

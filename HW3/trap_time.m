function TT = trap_time(RP, vmin)
    N = length(RP);
    v = vmin:1:N;

    prob = zeros(1, N);
    for i=1:N
        prob(i) = sum(RP(i:N,:), 'all') / sum(RP, 'all');
    end
    
    TT = sum(v .* prob(vmin:end)) / sum(prob(vmin:end));
end

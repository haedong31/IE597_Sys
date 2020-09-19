function LAM = laminarity(RP, vmin)
    N = length(RP);
    
    vprob = zeros(1, N);
    for i=1:N
        vprob(i) = i * sum(RP(i:N,:), 'all') / sum(RP, 'all');
    end

    LAM = sum(vprob(vmin:end)) / sum(vprob);
end

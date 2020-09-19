function RR = recur_rate(RP)
    N = length(RP);
    RR = sum(RP, 'all') / (N^2);
end

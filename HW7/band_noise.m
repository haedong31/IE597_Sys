function [nx] = band_noise(x, r)
    xsize = size(x);
    unif = makedist('Uniform', 'lower',-r, 'upper',r);
    noiz = random(unif, xsize(1), xsize(2));
    nx = x + noiz;
end

function [val] = target_surf(x)
    load frac_surf
    val = frac_surf(ceil(x.x1), ceil(x.x2));
end

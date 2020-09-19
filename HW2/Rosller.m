function [t, states] = Rosller(param, init, sim_time)
    init_vals = init;
    tspan = [0, sim_time];
    [t, states] = ode45(@(t, states)compute_rates(t, states, param), tspan, init_vals);
end

function rates = compute_rates(t, states, param)
    % {states(1): x, states(2): y, states(3): z}
    states_size = size(states);
    states_ncol = states_size(2);
    states_nrow = states_size(1);
    if (states_ncol == 1)
        states = states';
    else
        rates = zeros(states_nrow, states_ncol);
    end

    rates(:,1) = -states(:,2)-states(:,3);
    rates(:,2) = states(:,1)+param(1).*states(:,2);
    rates(:,3) = param(2)+states(:,3).*(states(:,1)-param(3));

    rates = rates';
end

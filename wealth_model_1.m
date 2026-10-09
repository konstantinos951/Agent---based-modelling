% Wealth Distribution Model
% Agent-based simulation with 500 agents, each starting with 10 units of wealth.
% In each period, every agent with positive starting wealth transfers one unit
% to a randomly selected other agent.
% Transfers are applied simultaneously at the end of each period.
% The simulation runs for 1,000 periods and plots wealth distributions
% at periods 0, 100 and 1,000.
% Initial and final total wealth are calculated to check wealth conservation.
% A fixed random seed makes the simulation reproducible.

rng(1);
N = 500;
wealth = 10 * ones(1, N); %where the ones(1,N) creates a vector with 1 in each place until it reaches the number N
initial_total = sum(wealth);
saved = wealth;

for t = 1:1000
    new_wealth = wealth; % in order to know the distrivution of the health in each new begining of the simulation
    change = zeros(1, N); % i create a vector consisting only from 0 in order to calculate the change
    for i = 1:N
        if new_wealth(i) > 0
            j = randi(N); % a random number between 1 to N, with the same probability 
            while j == i
                j = randi(N); % i is the giver and j the receiver and if i and j are the same person do that again befor the transaction happens 
            end
            change(i) = change(i) - 1;
            change(j) = change(j) + 1;
        end
    end
    wealth = new_wealth + change;
    if t == 10
        saved(2, :) = wealth;
    end
end

saved(3, :) = wealth;
final_total = sum(wealth) % to check that everything is the same amund wise 
times = [0 100 1000];
figure;
for k = 1:3
    subplot(1, 3, k);
    histogram(saved(k, :), 'BinWidth', 1);
    title(['Period ' num2str(times(k))]);
end

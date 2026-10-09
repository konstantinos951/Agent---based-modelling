% Minimal Limit Order Book
% Simulates 400 incoming orders with equal probabilities of buying and selling.
% Order prices are generated around a reference price, initially set to 100
% and subsequently updated to the most recent transaction price.
% A buy order trades when its price meets or exceeds the lowest available ask.
% A sell order trades when its price meets or falls below the highest available bid.
% Transactions execute at the resting order's price.
% Unmatched orders remain in the book, and transaction prices are plotted.
% A fixed random seed makes the simulation reproducible.

clear; close all; clc
rng(1)

T = 400;
bid = []; % we create an empty array waiting to store future info 
ask = [];  % we create an empty array waiting to store future info
trade = []; % we create an empty array waiting to store future info
ref = 100; % the reference price is set to 100

for t = 1:T %each repetition shows one new order in our simulation
    if ~isempty(trade) % if the trade array is not empty then
        ref = trade(end); % the reference price updates to the last traded one 
    end

    buy = rand < 0.5; % draw a number uniformly with equal possibility and as such buying and selling has 50% probability of happening 
    price = round(ref + 2*randn); % we get the previous reference price and generate a number using normal distribution * 2 to give it a wide range around the last price STD=2 and then we round it  

    if buy
        if ~isempty(ask) && price >= min(ask) %if the sellers array is empty and ptice is higher than the minimum ask 
            [p, j] = min(ask); % p is the lowers sell price and j the position in asking price 
            trade(end+1) = p; %we put the price in the next possible position in the trade array
            ask(j) = [];% remove the completed trades from the arrays, so it is removed from the ask array
        else
            bid(end+1) = price; % if a trade is nos possible store it
        end
    else
        if ~isempty(bid) && price <= max(bid) %if the bid array is not empty and the price is lower or equal to the maximum of the bid array 
            [p, j] = max(bid); %gives the price and the position in the arranged array
            trade(end+1) = p; % the value goes into the trading array in the next possible position
            bid(j) = []; % and we remove the price from the bid array 
        else
            ask(end+1) = price; % add it to the sellers waiting list
        end
    end
end

plot(trade)
xlabel('Trade number')
ylabel('Transaction price')
title('Minimal limit-order book')

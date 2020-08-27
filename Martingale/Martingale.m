% This program follows the Martingale Roulette Strategy. It randomly
% generates an integer between 1 and 37. Because of this, a random number
% generated will equate to one less than this on a roulette wheel. I have,
% though, put in an x = x - 1 so that it is easier to follow. The
% Martingale requires the player to place a unit of red or black, or odd or
% even. In this program, the bet is placed on odds. After a loss, the bet
% is doubled. After a win the bet goes back to the original stake.

clear all
clc     % Clear the command window
endbank = [ ];  % Set funds at end to zero
banki = input('How much money does the player start with: ');    % How much money the player has
unit = input('Give the unit size: ');
for j = 1:1000  % Loop. How many times the strategy is tested
    x = 0;          % Set variable x
    bank = banki;
    bet = unit;
    bankrun = [ ];
    endbank = [endbank];  % To record funds at end of spins each loop
    v = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    y = [0:36];
    % Set vector to record the frequency of each number
    for i = 1:1000   % Loop. How many spins of the roulette wheel
        x = randi(37);   % Generate random number between 1 and 37
        x = x - 1;      % Convert to real number in roulette
        bank = bank;    % Set bank after each loop
        
        if rem(x,2) == 0  % If you divide number by 2 and remainder is zero, player loses
            bank = bank - bet;
            bet = bet*2;
            v(x + 1) = v(x + 1) + 1;
        else                    % Player wins on odds numbers
            bank = bank + bet;
            bet = unit;
            v(x + 1) = v(x + 1) + 1;
        end
        
        bankrun = [bankrun bank];
        if bank <= 0  % End program if bank is zero or drops below
            %disp(i)
            break
        end
    end
    %disp(bank)  % Display final money after each loop
    endbank = [endbank bank];  % Add this loop's end funds to vector
end
%disp(x)
disp(endbank)  % Display end funds from each loop

disp('Choose your graph option:')
disp(' ')
disp('USE ONLY IF ONE LOOP')
disp('Otherwise it will take only the final iteration')
disp(' ')
disp('1. Display graph of the distribution of numbers ball landed on')
disp('2. Display graph of funds after each spin')
disp(' ')
disp('USE FOR ANY AMOUNT OF LOOPS')
disp(' ')
disp('3. Display graph of end funds after each loop')
disp(' ')
disp('4. ALL THE GRAPHS!')
disp(' ')
option = input('Which graph do you choose? ');

if option == 1
    stem(y,v)
    xlabel('Number')
    ylabel('Times landed on')
    title('The frequency at which each number was landed on')
end
if option == 2
    hold on
    plot(bankrun)
    xlabel('Number of spins')
    ylabel('Remaining money')
    title('How much money the player has left after each spin')
    plot([0 i], [banki banki],'k')
end
if option == 3
    hold on
    plot(endbank)
    xlabel('Loop number')
    ylabel('Money remaining after all spins')
    title('How much money the player has left after all spins in each loop')
    plot([0 i], [banki banki],'k')
end

if option == 4
    subplot(2,2,1)
    stem(y,v)
    xlabel('Number')
    ylabel('Times landed on')
    title('The frequency at which each number was landed on')
    subplot(2,2,2)
    hold on
    plot(bankrun)
    xlabel('Number of spins')
    ylabel('Remaining money')
    title('How much money the player has left after each spin')
    plot([0 i], [banki banki],'k')
    subplot(2,2,3)
    hold on
    plot(endbank)
    xlabel('Loop number')
    ylabel('Money remaining after all spins')
    title('How much money the player has left after all spins in each loop')
    plot([0 j], [banki banki],'k')
end

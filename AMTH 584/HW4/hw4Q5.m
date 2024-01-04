function hw4Q5(x)

oldsum = 0;
newsum = 1; % First term in series.
term = 1;
terms = [];
n = 0;
while newsum ~= oldsum % Iterate until next term is negligible.
    n = n + 1;
    term = term * abs(x)/n; % This is x^n / n!
    oldsum = newsum;
    terms = [terms [term, oldsum]]; %show that these are both very neg or very pos at the same time
    newsum = newsum + term;
end


if(x < 0)
    newsum = 1/newsum;
end

format long e
disp("Alg got")
disp(newsum)
disp("Exp got " )
disp(exp(x))
disp("Absolute Error is")
disp(abs(exp(x) - newsum))
disp("Relative Error is")
disp(abs(exp(x) - newsum)/exp(x))
disp("Max middle")
disp(max(terms))
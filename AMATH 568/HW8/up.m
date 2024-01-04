function dydt = up(t,y,d,e,w)
    dydt = [y(2); (d-e*cos(w*t))*y(1)];
end
function q5()
    A = [1,-1,0,0;-1,0,1,0;1,0,0,-1;0,0,1,-1;0,1,0,-1;1,1,1,1];
    b = [4;9;6;3;7;10];
    [Q, R] = qr(A);
    results = R\(Q'*b)
    sum(results)
end
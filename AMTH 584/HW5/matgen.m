    function A=matgen(m, condno)

    %Generate a two random orthogonal m-square matrix
    [U,R1] = qr(randn(m));
    [V,R2] = qr(randn(m));

    %Generate Sigma
    v = zeros(m,1);
    for j=1:m
        v(j) = condno^(-(j-1)/(m-1));
    end
    sigma = diag(v);

    %Compute A
    A = U*sigma*V';


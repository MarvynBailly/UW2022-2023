function hw2()
imagedemo;
%Compute SVD of X
[U,S,V] = svd(X);
for i=1:6
    amount = 10*i;
    X = U(:,1:amount) * S(1:amount,1:amount) * V(:,1:amount)';
    subplot(2,3,i);
    imagesc(X);
    colormap(map);
    axis off;
    axis equal;
    
    title(amount+" singular values");
end
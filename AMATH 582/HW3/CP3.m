clear all

%% Ideal case
load('Xt1_1.mat')
load('Xt2_1.mat')
load('Xt3_1.mat')

% Each of these pairs of vectors will be different lengths, so what should
% you do to not get dimension errors?

n = length(Xt1_1);

Xt2_1 = Xt2_1(:, 1:n);
Xt3_1 = Xt3_1(:, 1:n);


% After taking care of the dimension issue, subtract the mean off of each
% component; i.e. each row vector for each video (see documentation for the
% "mean" function and becareful of the dimensions to make sure it's done
% correctly because it's finicky).

Xt1_1 = Xt1_1 - mean(Xt1_1, 2);
Xt2_1 = Xt2_1 - mean(Xt2_1, 2);
Xt3_1 = Xt3_1 - mean(Xt3_1, 2);

% Combine the pairs of vectors into one 6xL matrix, where L is the length,
% which will vary depending on the video.
% Take the svd and do a coordinate transformation to the principal
% components just like we did in the lectures (we called this matrix Y).
% Save the matrix Y as A1.

X = cat(1,Xt1_1,Xt2_1,Xt3_1);
[U,S,V] = svd(X,'econ');
Y = U'*X;

A1 = Y; % Shape: 6x226 double

% Save the energies of nontrivial the singular values as a vector in the
% varialbe A2.

A2 = S/sum(S); % Shape: 6x1 double

%%% Plot the energies with a log-scaled ordinate for the report (not for 
% the autograder)

figure(1)
semilogy(A2,'ko','Linewidth',2)
axis([0 10 10^(-5) 10])
hold on

% The appropriate rank necessary for a decent approximation will be
% informed by the energies and by judging the qualitative convergence (no
% need for rigorous analysis, you can just plot and check) as we increase
% the rank of the approximation.
% Save the rank-n approximation as A3.
% Of course, this will be subjective (for now), so you may have to try it
% a few times to match what I picked.  You also may not agree with my
% choice, or your mass tracking may be different based on what you clicked.
% If you get it to pass the autograder, but you disagree put it in the
% report.

%let's do a rank 2 approx
A3 = U(:,1:2)*S(1:2,1:2)*V(:,1:2)'; % Shape: 6x226 double


%%% Plot the approximations from SVD for report (not for autograder)
% Plot each rank-n approximation (up to one more than A12) to observe the
% convergence

%Let's look at the first row

X_rank1 = U(:,1:1)*S(1:1,1:1)*V(:,1:1)';
X_rank2 = U(:,1:2)*S(1:2,1:2)*V(:,1:2)';
X_rank3 = U(:,1:3)*S(1:3,1:3)*V(:,1:3)';

figure(2)
plot(X_rank1(1,:))
hold on
plot(X_rank2(1,:))
hold on
plot(X_rank3(1,:))
legend("Rank 1","Rank 2","Rank 3")
hold off


%% Test 2
load('Xt1_2.mat')
load('Xt2_2.mat')
load('Xt3_2.mat')

% Repeat what you did for the Ideal Case
% Each of these pairs of vectors will be different lengths, so what should
% you do to not get dimension errors?

n = length(Xt1_2);

Xt2_2 = Xt2_2(:, 1:n);
Xt3_2 = Xt3_2(:, 1:n);




% After taking care of the dimension issue, subtract the mean off of each
% component; i.e. each row vector for each video (see documentation for the
% "mean" function and becareful of the dimensions to make sure it's done
% correctly because it's finicky).


Xt1_2 = Xt1_2 - mean(Xt1_2, 2);
Xt2_2 = Xt2_2 - mean(Xt2_2, 2);
Xt3_2 = Xt3_2 - mean(Xt3_2, 2);



% Combine the pairs of vectors into one 6xL matrix, where L is the length,
% which will vary depending on the video.
% Take the svd and do a coordinate transformation to the principal
% components just like we did in the lectures (we called this matrix Y).
% Save the matrix Y as A4.

X = cat(1,Xt1_2,Xt2_2,Xt3_2);
[U,S,V] = svd(X,'econ');
Y = U'*X;

A4 = Y; % 6x314 double


% Save the energies of nontrivial the singular values as a vector in the
% varialbe A5.

A5 = S/sum(S); % 6x1 double



%%% Plot the energies with a log-scaled ordinate for the report (not for 
% the autograder)

figure(1)
semilogy(A5,'ko','Linewidth',2)
axis([0 10 10^(-5) 10])
hold on

% The appropriate rank necessary for a decent approximation will be
% informed by the energies and by judging the qualitative convergence (no
% need for rigorous analysis, you can just plot and check) as we increase
% the rank of the approximation.
% Save the rank-n approximation as A6.
% Of course, this will be subjective (for now), so you may have to try it
% a few times to match what I picked.  You also may not agree with my
% choice, or your mass tracking may be different based on what you clicked.
% If you get it to pass the autograder, but you disagree put it in the
% report.

A6 = U(:,1:3)*S(1:3,1:3)*V(:,1:3)'; % 6x314 double


%%% Plot the approximations from SVD for report (not for autograder)
% Plot each rank-n approximation (up to one more than A12) to observe the
% convergence

X_rank1 = U(:,1:1)*S(1:1,1:1)*V(:,1:1)';
X_rank2 = U(:,1:2)*S(1:2,1:2)*V(:,1:2)';
X_rank3 = U(:,1:3)*S(1:3,1:3)*V(:,1:3)';
X_rank4 = U(:,1:4)*S(1:4,1:4)*V(:,1:4)';

figure(2)
plot(X_rank1(1,:))
hold on
plot(X_rank2(1,:))
hold on
plot(X_rank3(1,:))
hold on
plot(X_rank4(1,:))
legend("Rank 1","Rank 2","Rank 3","Rank 4")
hold off




%% Test 3
load('Xt1_3.mat')
load('Xt2_3.mat')
load('Xt3_3.mat')

% Repeat what you did for the Ideal Case
% Each of these pairs of vectors will be different lengths, so what should
% you do to not get dimension errors?

n = length(Xt3_3);

Xt1_3 = Xt1_3(:, 1:n);
Xt2_3 = Xt2_3(:, 1:n);





% After taking care of the dimension issue, subtract the mean off of each
% component; i.e. each row vector for each video (see documentation for the
% "mean" function and becareful of the dimensions to make sure it's done
% correctly because it's finicky).

Xt1_3 = Xt1_3 - mean(Xt1_3, 2);
Xt2_3 = Xt2_3 - mean(Xt2_3, 2);
Xt3_3 = Xt3_3 - mean(Xt3_3, 2);




% Combine the pairs of vectors into one 6xL matrix, where L is the length,
% which will vary depending on the video.
% Take the svd and do a coordinate transformation to the principal
% components just like we did in the lectures (we called this matrix Y).
% Save the matrix Y as A7.

X = cat(1,Xt1_3,Xt2_3,Xt3_3);
[U,S,V] = svd(X,'econ');
Y = U'*X;

A7 = Y; % Shape: 6x237 double


% Save the energies of nontrivial the singular values as a vector in the
% varialbe A8.

A8 = S/sum(S); % Shape: 6x1 double



%%% Plot the energies with a log-scaled ordinate for the report (not for 
% the autograder)


figure(1)
semilogy(A8,'ko','Linewidth',2)
axis([0 10 10^(-5) 10])
hold on



% The appropriate rank necessary for a decent approximation will be
% informed by the energies and by judging the qualitative convergence (no
% need for rigorous analysis, you can just plot and check) as we increase
% the rank of the approximation.
% Save the rank-n approximation as A9.
% Of course, this will be subjective (for now), so you may have to try it
% a few times to match what I picked.  You also may not agree with my
% choice, or your mass tracking may be different based on what you clicked.
% If you get it to pass the autograder, but you disagree put it in the
% report.



A9 = U(:,1:3)*S(1:3,1:3)*V(:,1:3)'; % 6x237 double


%%% Plot the approximations from SVD for report (not for autograder)
% Plot each rank-n approximation (up to one more than A12) to observe the
% convergence


X_rank1 = U(:,1:1)*S(1:1,1:1)*V(:,1:1)';
X_rank2 = U(:,1:2)*S(1:2,1:2)*V(:,1:2)';
X_rank3 = U(:,1:3)*S(1:3,1:3)*V(:,1:3)';
X_rank4 = U(:,1:4)*S(1:4,1:4)*V(:,1:4)';

figure(2)
plot(X_rank1(1,:))
hold on
plot(X_rank2(1,:))
hold on
plot(X_rank3(1,:))
hold on
plot(X_rank4(1,:))
legend("Rank 1","Rank 2","Rank 3","Rank 4")
hold off


%% Test 4
load('Xt1_4.mat')
load('Xt2_4.mat')
load('Xt3_4.mat')

% Repeat what you did for the Ideal Case
% Each of these pairs of vectors will be different lengths, so what should
% you do to not get dimension errors?


n = length(Xt1_4);

Xt2_4 = Xt2_4(:, 1:n);
Xt3_4 = Xt3_4(:, 1:n);



% After taking care of the dimension issue, subtract the mean off of each
% component; i.e. each row vector for each video (see documentation for the
% "mean" function and becareful of the dimensions to make sure it's done
% correctly because it's finicky).



Xt1_4 = Xt1_4 - mean(Xt1_4, 2);
Xt2_4 = Xt2_4 - mean(Xt2_4, 2);
Xt3_4 = Xt3_4 - mean(Xt3_4, 2);



% Combine the pairs of vectors into one 6xL matrix, where L is the length,
% which will vary depending on the video.
% Take the svd and do a coordinate transformation to the principal
% components just like we did in the lectures (we called this matrix Y).
% Save the matrix Y as A10.

X = cat(1,Xt1_4,Xt2_4,Xt3_4);
[U,S,V] = svd(X,'econ');
Y = U'*X;

A10 = Y; % 6x392 double


% Save the energies of nontrivial the singular values as a vector in the
% varialbe A11.

A11 = S/sum(S); % 6x1 double



%%% Plot the energies with a log-scaled ordinate for the report (not for 
% the autograder)


figure(1)
semilogy(A11,'ko','Linewidth',2)
axis([0 10 10^(-5) 10])
hold on




% The appropriate rank necessary for a decent approximation will be
% informed by the energies and by judging the qualitative convergence (no
% need for rigorous analysis, you can just plot and check) as we increase
% the rank of the approximation.
% Save the rank-n approximation as A12.
% Of course, this will be subjective (for now), so you may have to try it
% a few times to match what I picked.  You also may not agree with my
% choice, or your mass tracking may be different based on what you clicked.
% If you get it to pass the autograder, but you disagree put it in the
% report.

A12 = U(:,1:2)*S(1:2,1:2)*V(:,1:2)'; % 6x392 double


%%% Plot the approximations from SVD for report (not for autograder)
% Plot each rank-n approximation (up to one more than A12) to observe the
% convergence
X_rank1 = U(:,1:1)*S(1:1,1:1)*V(:,1:1)';
X_rank2 = U(:,1:2)*S(1:2,1:2)*V(:,1:2)';
X_rank3 = U(:,1:3)*S(1:3,1:3)*V(:,1:3)';

figure(2)
plot(X_rank1(1,:))
hold on
plot(X_rank2(1,:))
hold on
plot(X_rank3(1,:))

legend("Rank 1","Rank 2","Rank 3")
hold off
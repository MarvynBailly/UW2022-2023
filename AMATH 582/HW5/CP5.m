% This will be exactly like Week10_DMD.m

% Declare the X1 and X2 variables from the variable data
% Take the SVD of X1
% Compute the S tilde matrix 
% Save S tilde as the variable A1

load('CP5_data.mat')

%data = data';
X1 = data(:,1:end-1);
X2 = data(:,2:end);

[U, Sigma, V] = svd(X1,'econ');
S = U'*X2*V*diag(1./diag(Sigma));

A1 = S; % Shape: 675x675 double


% Solve the eigenvalue problem for S tilde
% Calculate dt based on the frame rate
% Convert eigenvalues from mu to omega
% This is where things will slightly deviate from Week10_DMD.  We need to
% pick the eigenvector associated with the smallest (in modulus)
% eigenvalue and reconstruct the solution u_dmd using only this eigenvalue
% and eigenvector
% Save the smallest (in modulus) eigenvalue as A2
% Save the 339th column of u_dmd as A3


slices = 29.97;
t = linspace(0,2*pi,slices+1); 
dt = t(2) - t(1);

[eV, D] = eig(S); % compute eigenvalues + eigenvectors
mu = diag(D); % extract eigenvalues
omega = log(mu)/dt;
[smallE,ind] = min(omega); %get smallest eval

%%
Phi = U*eV(:,ind);
y0 = Phi\X1(:,1); % pseudoinverse to get initial conditions

tNew = linspace(0,2*pi,676);
u_modes = zeros(length(y0),length(tNew));
for iter = 1:length(tNew)
    u_modes(:,iter) = y0.*exp(omega(ind)*tNew(iter));
end
u_dmd = Phi*u_modes;

A2 = smallE; % scalar
A3 = u_dmd(:,339); % 100368x1 double
%%



% Truncate u_dmd to the number of frames in data
u_dmd_short = u_dmd;
% Subtract u_dmd from data, this will be the foreground video
foreground = u_dmd_short - data;
% The modulus of u_dmd will be the background video data
background = abs(u_dmd_short);
% The modulus of after the subtraction will be the foreground video data
foreground = abs(foreground);

% Save the 338th column of background as A4
% Save the 339th column of foreground as A5

A4 = background; % 100368x1 double
A5 = foreground; % 100368x1 double

% After you're done submitting to gradescope, change A4 and A5 to the full
% background and foreground matrices in order for it to work with MakeVid.m
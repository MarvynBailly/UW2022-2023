clear variables; close all; clc

load 'CP2_SoundClip.mat'

Fs = 44100; %sample rate of the sound clip

S = y'; % transposes in order to have consistent dimensions
w = length(y)/4; % break the spectogram up into four time windows, otherwise it
% will be too big for MATLAB/autograder to run.

S1 = S((1-1)*w+1:1*w); % this will isolate the correct window
S2 = S((2-1)*w+1:2*w); % this will isolate the correct window
S3 = S((3-1)*w+1:3*w); % this will isolate the correct window
S4 = S((4-1)*w+1:4*w); % this will isolate the correct window

L = length(S1)/Fs; % length of each window in seconds
n = length(S1);  % number of elements in each window
t = (0:1/Fs:L - 1/Fs); % t in sec. relative to the start of the window
tau = 0:0.1:L; % discretization for the Gabor transform
k = 2*pi*(1/L/2)*[0:n/2-1 -n/2:-1]; % discretization in frequency space
ks = fftshift(k); % gotta shift them freqs.

Sgt_spec = zeros(length(ks),length(tau)); % initializing the function for the spectrogram

%Gabor Transform Parameters
a = 400; %this will give you the correct width, so exp(-a(...))
range = (1:1800); %use this when finding the max and index of the transformed Gabor filtered signal
% i.e., max(TransformedSignal_GaborFiltered(range))


% Repeat this part for S1, S2, S3, and S4.
% For this part we are going to make a spectrogram, but only for the freqs.
% of interest.  So first we'll do a Gabor transform, then we'll filter
% around our peak freq. in the regime of interest, and then we'll look at
% the spectrogram of that function.

% Gabor transform each S, just like we did in the lecture
% Week4_Spectrograms.m lines 141 to 146.
% You'll have to add code between line 144 and Sgt_spec at line 145.

% After line 144 find the index of your peak frequency (in absolute value)
% within the range of interest (this range is very forgiving so you don't
% have to match the autograder exactly, just use your judgement based on
% the figure in the assignment statement).  Then make a filter centered
% about the peak frequency.  Filter the Gabor transformed function.
% this is the function you will use in line 145 from the lecture to find
% your Sgt_spec.


for j = 1:length(tau)
   g = exp(-a*(t - tau(j)).^2); % Window function
   Sg = g.*S1;
   Sgt = fft(Sg);

   [M,I] = max(Sgt(range)); %Find Max
   filter = exp(-(1/L)*(abs(k) - abs(k(I))).^2); %Create filter centered about peak freq.
   filteredSgt = filter .* Sgt; %Apply the freq

   Sgt_spec(:,j) = fftshift(abs(filteredSgt)); % We don't want to scale it
end
A1 = Sgt_spec; 

for j = 1:length(tau)
   g = exp(-a*(t - tau(j)).^2); % Window function
   Sg = g.*S2;
   Sgt = fft(Sg);

   [M,I] = max(Sgt(range)); %Find Max
   filter = exp(-(1/L)*(abs(k) - abs(k(I))).^2); %Create filter centered about peak freq.
   filteredSgt = filter .* Sgt; %Apply the freq

   Sgt_spec(:,j) = fftshift(abs(filteredSgt)); % We don't want to scale it
end
A2 = Sgt_spec;

for j = 1:length(tau)
   g = exp(-a*(t - tau(j)).^2); % Window function
   Sg = g.*S3;
   Sgt = fft(Sg);

   [M,I] = max(Sgt(range)); %Find Max
   filter = exp(-(1/L)*(abs(k) - abs(k(I))).^2); %Create filter centered about peak freq.
   filteredSgt = filter .* Sgt; %Apply the freq

   Sgt_spec(:,j) = fftshift(abs(filteredSgt)); % We don't want to scale it
end
A3 = Sgt_spec;

for j = 1:length(tau)
   g = exp(-a*(t - tau(j)).^2); % Window function
   Sg = g.*S4;
   Sgt = fft(Sg);

   [M,I] = max(Sgt(range)); %Find Max
   filter = exp(-(1/L)*(abs(k) - abs(k(I))).^2); %Create filter centered about peak freq.
   filteredSgt = filter .* Sgt; %Apply the freq

   Sgt_spec(:,j) = fftshift(abs(filteredSgt)); % We don't want to scale it
end
A4 = Sgt_spec;
% Save Sgt_spec as variable A1 after your for loop.  Repeat for S2, S3, and
% S4 and save those Sgt_spec as A2, A3, and A4.  You don't have to rewrite
% the code, just copy and paste and use the respective S's, or write a for
% loop that iterates through S1 to S4.

%A1 = AList{1};     % Shape:  484560x110 double
%A2 = AList{2};     % Shape:  484560x110 double
%A3 = Alist{3};     % Shape:  484560x110 double
%A4 = Alist{4};     % Shape:  484560x110 double


% Plot of spectrogram for each window (for the report, not for autograder)
% just like we did in the lecture, but change your ylim to be in the range
% of interest for the sound clip.

%subplot(2,2,1);
%pcolor(tau,ks,A1)
%shading interp
%set(gca,'ylim',[0 800],'Fontsize',16)
%colormap(hot)
%colorbar
%xlabel('time (t)'), ylabel('frequency (k)')
 
% subplot(2,2,2);
% pcolor(tau,ks,A2)
% shading interp
% set(gca,'ylim',[0 800],'Fontsize',16)
% colormap(hot)
% colorbar
% xlabel('time (t)'), ylabel('frequency (k)')
%  
% subplot(2,2,3);
% pcolor(tau,ks,A3)
% shading interp
% set(gca,'ylim',[0 800],'Fontsize',16)
% colormap(hot)
% colorbar
% xlabel('time (t)'), ylabel('frequency (k)')
%  
% subplot(2,2,4);
% pcolor(tau,ks,A4)
% shading interp
% set(gca,'ylim',[0 800],'Fontsize',16)
% colormap(hot)
% colorbar
% xlabel('time (t)'), ylabel('frequency (k)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Isolate the bassline
%%

S = y'; % transposes in order to have consistent dimensions
L = length(S)/Fs; % total length in sec. 
n = length(S); % total number of elements in S
t = (0:1/Fs:L - 1/Fs); % time discretization
k = (1/L)*[0:n/2-1 -n/2:-1]; % freq. discretization

% Take the Fourier transform of S, and in freq. space isolate all freqs. 
% (in absolute value) that you determine should be part of the baseline 
% according to spectrogram (or also just by listening); that is, all points
% in the transformed function not within the frequency range you determined
% should be set to zero (kind of like a Shannon filter, but simpler than
% what we did in lecture).
% You may have to do this part a few times with different thresholds to get
% it right.

sf = fft(S);

fMin = 60;
fMax = 250;

[~,indMin] = min(abs(k-fMin));
[~,indMax] = min(abs(k-fMax));

sf(1:indMin) = 0;
sf(indMax:end) = 0;



% After thresholding the transformed function, take the inverse transform
% of the thresholded function and save it as A5.

sBaseline = ifft(sf);


A5 = sBaseline';


%Play sound (not for autograder)

%p8 = audioplayer(A5, Fs); playblocking(p8);

%Plot the amplitude S over time (for the report, not for the autograder)

subplot(2,1,1);
plot(t,S);
title('Original signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2,1,2);
plot(t,real(sBaseline));
title('Baseline signal');
xlabel('Time (s)');
ylabel('Amplitude');

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Isolate the guitar

%Same exact process as the baseline above, but you'll have to be more
%careful about the frequency range.
S = y; %reinitialize the S from the previous part above.


sf = fft(S);

fMin = 450;
fMax = 550;

[~,indMin] = min(abs(k-fMin));
[~,indMax] = min(abs(k-fMax));

sf(1:indMin) = 0;
sf(indMax:end) = 0;

sGuitarline = ifft(sf);

A6 = sGuitarline;     %Shape:  1938240x1 double

%Play sound (not for autograder)

p8 = audioplayer(A6, Fs); playblocking(p8);

%Plot the amplitude S over time (for the report, not for the autograder)
subplot(2,1,1);
plot(t,S);
title('Original signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2,1,2);
plot(t,real(sGuitarline));
title('Guitar signal');
xlabel('Time (s)');
ylabel('Amplitude');
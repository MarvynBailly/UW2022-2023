%%% Clean workspace
clear all; close all; clc

%%% Load training data

load('CP4_training_labels.mat')
load('CP4_training_images.mat')



% Reshape training_images.m to 784x30000 in order to be consistent with the
% codes from the lecture.

training_images = reshape(training_images,[784, 30000]);



%%% Projecting onto principal components

% Conduct the wavelet transform on the entire training dataset.  To make it
% reusable you can write it as a function very similar (almost exactly the
% same) as dc_wavelet.m from the lecture.  For MATLAB you will need to
% include the function at the end of the code.


%image_wave = dc_wavelet(training_images);
load('Training_DWT.mat')
image_wave = Training_DWT;


% Find the SVD of the transformed data just like in Week7_LDA.m

[U,S,V] = svd(image_wave,'econ');

% Plot singular values (include in report, but not in gradescope submission)

figure(1)
plot(diag(S),'ko','Linewidth',2)
hold on

% How many features (i.e., singular values) should we use?  Save this as
% A1.  Hint: it's less than what we used in the lecture

A1 = 15; % 1x1. The number of PCA modes we are going to project onto.

% Project onto the principal components just like we did in Week7_LDA.m
% Restrict the matrix U to that of the feature space (like we did in 
% dc_trainer.m).  Save this as A2

nd = size(image_wave,2);    
animals = S*V'; % projection onto principal components: X = USV' --> U'X = SV'
image = animals(1:A1,1:nd); % first several rows of the dog cols

U = U(:,1:A1);

A2 = U; % 196x15


%%% Pick two numbers to train/test on.  Use 0 and 1 for the autograder.

zeroIndices = [];
oneIndices = [];

for i = 1:length(training_labels)
    if(training_labels(i) == 0)
        zeroIndices = [zeroIndices, i];
    elseif(training_labels(i) == 1)
        oneIndices = [oneIndices,i];
    end
end

zero = image(:,zeroIndices);
one = image(:,oneIndices);


% This is going to be quite different from what we did in the lectures.  In
% the lecture we had two datasets with dogs and cats.  Here everything is
% jumbled up so we need to separate them out.  Separate all the training 
% images of 0's and 1's using the training labels.

% Calculate the within class and between class variances just like in 
% Week7_LDA.m.  Save these as A3 and A4. dog is zero, cat is one



mean1 = mean(one,2);
mean0 = mean(zero,2);

Sw = 0; % within class variances
for k = 1:length(zero)
    Sw = Sw + (zero(:,k) - mean0)*(zero(:,k) - mean0)';
end
for k = 1:length(one)
   Sw =  Sw + (one(:,k) - mean1)*(one(:,k) - mean1)';
end

Sb = (mean0-mean1)*(mean0-mean1)'; % between class



A3 = Sw; % 15x15
A4 = Sb; % 15x15




% Find the best projection line just like in Week7_LDA.m.  Save the
% normalized projection line w as A5

[V2, D] = eig(Sb,Sw); % linear disciminant analysis; i.e., generalized eval. prob.
[lambda, ind] = max(abs(diag(D)));
w = V2(:,ind);
w = w/norm(w,2);



A5 = w; % 15x1


% Project the training data onto w just like in Week7_LDA.m

vzero = w'*zero;
vone = w'*one;
%%
plot(vzero,zeros(length(vzero)),'ob','Linewidth',2)
hold on
plot(vone,ones(length(vone)),'dr','Linewidth',2)
ylim([0 1.2])
%%
% Find the threshold value just like in Week7_LDA.m.  Save it as A6

if mean(vzero) > mean(vone)
    w = -w;
    vzero = -vzero;
    vone = -vone;
end


sortzero = sort(vzero);
sortone = sort(vone);
t1 = length(sortzero); % start on the right
t2 = 1; % start on the left
while sortzero(t1) > sortone(t2) 
    t1 = t1 - 1;
    t2 = t2 + 1;
end





threshold = (sortzero(t1) + sortone(t2))/2;

A6 = threshold ; % 1x1


%%% Classify test data
load('CP4_test_labels.mat')
load('CP4_test_images.mat')



% Reshape test_images.m to 784x5000 in order to be consistent with the
% codes from the lecture.

test_images = reshape(test_images,[784, 5000]);



% From the test set pick out the 0's and 1's without revealing the labels.
% Save only the images of 0's and 1's as a new dataset and save the
% associated labels for those exact 0's and 1's as a new vector.

indices = [];

for i = 1:length(test_labels)
    if(test_labels(i) < 2)
        indices = [indices, i];
    end
end

testImages = test_images(:,indices);
testLabels = test_labels(indices,:);

% Wavelet transform:  you can just use the same function you did for the
% training portion.

%waveTest = dc_wavelet(testImages);
load('Test_DWT.mat')
waveTest = Test_DWT;

% Project the test data onto the principal components just like in
% Week7_Learning.m
% Save the results in a vector (just like in Week7_Learning.m) and save it
% as A7.

TestMat = U'*waveTest; % PCA projection
pval = w'*TestMat; % Project onto w vector

A7 = pval; % 1x1062


%%% Checking performance just like we did in Week7_Learning.m.  If you did
%%% everything like I did (which may or may not be optimal), you should
%%% have a success rate of 0.9972.

ResVec = (pval > threshold); % results for test set
err = abs(ResVec - transpose(testLabels));
errNum = sum(err);
sucRate = 1 - errNum/length(test_images(1,:));


%%% For report only, not for the autograder:  Now write an algorithm to
%%% classify all 10 digits.  One way to do this is by using the "one vs all
%%% " method; i.e., loop through the digits and conduct LDA on each digit
%%% vs. all the other digits.
%%
thresholds = [];
i = 0
    disp("----")
    disp("Current Loop")
    disp(i)
    %preform LDA using one v all metod
    
    %get the indices of the number in interest
    indices = [];
    otherIndices = [];
    for j = 1:length(training_labels)
        if(training_labels(j) == i)
            indices = [indices, j];
        else
            otherIndices = [otherIndices, j];
        end
    end
    trainingNumber = image(:,indices);
    otherNumbers = image(:,otherIndices);
    
    
    meanTraining = mean(trainingNumber,2);
    meanOther  = mean(otherNumbers,2);

    Sw = 0; % within class variances
    for k = 1:length(trainingNumber)
        Sw = Sw + (trainingNumber(:,k) - meanTraining)*(trainingNumber(:,k) - meanTraining)';
    end
    for k = 1:length(otherNumbers)
       Sw =  Sw + (otherNumbers(:,k) - meanOther)*(otherNumbers(:,k) - meanOther)';
    end
    
    %disp(meanTraining) 
    %disp(meanOther)
    
    Sb = (meanTraining-meanOther)*(meanTraining-meanOther)'; % between class
    
    %disp(i)
    %disp(Sw)
    %disp(Sb)
    
    [V2, D] = eig(Sb,Sw); % linear disciminant analysis; i.e., generalized eval. prob.
    [lambda, ind] = max(abs(diag(D)));
    w = V2(:,ind);
    w = w/norm(w,2);
    
    vTraining = w'*trainingNumber;
    vOther = w'*otherNumbers;
    
    figure(1)
    plot(vTraining ,zeros(length(vTraining )),'ob','Linewidth',2)
    hold on
    plot(vOther,ones(length(vOther)),'dr','Linewidth',2)
    ylim([0 1.2])
    hold off
    
    % Find the threshold value just like in Week7_LDA.m.  Save it as A6
%     if mean(vTraining) > mean(vOther)
%         w = -w;
%         vTraining = -vTraining;
%         vOther = -vOther;
%     end
% 
% 
%     sortTraining = sort(vTraining);
%     sortOther = sort(vOther);
%     t1 = length(sortTraining); % start on the right
%     t2 = 1; % start on the left
%     while sortTraining(t1) > sortOther(t2) 
%         t1 = t1 - 1;
%         t2 = t2 + 1;
%     end
%     disp("Found Threshold")
%     disp(threshold)
%     threshold = (sortTraining(t1) + sortOther(t2))/2;
%     thresholds = [thresholds,threshold];
%%

load('CP4_test_labels.mat')
load('CP4_test_images.mat')

test_images = reshape(test_images,[784, 5000]);

testImages = test_images;
testLabels = test_labels;

waveTest = dc_wavelet(testImages);
%%
TestMat = U'*waveTest; % PCA projection
pvals = (w'*TestMat)'; % Project onto w vector
thresholds = [-1.5541,0;-0.9913,1;0.7857,2;-0.9104,3; -1.7099,4; -0.2493,5; -0.4406,6; -0.9420,7; 0.1590,8; -2.8204,9];
thresholds = sortrows(thresholds,1);

resvec = zeros(length(pvals),10);
for j = 1:length(pvals)
    RV = zeros(10);
    for i = 1:length(thresholds)-1
        RV = false | (pvals >= thresholds(i) & pvals < thresholds(i+1));
    end
    resvec(:,j) = RV;
end
%%
ResVec = (pval > threshold); % results for test set
err = abs(ResVec - transpose(testLabels));
errNum = sum(err);
sucRate = 1 - errNum/length(testImages(1,:));
%%

%%% Put any helper functions here
function dcData = dc_wavelet(dcfile) 
    [m,n] = size(dcfile); % 4096 x 80
    pxl = sqrt(m); % cus images are square
    nw = m/4; % wavelet resolution cus downsampling
    dcData = zeros(nw,n);
    
    for k = 1:n
        X = im2double(reshape(dcfile(:,k),pxl,pxl));
        [~,cH,cV,~]=dwt2(X,'haar'); % only want horizontal and vertical
        cod_cH1 = rescale(abs(cH)); % horizontal rescaled
        cod_cV1 = rescale(abs(cV)); % vertical rescaled
        cod_edge = cod_cH1+cod_cV1; % edge detection
        dcData(:,k) = reshape(cod_edge,nw,1);
    end
end

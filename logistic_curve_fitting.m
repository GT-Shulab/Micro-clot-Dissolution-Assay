clc
clear all
close all

%% Load Outputs from fibrin analysis
load('IntensityOutput_DD-Month-YYYY.mat');

%% User Inputs
scan_frequency = 1; % in hours
time = 0+scan_frequency*(0:num_frames-1);

%% Initialize Outputs
rsquared = zeros(length(filenames),1);

%% Curve Fitting
% d+(a-d)/(1+(x/c)^(b))
normalized_intensity = (avg_pixel_intensity./background_intensity)*100;

for i = 1:1:length(filenames) 
    
    x = time;
    y = normalized_intensity(i,:);
    [cfit, gof] = FourPL2(x,y);
    coeff(i,:) = coeffvalues(cfit);
    rsquared(i) = gof.rsquare;
    title('R2 = ',rsquared(i));
    
end
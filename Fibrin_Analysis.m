clc
clear all
close all

%% User inputs
% Check these variables prior to any analysis and change if necessary
num_frames = 170;
scan_frequency = 1; % in hours
time = 0+scan_frequency*(0:num_frames-1);

%% Load videos
% Locate all .mp4 videos in the same folder as this script
mp4_files = dir('*.mp4');
filenames = {mp4_files.name};

%% Define script outputs
avg_pixel_intensity = zeros(length(filenames), num_frames);
background_intensity = zeros(length(filenames),1);

%% Image Analysis
% Each video will be filtered and analyzed in this loop
for i = 1:1:length(filenames)
    
    % Separate video into individual frames
    video_name = filenames{i};
    video = VideoReader(video_name);
    y=0;
    frameSet=[];
    
    while hasFrame(video)
        y=y+1;
        frame=readFrame(video);
        frame=rgb2gray(frame);
        frameSet=[frameSet, {frame}]; % Creates a cell array with all the frames of the video in it.
    end
    
    % Create a morphological filter based on the first frame - separate
    % fibrin from background
    first_img = frameSet{1};
    first_img = imbinarize(first_img);
    first_img = imcomplement(first_img); % Inverts binary image
    SE=strel('disk',5);
    first_img = imclose(first_img, SE); % Removes small black spaces
    first_img = imfill(first_img,'holes'); % Fills in holes in mask
    filter_img = imopen(first_img,SE); % Removes small white spaces outside main mask
    filter_img = bwareafilt(filter_img,1); % Isolate largest object
    figure, subplot(1,2,1), imshow(filter_img), subplot(1,2,2), imshow(frameSet{1})
    filter = uint8(filter_img);
    inverse_filter = 1 - filter;
    
    % Apply filter to all other frames in video
    for j = 1:1:length(frameSet)
        filtered_img = filter.*(frameSet{j});
        
        % Calculate average pixel intensity
        avg_pixel_intensity(i,j) = sum(sum(filtered_img))/sum(sum(filter));
        
        % Save background intensity for the each image
        background = inverse_filter.*(frameSet{j});
        background_intensity(i,j) = sum(sum(background))/sum(sum(inverse_filter));
    end

end

%% Save Outputs
outputfile=['IntensityOutput_',datestr(now, 'dd-mmm-yyyy')];
save(outputfile,'filenames','avg_pixel_intensity','background_intensity','num_frames')
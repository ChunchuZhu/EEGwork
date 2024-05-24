% EEG Walking Data Analysis
close all
clear
clc

%% Load Data
folderPath = 'Exp2';

filePattern = fullfile(folderPath, '*.csv');
txtFiles = dir(filePattern);

for k = 1:length(txtFiles)
    baseFileName = txtFiles(k).name;
    fullFileName = fullfile(folderPath, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    data = readmatrix(fullFileName);
    [~, name, ~] = fileparts(baseFileName);
    
    % Add "Trial" prefix to the variable name
    variableName = ['Trial' name];
    
    % Create a structure and assign fields
    trialData.Vicon = -data(:,71:79);
    % 32 channels
    EEGdata = data(:,34:65); 
    % 23 useful channels
    trialData.EEG = [EEGdata(:,2:4),EEGdata(:,6:9),EEGdata(:,11:15),EEGdata(:,19:20),EEGdata(:,22:26),EEGdata(:,28:31)];
    
    trialData.IMU_1 = data(:,4:12);
    trialData.IMU_2 = data(:,13:21); 
    trialData.IMU_3 = data(:,22:30); 
    % IMU Order
    % Angular velocity / Linear acc / Euler angle
    % Save the structure in the workspace with the new variable name
    assignin('base', variableName, trialData);
end


%%
% vicon_data = Trial9.Vicon;
% 
% figure(111)
% clf
% axis([-2000 1000 -4000 2000])
% 
% hold on
% for i = 1:10:length(vicon_data)
%     line([vicon_data(i,1) vicon_data(i,4)], [vicon_data(i,2) vicon_data(i,5)],'color','blue','linewidth',2)
%     line([vicon_data(i,1) vicon_data(i,7)], [vicon_data(i,2) vicon_data(i,8)],'color','blue','linewidth',2)
%     line([vicon_data(i,7) vicon_data(i,4)], [vicon_data(i,8) vicon_data(i,5)],'color','blue','linewidth',2)
%     pause(0.01)
% end
% 

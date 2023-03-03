clc; clear all; close all;

files = {'alp_8_HL_pi_new_v1.txt', ...
        'alp_8_HL_pi_new_v2.txt', ...
        'alp_8_HL_pi_new_v3.txt', ...
        'alp_8_HL_pi_new_v4.txt', ...
        'alp_8_HL_pi_new_v5.txt', ...
        'alp_8_HL_pi_new_v6.txt', ...
        'alp_8_LH_pi_im_v1.txt', ...
        'alp_8_LH_pi_im_v2.txt', ...
        'alp_8_LH_pi_im_v3.txt', ...
        'alp_8_LH_pi_im_v4.txt', ...
        'alp_8_LH_pi_im_v5.txt', ...
        'alp_8_LH_pi_im_v6.txt', ...      
        };

train_file = {'train.txt', ...         
        };

colors = {[0, 0.4470, 0.7410], ... % blue
          [0.8500, 0.3250, 0.0980], ... % orange
          [0.9290, 0.6940, 0.1250], ... % yellow
          [0.4940, 0.1840, 0.5560], ... % purple
          [0.4660, 0.6740, 0.1880], ... % green
          [0.3010, 0.7450, 0.9330]}; % light blue

nfiq2_scores = {};
train_nfiq2_scores = {};

% read train nfiq2 scores
fid = fopen(['NFIQ2_Scores/' train_file{1}]);
data = textscan(fid,'%s%d%f%f%d%d','delimiter',';','HeaderLines',1);
fclose(fid);
train_nfiq2_scores{1} = data{2};

for i=1:length(files)
    fid = fopen(['NFIQ2_Scores/' files{i}]);
    data = textscan(fid,'%s%d%f%f%d%d','delimiter',';','HeaderLines',1);
    fclose(fid);
    nfiq2_scores{i} = data{2};
    avg_nfiq2_scores(i) = int32(mean(data{2}));
end



plot_nfiq2_scores(1, 6, {'alp 8 HL1','alp 8 HL2','alp 8 HL3','alp 8 HL4','alp 8 HL5','alp 8 HL6','Train'}, nfiq2_scores, train_nfiq2_scores, colors);
plot_nfiq2_scores(7, 12, {'alp 8 LH1','alp 8 LH2','alp 8 LH3','alp 8 LH4','alp 8 LH5','alp 8 LH6','Train'}, nfiq2_scores, train_nfiq2_scores, colors);

function plot_nfiq2_scores(start_idx, end_idx, legend_text, nfiq2_scores, train_nfiq2_scores, colors)
    % Create a new figure
    % Allow multiple plots to be added to the figure
    % Add a grid to the plot
    figure; hold on; grid on;

    counter = 1; % initialize counter variable

    % Loop through the specified datasets
    for i=start_idx:end_idx
        % Convert the NFIQ2 scores to double precision
        nfiq2_scores{i} = double(nfiq2_scores{i});
        % Use a kernel smoothing density estimator to smooth the histogram plot
        [f,xi] = ksdensity(nfiq2_scores{i});

        % Define a color for the plot based on which dataset is being plotted
        col = colors{counter};

        % increment counter
        counter = counter + 1;

        plot(xi,5*f,'-','LineWidth',2,'Color',col);
    end
    
    train_nfiq2_scores{1} = double(train_nfiq2_scores{1});
    [f,xi] = ksdensity(train_nfiq2_scores{1});
    plot(xi,5*f,'-','LineWidth',2,'Color',[0.6350, 0.0780, 0.1840]); % dark red

    set(gca,'Box','off','FontSize',16);
    [h_legend,~] = legend(legend_text);
    set(h_legend,'FontSize',16,'Location','northeast');
    legend boxoff;
    xlim([0 100]);
    ylim([0 0.5]);
    xlabel('NFIQ2 Scores','FontSize', 16) 
    ylabel('Relative Frequency','FontSize', 16) 
    tightfig;
end
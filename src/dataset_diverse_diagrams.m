clc; clear all; close all;

base_path = '/home/srinath/Documents/git/matlab_eval/diverse/';

files = {'comparisons_train_test.csv', ...
        'comparisons_train_val.csv', ...
        'comparisons_val_test.csv', ...
        };

colors = {[0, 0.4470, 0.7410], ... % blue
          [0.8500, 0.3250, 0.0980], ... % orange
          [0.9290, 0.6940, 0.1250], ... % yellow
          [0.4940, 0.1840, 0.5560], ... % purple
          [0.4660, 0.6740, 0.1880], ... % green
          [0.3010, 0.7450, 0.9330], ... % light blue
          [1, 0.4, 0.7]}; % pink


mae_scores = {};

delimiter = ',';



for i=1:length(files)
    file_path = fullfile(base_path, files{i});
    data = readmatrix(file_path, 'Delimiter', delimiter);
    mae_scores{i} = data(:, 3);
end


plot_nfiq2_scores(1, 3, {'Train vs Test','Train vs Val','Test  vs Val'}, mae_scores, colors, 'mae_diverse.png');




function plot_nfiq2_scores(start_idx, end_idx, legend_text, mae_scores, colors, figname)
    % Create a new figure
    % Allow multiple plots to be added to the figure
    % Add a grid to the plot
    fig = figure('Visible', 'off'); hold on; grid on;

    counter = 1; % initialize counter variable

    % Loop through the specified datasets
    for i=start_idx:end_idx
        % Convert the NFIQ2 scores to double precision
        mae_scores{i} = double(mae_scores{i});
        % Use a kernel smoothing density estimator to smooth the histogram plot
        [f,xi] = ksdensity(mae_scores{i});

        % Define a color for the plot based on which dataset is being plotted
        col = colors{counter};

        % increment counter
        counter = counter + 1;

        plot(xi,5*f,'-','LineWidth',2,'Color',col);
    end
    
%      train_nfiq2_scores{1} = double(train_nfiq2_scores{1});
%      [f,xi] = ksdensity(train_nfiq2_scores{1});
%      plot(xi,5*f,'-','LineWidth',2,'Color',[0.6350, 0.0780, 0.1840]); % dark red

    set(gca,'Box','off','FontSize',16);
    [h_legend,~] = legend(legend_text);
%     h_legend.ItemSpacing = 0.5;
    set(h_legend,'FontSize',16,'Location','northeast');
    legend boxoff;
%     xlim([0 100]);
    ylim([0 0.3]);
    xlim([0 300]);
    xticks(0:50:300);
%     xticklabels({'0', '10', '20', '30', '40', '50', '60', '70', '80', '90', '100'});
%     ylim([0 1]);
%     yticks(0:0.1:1);
%     yticklabels({'0', '0.1', '0.2', '0.3', '0.4', '0.5', '0.6', '0.7', '0.8', '0.9', '1.0'});
    xlabel('Mean Absolute Error','FontSize', 16) 
    ylabel('Relative Frequency','FontSize', 16) 
    tightfig;

    % Set the figure size and save the figure
    fig.Position(3:4) = [1000 850]; % set the width and height in pixels

    % Concatenate root path and figure name
    fig_path = fullfile('/home/srinath/Documents/srinath/Master_Thesis/diagrams/experiments/matlab/dataset_diverse/', figname);

    % Save the figure as a high-resolution PNG image
    print(fig, fig_path, '-dpng', '-r500');
end
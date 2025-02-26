clc; clear all; close all;

base_path = '/home/srinath/Documents/git/matlab_eval/psnr_scores/';

files = {'alp_8_HL_pi_new_v1_ep_latest_psnr.csv', ...
        'alp_8_HL_pi_new_v2_ep_latest_psnr.csv', ...
        'alp_8_HL_pi_new_v3_ep_latest_psnr.csv', ...
        'alp_8_HL_pi_new_v4_ep_latest_psnr.csv', ...
        'alp_8_HL_pi_new_v5_ep_latest_psnr.csv', ...
        'alp_8_HL_pi_new_v6_ep_latest_psnr.csv', ...
        'alp_8_LH_pi_im_v1_ep_latest_psnr.csv', ...
        'alp_8_LH_pi_im_v2_ep_latest_psnr.csv', ...
        'alp_8_LH_pi_im_v3_ep_latest_psnr.csv', ...
        'alp_8_LH_pi_im_v4_ep_latest_psnr.csv', ...
        'alp_8_LH_pi_im_v5_ep_latest_psnr.csv', ...
        'alp_8_LH_pi_im_v6_ep_latest_psnr.csv', ...
        'alp_10_HL_pi_im_v1_ep_latest_psnr.csv', ...
        'alp_10_HL_pi_im_v2_ep_latest_psnr.csv', ...
        'alp_10_HL_pi_im_v3_ep_latest_psnr.csv', ...
        'alp_10_HL_pi_im_v4_ep_latest_psnr.csv', ...
        'alp_10_HL_pi_im_v5_ep_latest_psnr.csv', ...
        'alp_10_HL_pi_im_v6_ep_latest_psnr.csv', ...
        'alp_10_LH_pi_im_v1_ep_latest_psnr.csv', ...
        'alp_10_LH_pi_im_v2_ep_latest_psnr.csv', ...
        'alp_10_LH_pi_im_v3_ep_latest_psnr.csv', ...
        'alp_10_LH_pi_im_v4_ep_latest_psnr.csv', ...
        'alp_10_LH_pi_im_v5_ep_latest_psnr.csv', ...
        'alp_10_LH_pi_im_v6_ep_latest_psnr.csv', ...
        };

colors = {[0, 0.4470, 0.7410], ... % blue
          [0.8500, 0.3250, 0.0980], ... % orange
          [0.9290, 0.6940, 0.1250], ... % yellow
          [0.4940, 0.1840, 0.5560], ... % purple
          [0.4660, 0.6740, 0.1880], ... % green
          [0.3010, 0.7450, 0.9330], ... % light blue
          [1, 0.4, 0.7]}; % pink


psnr_scores = {};

delimiter = ',';



for i=1:length(files)
    file_path = fullfile(base_path, files{i});
    data = readmatrix(file_path, 'Delimiter', delimiter);
    psnr_scores{i} = data(:, 3);
end


plot_nfiq2_scores(1, 6, {'Model-1','Model-2','Model-3','Model-4','Model-5','Model-6'}, psnr_scores, colors, 'figure1.png');
plot_nfiq2_scores(7, 12, {'Model-7','Model-8','Model-9','Model-10','Model-11','Model-12'}, psnr_scores, colors, 'figure2.png');
plot_nfiq2_scores(13, 18, {'Model-13','Model-14','Model-15','Model-16','Model-17','Model-18'}, psnr_scores, colors, 'figure3.png');
plot_nfiq2_scores(19, 24, {'Model-19','Model-20','Model-21','Model-22','Model-23','Model-24'}, psnr_scores, colors, 'figure4.png');




function plot_nfiq2_scores(start_idx, end_idx, legend_text, psnr_scores, colors, figname)
    % Create a new figure
    % Allow multiple plots to be added to the figure
    % Add a grid to the plot
    fig = figure('Visible', 'off'); hold on; grid on;

    counter = 1; % initialize counter variable

    % Loop through the specified datasets
    for i=start_idx:end_idx
        % Convert the NFIQ2 scores to double precision
        psnr_scores{i} = double(psnr_scores{i});
        % Use a kernel smoothing density estimator to smooth the histogram plot
        [f,xi] = ksdensity(psnr_scores{i});

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
%     ylim([0 1.2]);
    xlim([20 40]);
    xticks(0:3:40);
%     xticklabels({'0', '10', '20', '30', '40', '50', '60', '70', '80', '90', '100'});
%     ylim([0 1]);
%     yticks(0:0.1:1);
%     yticklabels({'0', '0.1', '0.2', '0.3', '0.4', '0.5', '0.6', '0.7', '0.8', '0.9', '1.0'});
    xlabel('PSNR','FontSize', 16) 
    ylabel('Relative Frequency','FontSize', 16) 
    tightfig;

    % Set the figure size and save the figure
    fig.Position(3:4) = [1000 850]; % set the width and height in pixels

    % Concatenate root path and figure name
    fig_path = fullfile('/home/srinath/Documents/srinath/Master_Thesis/diagrams/experiments/matlab/psnr_scores/', figname);

    % Save the figure as a high-resolution PNG image
    print(fig, fig_path, '-dpng', '-r500');
end
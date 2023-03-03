clc; clear all; close all;

files = {'nfiq2_scores_Anguli_aug_CM_DL_39k_filtered_v2_ep15.txt', ...
        'nfiq2_scores_Anguli_aug_CM_DL_39k_filtered_v2_ep30.txt', ...
        'nfiq2_scores_Anguli_aug_CM_DL_39k_filtered_v2_ep55.txt', ...
        'nfiq2_scores_Anguli_aug_CM_PM_39k_filtered_v1_ep15.txt', ...
        'nfiq2_scores_Anguli_aug_CM_PM_39k_filtered_v1_ep30.txt', ...
        'nfiq2_scores_Anguli_aug_CM_PM_39k_filtered_v1_ep55.txt', ...
        'nfiq2_scores_Anguli_cm_DL_50k_v3_ep15.txt', ...
        'nfiq2_scores_Anguli_cm_DL_50k_v3_ep30.txt', ...
        'nfiq2_scores_Anguli_cm_DL_50k_v3_ep55.txt', ...
        'nfiq2_scores_Anguli_cm_PM_50k_v2_ep15.txt', ...
        'nfiq2_scores_Anguli_cm_PM_50k_v2_ep30.txt', ...
        'nfiq2_scores_Anguli_cm_PM_50k_v2_ep55.txt', ...
        'nfiq2_scores_URU_aug_cm_DL_50k_v3_ep15.txt', ...
        'nfiq2_scores_URU_aug_cm_DL_50k_v3_ep30.txt', ...
        'nfiq2_scores_URU_aug_cm_DL_50k_v3_ep55.txt', ...
        'nfiq2_scores_URU_aug_CM_DL_39k_filtered_v2_ep15.txt', ...
        'nfiq2_scores_URU_aug_CM_DL_39k_filtered_v2_ep30.txt', ...
        'nfiq2_scores_URU_aug_CM_DL_39k_filtered_v2_ep55.txt', ...        
        'nfiq2_scores_URU_aug_cm_PM_50k_v2_ep15.txt', ...
        'nfiq2_scores_URU_aug_cm_PM_50k_v2_ep30.txt', ...
        'nfiq2_scores_URU_aug_cm_PM_50k_v2_ep55.txt', ...     
        'nfiq2_scores_URU_aug_CM_PM_39k_filtered_v1_ep15.txt', ...
        'nfiq2_scores_URU_aug_CM_PM_39k_filtered_v1_ep30.txt', ...
        'nfiq2_scores_URU_aug_CM_PM_39k_filtered_v1_ep55.txt', ...
        'nfiq2_scores_Anguli.txt', ...
        'nfiq2_scores_URU.txt', ...         
        };

nfiq2_scores = {};

for i=1:length(files)
    fid = fopen(['OLD_NFIQ2_Scores/' files{i}]);
    data = textscan(fid,'%s%d%f%f%d%d','delimiter',';','HeaderLines',1);
    fclose(fid);
    nfiq2_scores{i} = data{2};
    avg_nfiq2_scores(i) = int32(mean(data{2}));
end
    
bins = 0:1:100;

figure; hold on; grid on;
for i=1:6 % aug39k Anguli
    %histogram(nfiq2_scores{i},bins,'Normalization','probability','DisplayStyle','stairs');
    nfiq2_scores{i} = double(nfiq2_scores{i});
    [f,xi] = ksdensity(nfiq2_scores{i});
    if i<4 
        col = [0, 0.4470, 0.7410];
    else
        col = [0.8500, 0.3250, 0.0980];
    end
    if mod(i,3) == 1
      plot(xi,5*f,'-','LineWidth',2,'Color',col);
    elseif mod(i,3) == 2
      plot(xi,5*f,':','LineWidth',2,'Color',col);
    elseif mod(i,3) == 0
      plot(xi,5*f,'--','LineWidth',2,'Color',col);  
    end      
end
nfiq2_scores{25} = double(nfiq2_scores{25});
[f,xi] = ksdensity(nfiq2_scores{25});
plot(xi,5*f,'-','LineWidth',2,'Color',[0.4660 0.6740 0.1880]); 
    
set(gca,'Box','off','FontSize',16);
[h_legend,~] =legend('DL 15','DL 30','DL 55','PM 15','PM 30','PM 55','Anguli');
set(h_legend,'FontSize',16,'Location','northeast');
legend boxoff;
xlim([10 80]);
ylim([0 0.5]);
xlabel('NFIQ2 Scores','FontSize', 16) 
ylabel('Relative Frequency','FontSize', 16) 
tightfig;

figure; hold on; grid on;
for i=7:12 %syn50k Anguli
    %histogram(nfiq2_scores{i},bins,'Normalization','probability','DisplayStyle','stairs');
    nfiq2_scores{i} = double(nfiq2_scores{i});
    [f,xi] = ksdensity(nfiq2_scores{i});
    if i<10 
        col = [0, 0.4470, 0.7410];
    else
        col = [0.8500, 0.3250, 0.0980];
    end
    if mod(i,3) == 1
      plot(xi,5*f,'-','LineWidth',2,'Color',col);
    elseif mod(i,3) == 2
      plot(xi,5*f,':','LineWidth',2,'Color',col);
    elseif mod(i,3) == 0
      plot(xi,5*f,'--','LineWidth',2,'Color',col);  
    end
end
[f,xi] = ksdensity(nfiq2_scores{25});
plot(xi,5*f,'-','LineWidth',2,'Color',[0.4660 0.6740 0.1880]); 
    
set(gca,'Box','off','FontSize',16);
h_legend =legend('DL 15','DL 30','DL 55','PM 15','PM 30','PM 55','Anguli');
set(h_legend,'FontSize',16,'Location','northeast');
legend boxoff;
xlim([10 80]);
ylim([0 0.5]);
xlabel('NFIQ2 Scores','FontSize', 16) 
ylabel('Relative Frequency','FontSize', 16) 
tightfig;

figure; hold on; grid on;
for i=13:18 %aug39k URU
    %histogram(nfiq2_scores{i},bins,'Normalization','probability','DisplayStyle','stairs');
    nfiq2_scores{i} = double(nfiq2_scores{i});
    [f,xi] = ksdensity(nfiq2_scores{i});
    if i<16 
        col = [0, 0.4470, 0.7410];
    else
        col = [0.8500, 0.3250, 0.0980];
    end
    if mod(i,3) == 1
      plot(xi,5*f,'-','LineWidth',2,'Color',col);
    elseif mod(i,3) == 2
      plot(xi,5*f,':','LineWidth',2,'Color',col);
    elseif mod(i,3) == 0
      plot(xi,5*f,'--','LineWidth',2,'Color',col);  
    end   
end
nfiq2_scores{26} = double(nfiq2_scores{26});
[f,xi] = ksdensity(nfiq2_scores{26});
plot(xi,5*f,'-','LineWidth',2,'Color',[0.4660 0.6740 0.1880]);
    
set(gca,'Box','off','FontSize',16);
h_legend =legend('DL 15','DL 30','DL 55','PM 15','PM 30','PM 55','URU');
set(h_legend,'FontSize',16,'Location','northeast');
legend boxoff;
xlim([10 80]);
ylim([0 0.5]);
xlabel('NFIQ2 Scores','FontSize', 16) 
ylabel('Relative Frequency','FontSize', 16) 
tightfig;

figure; hold on; grid on;
for i=19:24 %syn50k URU
    %histogram(nfiq2_scores{i},bins,'Normalization','probability','DisplayStyle','stairs');
    nfiq2_scores{i} = double(nfiq2_scores{i});
    [f,xi] = ksdensity(nfiq2_scores{i});
    if i<22 
        col = [0, 0.4470, 0.7410];
    else
        col = [0.8500, 0.3250, 0.0980];
    end
    if mod(i,3) == 1
      plot(xi,5*f,'-','LineWidth',2,'Color',col);
    elseif mod(i,3) == 2
      plot(xi,5*f,':','LineWidth',2,'Color',col);
    elseif mod(i,3) == 0
      plot(xi,5*f,'--','LineWidth',2,'Color',col);  
    end    
end
nfiq2_scores{26} = double(nfiq2_scores{26});
[f,xi] = ksdensity(nfiq2_scores{26});
plot(xi,5*f,'-','LineWidth',2,'Color',[0.4660 0.6740 0.1880]);
    
set(gca,'Box','off','FontSize',16);
h_legend =legend('DL 15','DL 30','DL 55','PM 15','PM 30','PM 55','URU');
set(h_legend,'FontSize',16,'Location','northeast');
legend boxoff;
xlim([10 80]);
ylim([0 0.5]);
xlabel('NFIQ2 Scores','FontSize', 16) 
ylabel('Relative Frequency','FontSize', 16)  
tightfig;
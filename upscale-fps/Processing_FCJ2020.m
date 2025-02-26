clear all; close all; clc;

addpath('/home/srinath/Documents/srinath/Master_Thesis/conferences/visaap-post-pub-24/dataset/test-dataset/fp_enhancement');

%blksze = 8;
%augmentation = {'raw','hf','rot5','rot10','rot15','rot20','rot-5','rot-10','rot-15','rot-20',...
%    'hfrot5','hfrot10','hfrot15','hfrot20','hfrot-5','hfrot-10','hfrot-15','hfrot-20'};

input_file_format = 'bmp';
output_file_format = 'png';

db_folder = '/home/srinath/Documents/srinath/Master_Thesis/conferences/visaap-post-pub-24/dataset/test-dataset/bmp_nfiq_data/';
% read images (recursively)
input_folders = { ...
  [db_folder 'test10k'], ... 
};

output_folder = '/home/srinath/Documents/srinath/Master_Thesis/conferences/visaap-post-pub-24/dataset/test-dataset/upscaled-fps10k';
if exist('augmentation','var')
  output_folder = [output_folder '_aug'];  
end    
if ~exist(output_folder, 'dir')
  mkdir(output_folder);
end


for j = 1:length(input_folders)
  files = dir([input_folders{j} '/*.' input_file_format]);
  num_files = length(files);

  % print the number of files
  disp(['number of files: ' num2str(num_files)]);
    
  % processing 
  for i = 1:num_files
    disp(['processing: (' num2str(i) '/' num2str(num_files) '): ' files(i).name]);
    try  
      filename = [files(i).folder '/' files(i).name];
      I = imread( filename );    
    catch err
      disp('error reading file!');
      continue;
    end     
    
    %[I_norm, mask] = ridgesegment(im2bw(I), blksze, 0.1);
    mask = (imbinarize(I) == 0);
    vertical = any(mask, 2);
    horizontal = any(mask, 1);
    row1 = find(vertical, 1, 'first'); % Y1
    row2 = find(vertical, 1, 'last'); % Y2
    column1 = find(horizontal, 1, 'first'); % X1
    column2 = find(horizontal, 1, 'last'); % X2
    I_cent{1} = I(row1:row2, column1:column2);
    I_cent{1} = imresize(I_cent{1}, 1.2);

    if exist('augmentation','var')      
      I_cent{2} = flipdim(I_cent{1}, 2); % horizontal flip

      for k=1:4 
        I_cent{2+k} = imrotate(I_cent{1}, 5*k, 'nearest', 'loose');
        shape = ~imrotate(true(size(I_cent{1})), 5*k, 'nearest', 'loose');
        I_cent{2+k}(shape & ~imclearborder(I_cent{2+k})) = 255;      
        I_cent{2+k} = I_cent{2+k}( 1 : min(size(I_cent{2+k},1), 512),   1 : min(size(I_cent{2+k},2), 512) );
      end
      
      for k=1:4 
        I_cent{6+k} = imrotate(I_cent{1}, -5*k, 'nearest', 'loose');
        shape = ~imrotate(true(size(I_cent{1})), -5*k, 'nearest', 'loose');
        I_cent{6+k}(shape & ~imclearborder(I_cent{6+k})) = 255;
        I_cent{6+k} = I_cent{6+k}( 1 : min(size(I_cent{6+k},1), 512),   1 : min(size(I_cent{6+k},2), 512) );        
      end       
      
      for k=1:4 
        I_cent{10+k} = imrotate(I_cent{2}, 5*k, 'nearest', 'loose');
        shape = ~imrotate(true(size(I_cent{2})), 5*k, 'nearest', 'loose');
        I_cent{10+k}(shape & ~imclearborder(I_cent{10+k})) = 255;
        I_cent{10+k} = I_cent{10+k}( 1 : min(size(I_cent{10+k},1), 512),   1 : min(size(I_cent{10+k},2), 512) );        
      end      
      
       for k=1:4 
        I_cent{14+k} = imrotate(I_cent{2}, -5*k, 'nearest', 'loose');
        shape = ~imrotate(true(size(I_cent{2})), -5*k, 'nearest', 'loose');
        I_cent{14+k}(shape & ~imclearborder(I_cent{14+k})) = 255;
        I_cent{14+k} = I_cent{14+k}( 1 : min(size(I_cent{14+k},1), 512),   1 : min(size(I_cent{14+k},2), 512) );                
      end
    end
    
    for l=1:length(I_cent)
      dim = size(I_cent{l});
      % print the size of the image
      disp([ num2str(dim(1)) ', ' num2str(dim(2) ) ]);
      I_norm = padarray(I_cent{l},[round((512-dim(1))/2) round((512-dim(2))/2)], 255, 'both');
      %disp([ num2str(size(I_norm,1)) ', ' num2str(size(I_norm,1)) ]);
      I_norm = I_norm(1:512,1:512);  
      %imwrite(I_norm, [output_folder '\fcj2020' num2str(j) '_' files(i).name(1:end-4) '_' augmentation{l} '.' output_file_format], output_file_format);
      imwrite(I_norm, [output_folder '/fcj2020' num2str(j) '_' files(i).name(1:end-4) '.' output_file_format], output_file_format);
    end
  end
end

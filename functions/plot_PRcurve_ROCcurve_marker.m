function [ PR, ROC, hPR, hROC, sorted_score ] = plot_PRcurve_ROCcurve_marker( label, dist, PRfignum, ROCfignum ,marker)
%PLOT_PRECISION_RECALL 
%label: correct=1, incorrect=0
%dist: score of sample distance/ratio
% 

if nargin == 2
    PRfignum = 1;
    ROCfignum = 2;
end


samplenum = size(label, 2);
TPFN = sum(label);
FPTN = sum(label==0);

[sorted_score, idx] = sort(dist, 'ascend');
sorted_score = [0, sorted_score, 1];
label = label(idx);

%output
PR = zeros(2, samplenum);%[1 - precision; recall]
ROC = zeros(2, samplenum);

TPFP = 1:1:samplenum;
TP = cumsum(label);
FP = cumsum(label==0);

PR(1, :) = FP ./ TPFP;%1-precision
PR(2, :) = TP / TPFN;%recall
PR  = [[0; 0], PR, [1; 1]];

ROC(1, :) = TP / TPFN;%TP rate(=recall)
ROC(2, :) = FP / FPTN;%FP rate
ROC = [[0; 0], ROC, [1; 1]];

% for TPFP = 1:1:samplenum
%     TP = sum(label(1:TPFP) == 1);
%     repr(1, TPFP) = TP / TPFN;%recall 
%     repr(2, TPFP) = 1.0 - TP / TPFP;%1-precision
% end

figure(PRfignum);
hPR = plot(PR(2, 1:5:end), 1-PR(1, 1:5:end), marker, 'LineWidth', 2);
ylabel('Precision');
xlabel('Recall');
hold on;

figure(ROCfignum);
hROC = plot(ROC(2, 1:5:end), ROC(1, 1:5:end), marker, 'LineWidth', 2);
xlabel('False Positive rate');
ylabel('True Positive rate');
hold on;

end


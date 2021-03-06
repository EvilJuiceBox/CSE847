close all
clear 

load('ad_data.mat')
load('feature_name.mat')

par  = [1e-8, 0.01, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1];
auct = [];
for i = 1 : size(par, 2)  
    [w,c] = logistic_l1_train(X_train, y_train, par(i));
%     disp("--- Experiment: par = " + par(i) + " ---------");
    
    result = X_train*w + c;
    result(result<0) = -1;
    result(result>0) = 1;
    
    perCorrectTrain = getCorrect(result, y_train)/size(y_train, 1);
%     disp("Number of features = " + nnz(w));
%     disp("Correct count out of 172 training points = " + getCorrect(result, y_train) + "; Percentage: " + getCorrect(result, y_train)/size(y_train, 1));

%     nexttile
%     hold on
% 
%     [X,Y] = perfcurve(result, y_train, 1);
    predictions = X_test*w + c;
    testres = X_test*w + c;
    testres(testres<0) = -1;
    testres(testres>0) = 1;
    [xp, yp, tp, auc] = perfcurve(y_test, predictions, 1);
    perCorrectTest = getCorrect(testres, y_test)/size(y_test, 1);
%     disp("Correct predictions out of 74: " + getCorrect(y_test, testres) + "; Percentage: " + getCorrect(testres, y_test)/size(y_test, 1));

%     [Xtest,Ytest] = perfcurve(testres, y_test, 1);
% 
%     plot(Xtest, Ytest);
%     hold off
    
%     disp(" ");
    fprintf('Par=%1.1f: \t', par(i));
    fprintf('Weights:%3i \t', nnz(w));
    fprintf('Accuracy:%1.5f \t', getCorrect(testres, y_test)/size(y_test, 1));
    fprintf('AUC:%1.5f \n', auc);
    auct = [auct auc];
%     disp("Par=" + par(i) +":  Non-zero weights: " + nnz(w) + "    Accuracy:" + getCorrect(testres, y_test)/size(y_test, 1) + ",AUC: " + auc);
end

plot(par, auct);
xlabel("par value");
ylabel("Area under the curve");
title("PAR vs AUC");



function num = getCorrect(first, second)
    correct = 0;
    for i = 1 : size(first, 1)
       if(first(i) == second(i))
           correct = correct + 1;
       end
    end
    num = correct;
end

function [w, c] = logistic_l1_train(data, labels, par)
    % OUTPUT w is equivalent to the first d dimension of weights in logistic train
    % c is the bias term, equivalent to the last dimension in weights in logistic train.
    % Specify the options (use without modification).
    opts.rFlag = 1; % range of par within [0, 1].
    opts.tol = 1e-6; % optimization precision
    opts.tFlag = 4; % termination options.
    opts.maxIter = 5000; % maximum iterations.
    [w, c] = LogisticR(data, labels, par, opts);
end




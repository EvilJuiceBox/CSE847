close all
clear 

X = importdata('data.txt', ' ', 0);
Y = importdata('labels.txt', ' ', 0);
X = normalize(X);
X = horzcat(X, ones(size(X, 1), 1));

% weights = logistic_train(X, Y, 1e-5, 1000);
% res = X*weights;
% 
% solutions = getSig(res);
% temp = [Y res solutions'];
% 
% disp(temp(1:25,:));
% 
% solutions(solutions<0.5) = 0;
% solutions(solutions>=0.5) = 1;

% disp("Number of correct predictions: " + getCorrect(solutions', Y));


experiment = [200, 500, 800, 1000, 1500, 2000];
expres = [];
for i = 1: size(experiment, 2)
    [x_train, x_test, y_train, y_test] = split(X, Y, experiment(i));
    weights = logistic_train(x_train, y_train, 1e-5, 1000);

    restest = x_test*weights;

    solutions = getSig(restest);
    temp = [y_test restest solutions'];

    solutions(solutions<=0.5) = 0;
    solutions(solutions>0.5) = 1;

    [xp, yp, tp, auc] = perfcurve(y_test, restest, 1);
    
    fprintf('Training Set Size=%4i: \t', experiment(i));
    fprintf('Correct:%4i \t', getCorrect(solutions', y_test));
    fprintf('Total:%4i \t', size(y_test, 1));
    fprintf('Accuracy:%1.5f \t', getCorrect(solutions', y_test)/size(y_test, 1));
    fprintf('AUC:%1.5f \n', auc);
%     disp("Number of correct predictions: " + getCorrect(solutions', y_test) + " out of " + size(y_test, 1) + " = " + getCorrect(solutions', y_test)/size(y_test, 1));
    expres(i) = getCorrect(solutions', y_test)/size(y_test, 1);
    
    
end

plot(log(experiment), expres);
disp("-----------------");


function [x_train, x_test, y_train, y_test] = split(X, Y, n)
    x_train = X(1:n,:);
    x_test = X(n+1:4601,:);
    y_train = Y(1:n,:);
    y_test = Y(n+1:4601,:);
end
% code to train a logistic regression classifier
%
% INPUTS:
% data = n * (d+1) matrix withn samples and d features, where
%   column d+1 is all ones (corresponding to the intercept term)
% labels = n * 1 vector of class labels (taking values 0 or 1)
% epsilon = optional argument specifying the convergence
%   criterion - if the change in the absolute difference in
%   predictions, from one iteration to the next, averaged across
%   input features, is less than epsilon, then halt
%   (if unspecified, use a default value of 1e-5)
% maxiter = optional argument that specifies the maximum number of
%    iterations to execute (useful when debugging in case your
%    code is not converging correctly!)
%   (if unspecified can be set to 1000)
%
% OUTPUT:
% weights = (d+1) * 1 vector of weights where the weights correspond to
% the columns of "data"
%
function [weights] = logistic_train(data, labels, epsilon, maxiter)
eta = 0.00001;
% eta = 0.01;

weights = zeros(size(data,2), 1);
for i = 1 : maxiter
    temp = weights - eta*( (data'*data)*weights - data'*labels );
    if(abs(temp - weights) > epsilon)
       weights = temp;
       return;
    end
    weights = temp;
end


end

function output = getSig(input)
output = [];
for i = 1 : size(input)
    output(i) = sigmoid(input(i));
end
end

function value = sigmoid(x)
    value = 1 / (1 + exp(-x));
end

function num = getCorrect(first, second)
    correct = 0;
    for i = 1 : size(first, 1)
       if(first(i) == second(i))
           correct = correct + 1;
       end
    end
    num = correct;
end
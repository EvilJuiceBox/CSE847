close all
clear

load USPS.mat

avg = mean(A, 2);
centredPoints = A - avg*ones(1, size(A,2)); % subtract by mean to shift data to centre

[u, sigma, v] = svd(centredPoints, 'econ'); %SVD

%covaraince matrix c, not used in the script
% C = v*(sigma^2 / size(A,2))*v^(-1);

% plot the effects of PC
figure
subplot(1,2,1)
% shows the scale of the singular values (couple big ones, then everything
% else is small)
plot(diag(sigma), 'o','LineWidth', 1)
set(gca,'FontSize',15), axis tight, grid on
title('Magnitude of pc')

subplot(1,2,2)
%shows how much of the variance is being accounted for per pc component.
plot(cumsum(diag(sigma))./sum(diag(sigma)), 'o', 'LineWidth', 1)
set(gca,'FontSize',15), axis tight, grid on
set(gcf,'Position', [100 100 3*600 3*250])
title('PC vs variance accounted');



%use different row input to test the compression.
getReducedImage(A, u, sigma, v, 2)
getReducedImage(A, u, sigma, v, 305)
getReducedImage(A, u, sigma, v, 2000)
getReducedImage(A, u, sigma, v, 2999)

% % Z = XV
% % V = principal components
% % USIGMA = coordinates of the data basis
% 
% figure, hold on
% 
% p = [10, 50, 100, 200];
% 
% %show original imag
% A2 = reshape(A(2,:), 16, 16);
% subplot(1,size(p,2)+1,1), imshow(A2');
% title('Original')
% 
% 
% 
% for i = 1: size(p,2)
%     reducedData = u(:, 1:p(i)) * sigma(1:p(i), 1:p(i)) * v(:, 1:p(i))';
%     reducedData = reducedData + avg*ones(1, size(reducedData,2)); %readjust the axis before displaying
%     
%     temp = reshape(reducedData(2,:), 16, 16);
%     subplot(1,size(p,2)+1,i+1), imshow(temp')
%     title('# of principal components: ' + string(p(i))) %shows each of the pc on a different plot
% end
% set(gcf, 'Position',  [350, 75, 1250, 500])
% hold off
% 
% 
% figure, hold on
% 
% p = [10, 50, 100, 200];
% 
% %show original
% A2000 = reshape(A(2000,:), 16, 16);
% subplot(1,size(p,2)+1,1), imshow(A2000');
% title('Original')
% 
% 
% 
% for i = 1: size(p,2)
%     reducedData = u(:, 1:p(i)) * sigma(1:p(i), 1:p(i)) * v(:, 1:p(i))';
%     
%     temp = reshape(reducedData(2000,:), 16, 16);
%     subplot(1,size(p,2)+1,i+1), imshow(temp')
%     title('# of principal components: ' + string(p(i)))
% end
% set(gcf, 'Position',  [350, 75, 1250, 500])
% hold off

function getReducedImage(A, u, sigma, v, rowNum)
    figure, hold on

    p = [10, 50, 100, 200];

    %show original
    original = reshape(A(rowNum,:), 16, 16);
    subplot(1,size(p,2)+1,1), imshow(original');
    title('Original')



    for i = 1: size(p,2)
        reducedData = u(:, 1:p(i)) * sigma(1:p(i), 1:p(i)) * v(:, 1:p(i))';

        temp = reshape(reducedData(rowNum,:), 16, 16);
        subplot(1,size(p,2)+1,i+1), imshow(temp')
        title('# of principal components: ' + string(p(i)))
    end
    set(gcf, 'Position',  [350, 75, 1250, 500])
    hold off
end

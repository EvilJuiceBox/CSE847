close all
clear

load spectral.mat
load simple.mat


% EXPERIMENT 1, simple set

% randdata = simple;
% [u, sigma, v] = svd(randdata, 'econ'); %SVD
% [idx , C] = kmeans(u, 3);
% regidx = kmeans(randdata,3);
% 
% gscatter(randdata(:,1),randdata(:,2),idx,[0.4940 0.1840 0.5560;1 0 0;0 0.8 0],'*',6)
% title("spectral kmeans")
% figure
% gscatter(randdata(:,1),randdata(:,2),regidx,[0.4940 0.1840 0.5560;1 0 0;0 0.8 0],'o',6)
% title("regular kmeans")

% EXPERIMENT 2, larger data set
randdata = rand(50, 2);
% randomly generate 50 points 2d for testing


[u, sigma, v] = svd(randdata, 'econ'); %SVD
[idx , C] = kmeans(u, 2);
regidx = kmeans(randdata,2);

gscatter(randdata(:,1),randdata(:,2),idx,[0.4940 0.1840 0.5560;1 0 0;0 0.8 0],'*',6)
title("spectral kmeans")
figure
gscatter(randdata(:,1),randdata(:,2),regidx,[0.4940 0.1840 0.5560;1 0 0;0 0.8 0],'o',6)
title("regular kmeans")
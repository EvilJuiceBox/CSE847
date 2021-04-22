close all
clear 

data = [[-5, -7]; [-7, -6]; [-6, -6]; [2, 2]; [1, 1]; [3, 2]; [2, 1]; [1, -4]; [1, -5]; [0, -5]];
points = [[1, 1]; [3, 3]; [5,5]];

test = data;
test(1, :) = [];
% plot(data);

k = 3; 

%centroids are the single point of cluster in middle
    centroids = nan(k,2);
    %cluster are a subset of data, with each index belonging to the cluster
    %of centroid at the same index
    clusters = nan(length(data));
    tempClusters = nan(length(data));
    
    % choose k random inital cluster points
    tempArray = data;
    for i = 1: k
        centroids(i, :) = tempArray(randperm(size(tempArray,1),1), :);
        tempArray(i, :) = [];
    end
    
    
%END 
% [cen, clusters] = custom_kmeans(data, k, 2);



% takes in data vector, and k clusters to make. count of data must be
% greater than k
function [centroids, clusters] = custom_kmeans(data, k, dimensions)
    %centroids are the single point of cluster in middle
    centroids = nan(k, dimensions);
    %cluster are a subset of data, with each index belonging to the cluster
    %of centroid at the same index
    clusters = nan(length(data));
    tempClusters = nan(length(data));
    
    % choose k random inital cluster points
    tempArray = data;
    for i = 1: k
        centroids(i) = tempArray(randperm(size(tempArray,1),1), :);
        tempArray(i, :) = [];
    end
    
    
    change = 1;
    %repeat algorithm until converge
    while change > 0
        
        % sort data into their clusters
        for i = 1: length(data) % dealing with data(i) element
            tempDistanceToCentroids = zeros(1, k);
            for j = 1: k
                tempDistanceToCentroids(j) = getDistance(centroids(j), data(i));
            end
            
            % getting the min index and assigning the point to the centroid
            [minValue, index] = min(tempDistanceToCentroids);
            disp(index);
            tempClusters(index) = [tempClusters(index) data(i)];
        end
        
        
        clusters = tempClusters;
        tempClusters = nan(length(data));
        
        % recalculate centroid location
        for i = 1: length(centroids)
            %gets how much the centroid value has changed
            centroids(i) = mean(clusters(i));
        end
    end
end

function avg = getAverage(points)
    avg = nan(length(points(1)));
    
    % for each dimension
    for i = 1: size(points, 2)
        % sum each points
        temp = 0;
        for j = 1: size(points, 1)
            temp = temp + points(j,i);
        end
        %avg of the corresponding row
        avg(i) = temp / length(points);
    end
end

function distance = getDistance(point1, point2)
    distance = 0;
    for i = 1: length(point1)
        distance = distance + (point1(i) - point2(i))^2;
    end
end

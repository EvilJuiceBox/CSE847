import random
import numpy as np
from matplotlib import pyplot as plt

def kmeans(data, k):
    # select the first set of random centroids
    centroids = random.sample(data, k)

    #create 2d arrays for the clusters
    clusters = []
    tempClusters = []
    for i in range(k):
        clusters.append([])
        tempClusters.append([])


    change = 1
    generation = 1
    while change > 0:
        for i in range(len(data)):
            tempDistanceToCentroid = []
            # find distance to each centroid, use the closest one.
            for j in range(k):
                tempDistanceToCentroid.append(getDistance(centroids[j], data[i]))

            min_index = np.argmin(tempDistanceToCentroid)
            tempClusters[min_index].append(data[i])

        clusters = tempClusters
        tempClusters = []
        for i in range(k):
            tempClusters.append([])

        change = 0
        for i in range(len(centroids)):
            change += abs(getDistance(centroids[i], mean(clusters[i])))
            centroids[i] = mean(clusters[i])


            #prints figures
        # for i in range(len(clusters)):
        #     temp = np.array(clusters[i])
        #     x, y = temp.T

        #     colour = random_color()
        #     plt.scatter(x, y, color=colour)
        #
        #     plt.scatter(centroids[i][0], centroids[i][1], color=colour, marker="*", s=180)
        # plt.savefig("plot"+str(generation)+".png")
        # plt.clf()
        generation += 1

    return centroids, clusters


# returns the mean of the cluster points
def mean(cluster):
    result = []
    for i in range(len(cluster[0])):
        temp = 0
        for j in range(len(cluster)):
            temp += cluster[j][i]
        result.append(temp/len(cluster))
    return result


# returns mse between 2 points
def getDistance(point1, point2):
    distance = 0
    for i in range(len(point1)):
        distance += (point1[i]-point2[i])**2
    return distance


def random_color():
    # rgbl=[255,0,0]
    # random.shuffle(rgbl)
    # return tuple(rgbl)
    return ["#"+''.join([random.choice('0123456789ABCDEF') for j in range(6)])
             for i in range(1)]


if __name__ == "__main__":
    # testing the different subfunctions
    # print(getDistance([0, 0], [1, 1]))
    # print(mean([[0, 0], [2, 2], [4, 4]]))
    # print(mean([[1, 1], [3, 2], [1, 5]]))

    # Experiment 1, manually generated data
    data = [[2, 2], [1, 1], [3, 2], [2, 1], [2, 3], [1, 3], [5, 5], [5, 6], [6, 5],
            [7, 7], [7, 6], [1, 7], [1, 6], [2, 7], [2, 6]]


    centroids, clusters = kmeans(data, 3)
    print(centroids)

    for i in range(len(clusters)):
        temp = np.array(clusters[i])
        x, y = temp.T
        colour = random_color()
        plt.scatter(x, y, color=colour)

        plt.scatter(centroids[i][0], centroids[i][1], color=colour, marker="*", s=180)

    plt.show()


    #  experiment 2, randomly generated 50 point data
    data2 = []
    for i in range(100):
        data2.append([random.randint(0, 10), random.randint(0, 10)])

    centroids, clusters = kmeans(data2, 3)
    print(centroids)

    for i in range(len(clusters)):
        temp = np.array(clusters[i])
        x, y = temp.T
        colour = random_color()
        plt.scatter(x, y, color=colour)

        plt.scatter(centroids[i][0], centroids[i][1], color=colour, marker="*", s=180)

    plt.show()
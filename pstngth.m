function [ numclus pstmean pstsdv ] = pstngth( X, clusters, trials, showPlot)
%PSTNGTH Calculates the prediction strength using the k-means algorithm for
%a matrix X with N rows and M columns, CLUSTERS is the maximum number of
%different clusters that will be tested, by default starts on 2 and ends in
%CLUSTERS, each number of clusters will be tried for TRIALS times.
%The distance measure used is the correlation distance.
%
%PSTNGTH(X, CLUSTERS, TRIALS): Provide a plot of the prediction strength
%values for the values in CLUSTERS, with the mean and standard deviation of
%the each cluster provided by the number of TRIALS.
%
%[NUMCLUS]=PSTNGHT(X, CLUSTERS, TRIALS): Provides the ideal number of
%clusters NUMCLUS as suggested by the prediction strength algorithm.
%
%[NUMCLUS PSTMEAN PSTSDV]=PSTNGTH(X, CLUSTERS, TRIALS): Provides the
%suggested number of clusters NUMCLUS, a vector containing the mean PSTMEAN
%and a vector containing the standard deviation PSTSDV resulting for all
%the trials in each proposed number of clusters.
%
%[...]=PSTNGTH(.., SHOWPLOT): Whether or not you want to show the plot and
%receive any extra arguments as a return of the function

% Based on the algorithm described in:
% R. Tibshirani, G. Walther, "Cluster Validation by Prediction Strength",
% American Statistical Association, Institute of Mathematical Statistics
% and Interface Foundation of North America 2005, Journal of Computational
% and Graphical Statistics, Volume 14 Number 3, Pages 511-528.
% Source: http://pubs.amstat.org/doi/abs/10.1198/106186005X59243

% Released under the MIT License, for further information see the README
% file or see the last part of this file.
% Written by Yoshiki Vazquez Baeza
% email: yoshiki89@gmail.com
% Version 1.1 March 2012

if nargin == 3
    showPlot=false;
end

warning off;
%Number of iterations to be run per k-means clustering
ITERATIONS=2;

%Be kind and pre-allocate your memory
resmat=zeros(clusters, trials);
resmat(1,:)=resmat(1,:)+1;

%Used later as reference
[height, width]=size(X);

%The value in clusters shouldn't be greater than than half the size of
%the data
if height*0.5 < clusters
    error('PSTNGTH:The value of CLUSTERS is too big, try with a smaller value.');
end

%For each cluster run a certain number of trials, the algorithm can be run in parallel
parfor cluster=2:clusters
    for trial=1:trials
        %Generate two random arrays from the data matrix
        [outcell]=divmat(X,2);
        test=outcell{1};
        training=outcell{2};
        
        %Cluster the test group and the training group
        [idxte ctrte]=kmeans(test, cluster, 'distance', 'correlation', 'replicates', ITERATIONS, 'emptyaction', 'singleton');
        [idxtr ctrtr]=kmeans(training, cluster, 'distance', 'correlation', 'replicates', ITERATIONS, 'emptyaction', 'singleton');
        
        %Reference matrix for the test clustering 
        temat=samat(idxte);
        
        %Cluster the test data with the training centroids
        [idxps ctrps]=kmeans(test, cluster, 'emptyaction', 'singleton', 'start', ctrtr);
        psmat=samat(idxps);
        
        %For all the points that are in the same position sum one and
        %calculate the proportion to the best case, meaning all stayed in
        %the same cluster
        resmat(cluster, trial)=sum(sum(temat==psmat))/sum(sum(temat==temat));
    end
end
warning on;

%Plot the data
if nargout == 0 || showPlot
    figure
    hold on
    plot(1:clusters, mean(resmat'))
    errorbar(1:clusters, mean(resmat'), std(resmat'),'*r');
    hold off
    xlabel('Number of clusters')
    ylabel('Prediction stregnth')
    grid on
    axis tight
end

%Returning just the ideal number of clusters
if nargout >= 1
    %Add an offset of 1 to fix removing the first row
    [val pos]=max(mean(resmat(2:end,:)'));
    numclus=pos+1;
end

%Return the vectors
if nargout > 1
    %Calculate the mean and the standard deviation
    pstmean=mean(resmat');
    pstsdv=std(resmat');
end

end

function [ outcell ] = divmat( matrix, pieces )
%DIVMAT Randomly divides a matrix into PIECES parts and stores each part 
%inside each index of the cell OUTCELL, OUTCELL will have as many indexes
%as stated by PIECES.

% Released under the MIT License, for further information see the README
% file or see the last part of this file.
% Written by Yoshiki Vazquez Baeza
% email: yoshiki89@gmail.com
% Version 1.1 March 2012

[height, width]=size(matrix);

%Randomized order
ranrows=randperm(height);

%Keep track of all the rows you have randomly split
divided=1;
subsize=floor(height/pieces);
chunk=subsize;

%Split piece by piece
for index=1:pieces
    
    %In all the divisions increase linearly the size ...
    if index ~= pieces
        outcell{index}=matrix(ranrows(divided:chunk),:);
    %Except in the last division, just store everything there
    else
        outcell{index}=matrix(ranrows(divided:end),:);
    end
    
    %Update the tracking values
    divided=divided+subsize;
    chunk=chunk+subsize;

end

end

function [ omat ] = samat( indexes )
%SAMAT Creates a matrix based on INDEXES, where each of the values
%correspond to a cluster, summarizes in the upper side of OMAT the pairs of
%rows that are in the same cluster.

% Released under the MIT License, for further information see the README
% file or see the last part of this file.
% Written by Yoshiki Vazquez Baeza
% email: yoshiki89@gmail.com
% Version 1.1 March 2012

height=length(indexes);
omat=zeros(height,height);

%Go through every row but not through every column
for y=1:height
    for x=(y+1):height
        %If the indexes are on the same cluster set that crossroad to one
        if indexes(y) == indexes(x)
            omat(y,x)=1;
        end
    end
end
end
% Copyright (c) 2012 Yoshiki Vazquez Baeza http://yoshikee.tumblr.com
% Permission is hereby granted, free of charge, to any person obtaining
% a copy of this software and associated documentation files (the
% "Software"), to deal in the Software without restriction, including
% without limitation the rights to use, copy, modify, merge, publish,
% distribute, sublicense, and/or sell copies of the Software, and to
% permit persons to whom the Software is furnished to do so, subject to
% the following conditions:
% 
% The above copyright notice and this permission notice shall be
% included in all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
% EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
% NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
% LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
% OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
% WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
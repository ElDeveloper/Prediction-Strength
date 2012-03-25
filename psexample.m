% Released under the MIT License, for further information see the README
% file or see the last part of this file.
% Written by Yoshiki Vazquez Baeza
% email: yoshiki89@gmail.com
% Version 1.1 March 2012

%Time vector
t=0.01:0.01:10;

%Create the data, with clearly 7 clusters
X=[5.*sin(2*pi*2*t); %First Cluster (1,2,3,4)
   5.*sin(2*pi*2*t);
   5.*sin(2*pi*2*t);
   5.*sin(2*pi*2*t);
   2.*sin(2*pi*11*t); %Second Cluster (5,6,7,8,9)
   2.*sin(2*pi*11*t);
   2.*sin(2*pi*11*t);
   2.*sin(2*pi*11*t);
   2.*sin(2*pi*11*t);
   13.6.*cos(2*pi*5*t); %Third Cluster (10,11,12,13)
   13.6.*cos(2*pi*5.1*t);
   13.6.*cos(2*pi*5.1*t);
   13.6.*cos(2*pi*5.1*t);
   7.*sin(2*pi*0.11*t); %Fourth Cluster (14,15)
   7.*sin(2*pi*0.11*t);
   9.*sin(2*pi*14*t); %Fifth Cluster (16,17,18)
   9.*sin(2*pi*14*t);
   9.*sin(2*pi*14*t);
   11.*sin(2*pi*7.7*t); %Sixth Cluster (19,20)
   11.*sin(2*pi*7.7*t);
   1.1.*cos(2*pi*8.9.*t); %Seventh Cluster (21,22,23,24)
   1.1.*cos(2*pi*8.9*t);
   1.1.*cos(2*pi*8.9*t);
   1.1.*cos(2*pi*8.9*t);];

%Call the prediction strength algorithm and show the plot
[numberOfClusters means stdvs]=pstngth(X, 12, 20,true);

warning off %No warnings, they are annoying, see the docs for kmeans for further explanation
[idx ctrs] = kmeans(X,numberOfClusters,'distance','correlation','replicates',5,'emptyaction','singleton');
warning on

indexes=1:length(X);
for currentCluster = 1:numberOfClusters
    fprintf('Cluster number %d, contains signal:',currentCluster);
    fprintf('[%d]-',indexes(idx == currentCluster));
    fprintf(',\n');
     
    figure
    plot(t,X((idx == currentCluster),:));
    title(sprintf('Cluster Number [%d]',currentCluster))
    xlabel('Time')
    ylabel('Amplitude')
    grid on
    axis tight
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
% WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE
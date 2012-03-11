function [ omat ] = samat( indexes )
%SAMAT Creates a matrix based on INDEXES, where each of the values
%correspond to a cluster, summarizes in the upper side of OMAT the pairs of
%rows that are in the same cluster.

% Released under the MIT License, for further information see the README
% file or see the last part of this file.
% Written by Yoshiki Vazquez Baeza
% email: yoshiki89@gmail.com
% Version 1.0 March 2012

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

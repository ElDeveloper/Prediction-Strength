function [ outcell ] = divmat( matrix, pieces )
%DIVMAT Randomly divides a matrix into PIECES parts and stores each part 
%inside each index of the cell OUTCELL, OUTCELL will have as many indexes
%as stated by PIECES.

% Released under the MIT License, for further information see the README
% file or see the last part of this file.
% Written by Yoshiki Vazquez Baeza
% email: yoshiki89@gmail.com
% Version 1.0 March 2012

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

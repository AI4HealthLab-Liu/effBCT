function [deg] = degrees_und(a)
%DEGREES_UND        Degree
%
%   deg = degrees_und(CIJ);
%
%   Node degree is the number of links connected to the node.
%
%   Input:      a,      I/O object handler
%
%   Output:     deg,    node degree
%
%   Note: Weight information is discarded.
%
%
%   Olaf Sporns, Indiana University, 2002/2006/2008

% Modification history:
% 2015: CIJ is directly accessed without being loaded into memory

% ensure CIJ is binary and compute degrees
deg = sum(double(a.CIJ~=0));
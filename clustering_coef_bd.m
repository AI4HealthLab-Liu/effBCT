function C = clustering_coef_bd(a)
%CLUSTERING_COEF_BD     Clustering coefficient
%
%   C = clustering_coef_bd(a);
%
%   The clustering coefficient is the fraction of triangles around a node
%   (equiv. the fraction of node’s neighbors that are neighbors of each other).
%
%   Input:      a,      I/O object handler
%
%   Output:     C,      clustering coefficient vector
%
%   Notes:  CIJ is a binary and directed connection matrix.
%
%   Reference: Fagiolo (2007) Phys Rev E 76:026107.
%
%
%   Mika Rubinov, UNSW, 2007-2010

%Methodological note: In directed graphs, 3 nodes generate up to 8 
%triangles (2*2*2 edges). The number of existing triangles is the main 
%diagonal of S^3/2. The number of all (in or out) neighbour pairs is 
%K(K-1)/2. Each neighbour pair may generate two triangles. "False pairs" 
%are i<->j edge pairs (these do not generate triangles). The number of 
%false pairs is the main diagonal of A^2.
%Thus the maximum possible number of triangles = 
%       = (2 edges)*([ALL PAIRS] - [FALSE PAIRS])
%       = 2 * (K(K-1)/2 - diag(A^2))
%       = K(K-1) - 2(diag(A^2))

% Modification history:
% 2016: CIJ is directly accessed without being loaded into memory

% S = (a.CIJ)+(a.CIJ).';                 %symmetrized input graph
K = sum(((a.CIJ)+(a.CIJ).'),2);        %total degree (in + out)
cyc3 = diag(((a.CIJ)+(a.CIJ).')^3)/2;  %number of 3-cycles (ie. directed triangles)
K(cyc3==0) = inf;                      %if no 3-cycles exist, make C=0 (via K=inf)
CYC3 = K.*(K-1)-2*diag((a.CIJ)^2);	   %number of all possible 3-cycles
C = cyc3./CYC3;                        %clustering coefficient

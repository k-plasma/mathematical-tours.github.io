function dijkstra_plot(data, vertex, target, options )

% plot one state in dijkstra algorithm.
%
%   dijkstra_plot(data, vertex, [, target, options] );
%
%   You can add the following options : 
%       'options.Xvert' : style used for display of non-reached vertices.
%       'options.Overt' : style used for display of open vertices.
%       'options.Cvert' : style used for display of closed vertices.
%       'options.Cvert' : style used for display of closed vertices.
%       'options.path' : style used for display of path.
%
%   If 'target' is not empty, it will plot the path back.
%
%   Copyright (c) 2004 Gabriel Peyr�

if nargin<3
    target = [];
end

if nargin<4
    options.Xvert = [];
    options.Overt = 'k*';
    options.Cvert = 'ko';
    options.path = 'r';
end

if isfield(options, 'Xvert')
    Xvert = options.Xvert;
else
    Xvert = [];
end

if isfield(options, 'Overt')
    Overt = options.Overt;
else
    Overt = 'k*';
end

if isfield(options, 'Cvert')
    Cvert = options.Cvert;
else
    Cvert = 'k*';
end

if isfield(options, 'path')
    path = options.path;
else
    path = 'r';
end


A = data.A; % action 
O = data.O; % open list
C = data.C; % close list
S = data.S; % state, either 'O' or 'C'
F = data.F; % Father
adj_list = data.adj_list;   % adjacency list
W = data.W; % weight matrix
adj_matrix = and( W~=Inf, W>0 );

n = size(W,1);

hold on;
gplot( adj_matrix,vertex, 'k-' );
if ~isempty(Xvert)
    plot( vertex(:,1), vertex(:,2), Xvert );
end
if ~isempty(Overt)
    plot( vertex(O,1), vertex(O,2), Overt );
end
if ~isempty(Cvert)
    plot( vertex(C,1), vertex(C,2), Cvert );
end
% plot the path
for t=target
    p = [t];    % the path
    curv = t;
    niter = 0;
    while F(curv)>0 && niter<n
        niter = niter + 1;
        curv = F(curv);
        p = [p, curv];
    end
    plot( vertex( p, 1 ), vertex( p, 2 ), path )
end
hold off;
axis tight;
axis off;
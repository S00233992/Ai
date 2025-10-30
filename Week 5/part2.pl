% graph from diagram - romanian cities

% all the edges with costs
edge(oradea, zerind, 71).
edge(zerind, oradea, 71).
edge(oradea, sibiu, 151).
edge(sibiu, oradea, 151).
edge(zerind, arad, 75).
edge(arad, zerind, 75).
edge(arad, sibiu, 140).
edge(sibiu, arad, 140).
edge(arad, timisoara, 118).
edge(timisoara, arad, 118).
edge(timisoara, lugoj, 111).
edge(lugoj, timisoara, 111).
edge(lugoj, mehadia, 70).
edge(mehadia, lugoj, 70).
edge(mehadia, dobreta, 75).
edge(dobreta, mehadia, 75).
edge(dobreta, craiova, 120).
edge(craiova, dobreta, 120).
edge(sibiu, fagaras, 99).
edge(fagaras, sibiu, 99).
edge(sibiu, rimnicu_vilcea, 80).
edge(rimnicu_vilcea, sibiu, 80).
edge(rimnicu_vilcea, pitesti, 97).
edge(pitesti, rimnicu_vilcea, 97).
edge(rimnicu_vilcea, craiova, 146).
edge(craiova, rimnicu_vilcea, 146).
edge(craiova, pitesti, 138).
edge(pitesti, craiova, 138).
edge(fagaras, bucharest, 211).
edge(bucharest, fagaras, 211).
edge(pitesti, bucharest, 101).
edge(bucharest, pitesti, 101).
edge(bucharest, giurgiu, 90).
edge(giurgiu, bucharest, 90).
edge(bucharest, urziceni, 85).
edge(urziceni, bucharest, 85).
edge(urziceni, hirsova, 98).
edge(hirsova, urziceni, 98).
edge(urziceni, vaslui, 142).
edge(vaslui, urziceni, 142).
edge(hirsova, eforie, 86).
edge(eforie, hirsova, 86).
edge(vaslui, iasi, 92).
edge(iasi, vaslui, 92).
edge(iasi, neamt, 87).
edge(neamt, iasi, 87).

% dfs - returns all paths with costs
dfs_all_paths(Start, Goal, Path, Cost) :-
    dfs_help(Start, Goal, [Start], 0, Path, Cost).

dfs_help(Goal, Goal, Visited, Cost, Path, Cost) :-
    reverse(Visited, Path).

dfs_help(Current, Goal, Visited, CurrentCost, Path, FinalCost) :-
    edge(Current, Next, EdgeCost),
    \+ member(Next, Visited),
    NewCost is CurrentCost + EdgeCost,
    dfs_help(Next, Goal, [Next|Visited], NewCost, Path, FinalCost).

% find shortest path from all dfs paths
shortest_path(Start, Goal, ShortestPath, MinCost) :-
    findall((Cost, Path), dfs_all_paths(Start, Goal, Path, Cost), AllPaths),
    sort(AllPaths, [(MinCost, ShortestPath)|_]).  % sort gets cheapest first





?- dfs_all_paths(arad, bucharest, Path, Cost).
% This will show you all paths one by one

?- shortest_path(arad, bucharest, Path, Cost).
% This gives you the shortest path


test code
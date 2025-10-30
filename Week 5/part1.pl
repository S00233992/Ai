% week 5 lab

% the graph
edge(a, b, 2).
edge(a, c, 2).
edge(b, e, 4).
edge(b, f, 7).
edge(c, d, 2).
edge(c, g, 4).
edge(e, j, 5).
edge(f, g, 5).

% dfs - go deep first
dfs(Start, Goal, Path) :-
    dfs_help(Start, Goal, [Start], Path).

dfs_help(Goal, Goal, Visited, Path) :-
    reverse(Visited, Path).

dfs_help(Current, Goal, Visited, Path) :-
    edge(Current, Next, _),
    \+ member(Next, Visited),  % not visited yet
    dfs_help(Next, Goal, [Next|Visited], Path).

% dls - depth limit is 2
dls(Start, Goal, Path) :-
    dls_help(Start, Goal, 0, [Start], Path).

dls_help(Goal, Goal, _, Visited, Path) :-
    reverse(Visited, Path).

dls_help(Current, Goal, Depth, Visited, Path) :-
    Depth < 2,  % stop at depth 2
    edge(Current, Next, _),
    \+ member(Next, Visited),
    D is Depth + 1,
    dls_help(Next, Goal, D, [Next|Visited], Path).

% bfs - level by level
bfs(Start, Goal, Path) :-
    bfs_help([[Start]], Goal, Path).

bfs_help([[Goal|Visited]|_], Goal, Path) :-
    reverse([Goal|Visited], Path).

bfs_help([[Node|Visited]|Queue], Goal, Path) :-
    findall([Next, Node|Visited],
            (edge(Node, Next, _), \+ member(Next, [Node|Visited])),
            NewPaths),
    append(Queue, NewPaths, NewQueue),
    bfs_help(NewQueue, Goal, Path).

% ucs - cheapest path first
ucs(Start, Goal, Path, Cost) :-
    ucs_help([(0, [Start])], Goal, Path, Cost).

ucs_help([(Cost, [Goal|Visited])|_], Goal, Path, Cost) :-
    reverse([Goal|Visited], Path).

ucs_help([(CurrentCost, [Node|Visited])|Queue], Goal, Path, FinalCost) :-
    findall((NewCost, [Next, Node|Visited]),
            (edge(Node, Next, EdgeCost),
             \+ member(Next, [Node|Visited]),
             NewCost is CurrentCost + EdgeCost),
            NewPaths),
    append(Queue, NewPaths, AllPaths),
    sort(AllPaths, SortedQueue),  % sort by cost to get cheapest
    ucs_help(SortedQueue, Goal, Path, FinalCost).






    ?- dfs(a, g, Path).
?- dls(a, g, Path).
?- bfs(a, g, Path).
?- ucs(a, g, Path, Cost).

test code
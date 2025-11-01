% week 5 lab

% the graph
edge(a, b, 2).
edge(a, c, 2).
edge(b, e, 4).
edge(b, f, 7).
edge(c, d, 2).
edge(c, g, 4).
edge(e, g, 5).
edge(f, g, 5).

% ===== DFS - go deep first =====
dfs(Start, Goal, Path) :-
    write('DFS: '), nl,
    dfs_help(Start, Goal, [Start], Path).

dfs_help(Goal, Goal, Visited, Path) :-
    reverse(Visited, Path),
    write('Path found: '), write(Path), nl.

dfs_help(Current, Goal, Visited, Path) :-
    edge(Current, Next, _),
    \+ member(Next, Visited),
    write('Visit: '), write(Next), nl,
    dfs_help(Next, Goal, [Next|Visited], Path).

% ===== DLS - depth limit is 2 =====
dls(Start, Goal, Path) :-
    write('DLS (limit 2): '), nl,
    dls_help(Start, Goal, 0, [Start], Path).

dls_help(Goal, Goal, _, Visited, Path) :-
    reverse(Visited, Path),
    write('Path found: '), write(Path), nl.

dls_help(Current, Goal, Depth, Visited, Path) :-
    Depth < 2,
    edge(Current, Next, _),
    \+ member(Next, Visited),
    write('Visit: '), write(Next), write(' at depth '), write(Depth), nl,
    D is Depth + 1,
    dls_help(Next, Goal, D, [Next|Visited], Path).

% ===== BFS - level by level =====
bfs(Start, Goal, Path) :-
    write('BFS: '), nl,
    bfs_help([[Start]], Goal, Path).

bfs_help([[Goal|Visited]|_], Goal, Path) :-
    reverse([Goal|Visited], Path),
    write('Path found: '), write(Path), nl.

bfs_help([[Node|Visited]|Queue], Goal, Path) :-
    write('Frontier: '), print_frontier([[Node|Visited]|Queue]), nl,
    write('Expand: '), write(Node), nl,
    findall([Next, Node|Visited],
            (edge(Node, Next, _), \+ member(Next, [Node|Visited])),
            NewPaths),
    append(Queue, NewPaths, NewQueue),
    bfs_help(NewQueue, Goal, Path).

% ===== UCS - cheapest path first =====
ucs(Start, Goal, Path, Cost) :-
    write('UCS: '), nl,
    ucs_help([(0, [Start])], Goal, Path, Cost).

ucs_help([(Cost, [Goal|Visited])|_], Goal, Path, Cost) :-
    reverse([Goal|Visited], Path),
    write('Path found: '), write(Path), nl,
    write('Total cost: '), write(Cost), nl.

ucs_help([(CurrentCost, [Node|Visited])|Queue], Goal, Path, FinalCost) :-
    write('Frontier costs: '), print_costs([(CurrentCost, [Node|Visited])|Queue]), nl,
    write('Expand: '), write(Node), write(' (cost '), write(CurrentCost), write(')'), nl,
    findall((NewCost, [Next, Node|Visited]),
            (edge(Node, Next, EdgeCost),
             \+ member(Next, [Node|Visited]),
             NewCost is CurrentCost + EdgeCost),
            NewPaths),
    append(Queue, NewPaths, AllPaths),
    sort(AllPaths, SortedQueue),
    ucs_help(SortedQueue, Goal, Path, FinalCost).

% helper to print frontier
print_frontier([]).
print_frontier([[Node|_]|Rest]) :-
    write(Node), write(' '),
    print_frontier(Rest).

% helper to print costs
print_costs([]).
print_costs([(Cost, [Node|_])|Rest]) :-
    write(Node), write('('), write(Cost), write(') '),
    print_costs(Rest).

% calculate cost of a path
path_cost([_], 0).
path_cost([From, To|Rest], Total) :-
    edge(From, To, Cost),
    path_cost([To|Rest], RestCost),
    Total is Cost + RestCost.

% find all paths
all_paths(Start, Goal) :-
    write('All paths from '), write(Start), write(' to '), write(Goal), write(':'), nl,
    findall(Path, find_path(Start, Goal, Path), Paths),
    print_paths(Paths).

find_path(Start, Goal, Path) :-
    find_path_help(Start, Goal, [Start], Path).

find_path_help(Goal, Goal, Visited, Path) :-
    reverse(Visited, Path).

find_path_help(Current, Goal, Visited, Path) :-
    edge(Current, Next, _),
    \+ member(Next, Visited),
    find_path_help(Next, Goal, [Next|Visited], Path).

print_paths([]).
print_paths([Path|Rest]) :-
    write('  '), write(Path),
    write(' - cost: '),
    path_cost(Path, Cost),
    write(Cost), nl,
    print_paths(Rest).

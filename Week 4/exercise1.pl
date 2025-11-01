% finds adjacent squares around a given square
adjacent([Row, Col, _], Squares) :-
    % get row above and below
    UpRow is Row - 1,
    DownRow is Row + 1,
    % get column left and right
    LeftCol is Col - 1,
    RightCol is Col + 1,
    
    % put all the adjacent squares in a list
    % e means empty square
    Squares = [
        [UpRow, Col, e],      % up
        [Row, LeftCol, e],    % left
        [Row, RightCol, e],   % right
        [DownRow, Col, e]     % down
    ].







?- adjacent([2,2,x], Squares).
Squares = [[1,2,e], [2,1,e], [2,3,e], [3,2,e]].


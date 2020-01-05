% This Minizinc Model solves a classic 8-Puzzle in no more than 31 moves.
%
% https://www.transum.org/Software/Fun_Maths/Squorder/
%
% The aim is of the game is to rearrange the tiles so that they are in order from 1 to 8.
%
% 1..9 is the domain, while wa is the decision variable. What can WA be that is [1..9]?

include "globals.mzn";

% Example Input: [ 7,3,4,1,0,5,6,2,8 ]
% Get user input for initial state (2d Array)
array[int] of int: board;

constraint alldifferent(board);

% A 2d Array of allowed moves as [Position, Allowed Index to Move]
array[int,int] of int: all_allowed_moves = 
[| 0, 1, 0, 1, 0, 0, 0, 0, 0
 | 1, 0, 1, 0, 1, 0, 0, 0, 0
 | 0, 1, 0, 0, 0, 1, 0, 0, 0
 | 1, 0, 0, 0, 1, 0, 1, 0, 0
 | 0, 1, 0, 1, 0, 1, 0, 1, 0
 | 0, 0, 1, 0, 1, 0, 0, 1, 0
 | 0, 0, 0, 1, 0, 0, 0, 1, 0
 | 0, 0, 0, 0, 1, 0, 1, 0, 1
 | 0, 0, 0, 0, 0, 1, 0, 1, 0
 |];

% Find the position of the empty space, 0
int: emptyIndex = getIndexOfEmptySpace(board);

% What indexes can we change?
array[int] of int: allowed_move = row(all_allowed_moves, emptyIndex);

% Gets the index of an empty space "0"
function int: getIndexOfEmptySpace(array[int] of int: current_board) = 
   sum(  [ if current_board[i] = 0
              then i-1
           else 0 endif  
          | i in index_set(current_board) ]
   );

% A final state should look like this. **One Example**
predicate f_state(array[int] of int: board) =
      board == [1,2,3,4,5,6,7,8,0];

constraint f_state(board);

solve :: int_search(board, input_order, indomain_min)

output [show(board)]




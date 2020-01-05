/*

  Daily ABC Path
  https://www.brainbashers.com/showabcpath.asp?date=1108

  Objective / Rules
- Enter every letter from A to Y into the grid.
- Each letter is next to the previous letter either horizontally, vertically or diagonally.
- The clues around the edge tell you which row, column or diagonal each letter is in.

*/

include "globals.mzn";

enum alphabet = {'0', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y'};
array[int] of alphabet: alphabet_array = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y'];
int: size_of_grid = 4;
array[ 0..size_of_grid, 0..size_of_grid ] of var alphabet: grid;

function var int: indexOfChar(array[int] of alphabet: alphabet_array, var alphabet: char) = 
   sum(  [ if alphabet_array[i] == char
              then i-1
           else 0 endif  
          | i in index_set(alphabet_array) ]
   );

constraint alldifferent(array1d(grid));
constraint forall(n in array1d(grid)) (n != '0');

% Specify the givens
constraint grid[3,1] == 'A';

% These starting constraints help reduce runtime by a whole lot, and are intuitive first steps in the puzzle.
% constraint
%     grid[2,0] == 'B' \/
%     grid[4,0] == 'B';
% constraint grid[3,0] == 'C';

constraint 
    exists(z in 0..size_of_grid) (grid[z,0] == 'B') /\
    exists(z in 0..size_of_grid) (grid[3,z] == 'C') /\
    exists(z in 0..size_of_grid) (grid[2,z] == 'D') /\
    exists(z in 0..size_of_grid) (grid[z,z] == 'E') /\
    exists(z in 0..size_of_grid) (grid[z,z] == 'F') /\
    exists(z in 0..size_of_grid) (grid[z,0] == 'G') /\
    exists(z in 0..size_of_grid) (grid[z,1] == 'H') /\
    exists(z in 0..size_of_grid) (grid[1,z] == 'I') /\
    exists(z in 0..size_of_grid) (grid[z,3] == 'J') /\
    exists(z in 0..size_of_grid) (grid[2,z] == 'K') /\
    exists(z in 0..size_of_grid) (grid[z,3] == 'L') /\
    exists(z in 0..size_of_grid) (grid[4,z] == 'M') /\
    exists(z in 0..size_of_grid) (grid[z,1] == 'N') /\
    exists(z in 0..size_of_grid) (grid[z,2] == 'O') /\
    exists(z in 0..size_of_grid) (grid[4,z] == 'P') /\
    exists(z in 0..size_of_grid) (grid[z,4] == 'Q') /\
    exists(z in 0..size_of_grid) (grid[3,z] == 'R') /\
    exists(z in 0..size_of_grid) (grid[z,4] == 'S') /\
    exists(z in 0..size_of_grid) (grid[size_of_grid-z, z] == 'T') /\
    exists(z in 0..size_of_grid) (grid[1,z] == 'U') /\
    exists(z in 0..size_of_grid) (grid[size_of_grid-z, z] == 'V') /\
    exists(z in 0..size_of_grid) (grid[0,z] == 'W') /\
    exists(z in 0..size_of_grid) (grid[z,2] == 'X') /\
    exists(z in 0..size_of_grid) (grid[0,z] == 'Y');
    
constraint
    forall(x in 0..size_of_grid) (
      forall(y in 0..size_of_grid) (
      if grid[x,y] != 'Y' then
        grid[x+1,y] == alphabet_array[indexOfChar(alphabet_array, grid[x,y]) + 2] <-> grid[x+1,y] != undefined \/
        grid[x-1,y] == alphabet_array[indexOfChar(alphabet_array, grid[x,y]) + 2] \/
        grid[x+1,y+1] == alphabet_array[indexOfChar(alphabet_array, grid[x,y]) + 2] \/
        grid[x-1,y-1] == alphabet_array[indexOfChar(alphabet_array, grid[x,y]) + 2] \/
        grid[x,y+1] == alphabet_array[indexOfChar(alphabet_array, grid[x,y]) + 2] \/
        grid[x,y-1] == alphabet_array[indexOfChar(alphabet_array, grid[x,y]) + 2] \/
        grid[x+1,y-1] == alphabet_array[indexOfChar(alphabet_array, grid[x,y]) + 2] \/
        grid[x-1,y+1] == alphabet_array[indexOfChar(alphabet_array, grid[x,y]) + 2]
      else
        grid[x,y] == 'Y'
      endif
      )
    );

solve satisfy;

output [
  if i <= size_of_grid then "Row \(i):  \(row(grid,i))\n" else " " endif
  | i in 0..size_of_grid
]





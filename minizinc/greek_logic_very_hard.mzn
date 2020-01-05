% Brainzilla Greek Logic Puzzle - Very Hard
% https://www.brainzilla.com/logic/greek-logic/

% Drag and drop the Greek letters in the grid so that each letter appears exactly once in each row, column and main diagonals. 
% This game is updated 4 times a day: 00:00, 12:00, 16:00, and 20:00.

include "globals.mzn";

int: size = 8;
int: numLetters = 8;
set of int: greekLetters = 1..numLetters;

array[0..size-1, 0..size-1] of var greekLetters: grid;

% Givens
constraint forall(i in 0..size-1)(grid[0,i] == i+1);
constraint grid[1,3] == 2;
constraint grid[1,5] == 1;
constraint grid[2,3] == 8;
constraint grid[2,7] == 1;
constraint grid[3,1] == 4;
constraint grid[3,5] == 5;
constraint grid[4,5] == 2;
constraint grid[4,6] == 5;
constraint grid[5,0] == 3;
constraint grid[5,1] == 7;
constraint grid[5,3] == 5;
constraint grid[5,5] == 8;
constraint grid[5,6] == 2;
constraint grid[6,0] == 8;
constraint grid[6,4] == 2;
constraint grid[7,2] == 6;
constraint grid[7,4] == 7;
constraint grid[7,7] == 5;

% Row/Column Constraints, Respectively
constraint forall(i in 0..size-1) (alldifferent(j in 0..size-1) (grid[i,j]));
constraint forall(i in 0..size-1) (alldifferent(j in 0..size-1) (grid[j,i]));

% Major Diagonals Constraints
constraint alldifferent(j in 0..size-1)(grid[j,j]);
constraint alldifferent(j in 0..size-1)(grid[j,size-1-j]);
    
solve satisfy;

output
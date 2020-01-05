% Brainzilla Greek Logic Puzzle - Very Easy
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
constraint grid[2,0] == 2;

% Row/Column Constraints, Respectively
constraint forall(i in 0..size-1) (alldifferent(j in 0..size-1) (grid[i,j]));
constraint forall(i in 0..size-1) (alldifferent(j in 0..size-1) (grid[j,i]));

% Major Diagonals Constraints
constraint alldifferent(j in 0..size-1)(grid[j,j]);
constraint alldifferent(j in 0..size-1)(grid[j,size-1-j]);
    
solve satisfy;
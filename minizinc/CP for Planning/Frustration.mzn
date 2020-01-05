% A Minizinc Model to solve "Frustration"
% https://www.transum.org/software/Fun_Maths/Frustration/
% A nine must appear in all of the yellow cells.

% ['6','7','8','7','4','5','8','5','7'] Sample Input

enum Number = {'1', '2', '3', '4', '5', '6', '7', '8', '9'};

% Set the max state
int: max_states = 8;

% Set of ints for all the states and StatesButLast so we can iterate through them.
set of int: States = 0 .. max_states;
set of int: StatesButLast =  0 .. max_states-1 ;

% We need to solve for the final state
var States: final_state;

% Obtain an initial state from user input
array[1..9] of Number: initial_state;

% Declare a 2d array called all states with States and 9 numbers.
array[States, 1..9] of var Number: all_states;

% Sets the initial state 
constraint
    forall(i in Number) (all_states[0,i] = initial_state[i]);
    
% Increments the positions in the array c1 and c2 by 1 at s+1.
% If the position at s is not < 9, then it sets it to 1.
% Plus two, plus three, and plus four are all the same except for the number of +1s
predicate plus_increment_twos(array[States,1..9] of var Number: all_states, int: s, int: c1, int: c2) =
         if all_states[s,c1] < 9 then all_states[s+1,c1] = all_states[s,c1] + 1
         else all_states[s+1,c1] = 1 endif /\
         if all_states[s,c2] < 9 then all_states[s+1,c2] = all_states[s,c2] + 1
         else all_states[s+1,c2] = 1 endif;

predicate plus_increment_threes(array[States,1..9] of var Number: all_states, int: s, int: c1, int: c2, int: c3) =
         if all_states[s,c1] < 9 then all_states[s+1,c1] = all_states[s,c1] + 1
         else all_states[s+1,c1] = 1 endif /\
         if all_states[s,c2] < 9 then all_states[s+1,c2] = all_states[s,c2] + 1
         else all_states[s+1,c2] = 1 endif /\
         if all_states[s,c3] < 9 then all_states[s+1,c3] = all_states[s,c3] + 1
         else all_states[s+1,c3] = 1 endif;
         
predicate plus_increment_fours(array[States,1..9] of var Number: all_states, int: s, int: c1, int: c2, int: c3, int: c4) =
         if all_states[s,c1] < 9 then all_states[s+1,c1] = all_states[s,c1] + 1
         else all_states[s+1,c1] = 1 endif /\
         if all_states[s,c2] < 9 then all_states[s+1,c2] = all_states[s,c2] + 1
         else all_states[s+1,c2] = 1 endif /\
         if all_states[s,c3] < 9 then all_states[s+1,c3] = all_states[s,c3] + 1
         else all_states[s+1,c3] = 1 endif /\
         if all_states[s,c4] < 9 then all_states[s+1,c4] = all_states[s,c4] + 1
         else all_states[s+1,c4] = 1 endif;
        
% Increases a number at c by 3 at s+1. If s is 7,8, or 9, then the value will be set accordingly.
% Ex. 7 + 3 = 1, 8 + 3 = 2. It can not be greater than 9. 
predicate plus_center(array[States,1..9] of var Number: all_states, int: s, int: c) =
         if all_states[s,c] <= 6 then all_states[s+1,c] = all_states[s,c] + 3
         elseif all_states[s,c] == 7 then all_states[s+1,c] = 1
         elseif all_states[s,c] == 8 then all_states[s+1,c] = 2
         else all_states[s+1,c] = 3 endif;
         
% You can select any position on the grid
% The selected position will increase by 3, while the others 4 will increase by 1
% Selecting 1 -> 1 increases by 3; 2 and 4 increases by 1
% Selecting 2 -> 2 increases by 3, 0 4 2
% Selecting 3 -> 3 increases by 3, 1 5
% Selecting 4 -> 4 increases by 3, 0 4 6
% Selecting 5 -> 5 increases by 3, 1 3 5 7
% Selecting 6 -> 6 increases by 3, 2 4 8
% Selecting 7 -> 7 increases by 3, 3 7
% Selecting 8 -> 8 increases by 3, 4 6 8
% Selecting 9 -> 9 increases by 3, 5 7
 
constraint
    forall(s in StatesButLast) (
         (plus_center(all_states, s, 1) /\ % Chooses 1 to add 3 to
         plus_increment_twos(all_states, s, 2, 4) /\ % Positions 2 and 4 (adjacent) to 1, so add 1
%        The next state at these positions must stay the same.
         all_states[s,3] == all_states[s+1,3] /\
         all_states[s,5] == all_states[s+1,5] /\
         all_states[s,6] == all_states[s+1,6] /\
         all_states[s,7] == all_states[s+1,7] /\
         all_states[s,8] == all_states[s+1,8] /\
         all_states[s,9] == all_states[s+1,9])
         \/
         (plus_center(all_states, s, 2) /\
         plus_increment_threes(all_states, s, 1, 3, 5) /\
         all_states[s,4] == all_states[s+1,4] /\
         all_states[s,6] == all_states[s+1,6] /\
         all_states[s,7] == all_states[s+1,7] /\
         all_states[s,8] == all_states[s+1,8] /\
         all_states[s,9] == all_states[s+1,9])
         \/
         (plus_center(all_states, s, 3) /\
         plus_increment_twos(all_states, s, 2, 6) /\
         all_states[s,1] == all_states[s+1,1] /\
         all_states[s,4] == all_states[s+1,4] /\
         all_states[s,5] == all_states[s+1,5] /\
         all_states[s,6] == all_states[s+1,6] /\
         all_states[s,7] == all_states[s+1,7] /\
         all_states[s,8] == all_states[s+1,8] /\
         all_states[s,9] == all_states[s+1,9])
         \/
         (plus_center(all_states, s, 4) /\
         plus_increment_threes(all_states, s, 1, 5, 7) /\
         all_states[s,2] == all_states[s+1,2] /\
         all_states[s,3] == all_states[s+1,3] /\
         all_states[s,6] == all_states[s+1,6] /\
         all_states[s,8] == all_states[s+1,8] /\
         all_states[s,9] == all_states[s+1,9])
         \/
         (plus_center(all_states, s, 5) /\
         plus_increment_fours(all_states, s, 2, 4, 6, 8) /\
         all_states[s,1] == all_states[s+1,1] /\
         all_states[s,3] == all_states[s+1,3] /\
         all_states[s,7] == all_states[s+1,7] /\
         all_states[s,9] == all_states[s+1,9])
         \/
         (plus_center(all_states, s, 6) /\
         plus_increment_threes(all_states, s, 3, 5, 9) /\
         all_states[s,1] == all_states[s+1,1] /\
         all_states[s,2] == all_states[s+1,2] /\
         all_states[s,4] == all_states[s+1,4] /\
         all_states[s,7] == all_states[s+1,7] /\
         all_states[s,8] == all_states[s+1,8])
         \/
         (plus_center(all_states, s, 7) /\
         plus_increment_twos(all_states, s, 4, 8) /\
         all_states[s,1] == all_states[s+1,1] /\
         all_states[s,2] == all_states[s+1,2] /\
         all_states[s,3] == all_states[s+1,3] /\
         all_states[s,5] == all_states[s+1,5] /\
         all_states[s,6] == all_states[s+1,6] /\
         all_states[s,9] == all_states[s+1,9])
         \/
         (plus_center(all_states, s, 8) /\
         plus_increment_threes(all_states, s, 5, 7, 9) /\
         all_states[s,1] == all_states[s+1,1] /\
         all_states[s,2] == all_states[s+1,2] /\
         all_states[s,3] == all_states[s+1,3] /\
         all_states[s,4] == all_states[s+1,4] /\
         all_states[s,6] == all_states[s+1,6])
         \/
         (plus_center(all_states, s, 9) /\
         plus_increment_twos(all_states, s, 6, 8) /\
         all_states[s,1] == all_states[s+1,1] /\
         all_states[s,2] == all_states[s+1,2] /\
         all_states[s,3] == all_states[s+1,3] /\
         all_states[s,4] == all_states[s+1,4] /\
         all_states[s,5] == all_states[s+1,5] /\
         all_states[s,7] == all_states[s+1,7])
    );
        
% The goal is to reach a state where all values are 9.
constraint 
    all_states[final_state,1] == 9 /\
    all_states[final_state,2] == 9 /\
    all_states[final_state,3] == 9 /\
    all_states[final_state,4] == 9 /\
    all_states[final_state,5] == 9 /\
    all_states[final_state,6] == 9 /\
    all_states[final_state,7] == 9 /\
    all_states[final_state,8] == 9 /\
    all_states[final_state,9] == 9;

constraint
      exists(s in States) (
      row(all_states,s) == [9,9,9,9,9,9,9,9,9]
      );
    
solve minimize final_state; 


output [
  if i <= max_states then "State \(i): \(row(all_states,i))\n" else " " endif
  | i in 0..max_states
]

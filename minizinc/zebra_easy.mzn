% Solves Easy Fancy Hotels Zebra Puzzle
%
% https://www.brainzilla.com/logic/zebra/fancy-hotels/
% Five fancy hotels were built side by side in the same street in different decades.
% Which hotel is the oldest?

include "globals.mzn";

set of int: Things = 1..5;

set of int: Colors = 0..4;
int: Blue = 0;
int: Green = 1;
int: Purple = 2;
int: Red = 3;
int: White = 4;

set of int: Names = 0..4;
int: Mirage = 0;
int: Palace = 1;
int: Royal = 2;
int: Seashore = 3;
int: Vortex = 4;

set of int: Owners = 0..4;
int: American = 0;
int: British = 1;
int: French = 2;
int: German = 3;
int: Italian = 4;

set of int: Managers = 0..4;
int: Calvin = 0;
int: Derrick = 1;
int: Ian = 2;
int: Roger = 3;
int: Wesley = 4;

set of int: Rooms = 0..4;
int: oneHundred = 0;
int: oneFifty = 1;
int: twoHundred = 2;
int: twoFifty = 3;
int: threeHundred = 4;

set of int: Founded = 0..4;
int: nineteenTens = 0;
int: nineteenTwenties = 1;
int: nineteenThirties = 2;
int: nineteenForties = 3;
int: nineteenFifties = 4;

array[Colors] of var Things: color;
array[Names] of var Things: name;
array[Owners] of var Things: owner;
array[Managers] of var Things: manager;
array[Rooms] of var Things: room;
array[Founded] of var Things: found;

predicate nextto(var Things:a1, var Things:a2) = 
       a1 == a2 + 1 \/ a2 == a1 + 1;

predicate rightof(var Things:a1, var Things:a2) = 
       a1 == a2 + 1;
       
predicate leftof(var Things:a1, var Things:a2) = 
       a2 == a1 + 1;

predicate middle(var Things:a) = a == 3;

predicate left(var Things:a) = a = 1;

predicate right(var Things:a) = a = 5;

predicate ends(var Things:a) = 
        a == 1 \/ a == 5;
        
predicate two(var Things:a) = a = 2;

constraint
	alldifferent(color) /\
	alldifferent(name) /\
	alldifferent(owner) /\
	alldifferent(manager) /\
	alldifferent(room) /\
	alldifferent(found) /\
	room[threeHundred] > name[Palace] /\
	room[threeHundred] < room[oneFifty] /\
	found[nineteenThirties] == 2 /\
	color[White] < room[oneHundred] /\
	middle(owner[German]) /\
	owner[American] < room[oneHundred] /\
	owner[American] > room[twoFifty] /\
	owner[American] < color[White] /\
	manager[Roger] == color[Red] /\
	name[Seashore] == room[threeHundred] /\
	name[Vortex] > color[Green] /\
	owner[Italian] == found[nineteenFifties] /\
	room[twoFifty] `leftof` manager[Roger] /\
	owner[French] == 1 /\
	color[Green] < room[twoHundred] /\
	manager[Ian] == 1 /\
	name[Royal] > owner[French] /\
	name[Royal] < name[Mirage] /\
	owner[Italian] == 4 /\
	color[White] == name[Royal] /\
	manager[Calvin] == 4 /\
         color[Green] < found[nineteenForties] /\
         color[White] `nextto` found[nineteenThirties] /\
         manager[Calvin] > color[Blue] /\
         manager[Calvin] < manager[Derrick] /\
         found[nineteenTwenties] == 3;
         
	
solve satisfy;
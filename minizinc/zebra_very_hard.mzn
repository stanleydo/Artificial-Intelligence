% Solves Very Hard Secret Agents Zebra Puzzle
%
% https://www.brainzilla.com/logic/zebra/secret-agents/
% Five spies are side by side in a briefing room getting instructions for their next missions. 
% Each spy has a exclusive accessory, a special skill and is going travel to a determined country. 
% Which one is a martial arts expert?

include "globals.mzn";

set of int: Agents = 1..5;

set of int: Ties = 0..4;
int: Black = 0;
int: Blue = 1;
int: Green = 2;
int: Purple = 3;
int: Red = 4;

set of int: Names = 0..4;
int: Austin = 0;
int: James = 1;
int: Jason = 2;
int: Stan = 3;
int: Sterling = 4;

set of int: Countries = 0..4;
int: Australia = 0;
int: Brazil = 1;
int: Germany = 2;
int: Libya = 3;
int: Russia = 4;

set of int: Accessories = 0..4;
int: Clock = 0;
int: Pen = 1;
int: Phone = 2;
int: Ring = 3;
int: Umbrella = 4;

set of int: Skills = 0..4;
int: ComputerHacking = 0;
int: Disguise = 1;
int: Driving = 2;
int: MartialArts = 3;
int: Parkour = 4;

set of int: Ages = 0..4;
int: TwentyFive = 0;
int: Thirty = 1;
int: ThirtyFive = 2;
int: Forty = 3;
int: FortyFive = 4;

array[Ties] of var Agents: tie;
array[Names] of var Agents: name;
array[Accessories] of var Agents: accessory;
array[Countries] of var Agents: country;
array[Skills] of var Agents: skill;
array[Ages] of var Agents: age;

predicate nextto(var Agents:a1, var Agents:a2) = 
       a1 == a2 + 1 \/ a2 == a1 + 1;

predicate rightof(var Agents:a1, var Agents:a2) = 
       a1 == a2 + 1;
       
predicate leftof(var Agents:a1, var Agents:a2) = 
       a2 == a1 + 1;

predicate middle(var Agents:a) = a == 3;

predicate left(var Agents:a) = a = 1;

predicate right(var Agents:a) = a = 5;

predicate ends(var Agents:a) = 
        a == 1 \/ a == 5;
        
predicate two(var Agents:a) = a = 2;

constraint
	alldifferent(tie) /\
	alldifferent(name) /\
	alldifferent(accessory) /\
	alldifferent(country) /\
	alldifferent(skill) /\
	alldifferent(age) /\
	name[Austin] `nextto` tie[Black] /\
	skill[Disguise] `rightof` accessory[Umbrella] /\
	age[ThirtyFive] == country[Libya] /\
	name[James] == age[TwentyFive] /\
	country[Australia] `nextto` skill[Parkour] /\
	name[James] `rightof` accessory[Clock] /\
	accessory[Umbrella] > age[Forty] /\
	accessory[Umbrella] < name[Austin] /\
	name[Stan] `nextto` country[Russia] /\
	ends(name[Sterling]) /\
	tie[Red] == age[Forty] /\
	country[Brazil] `leftof` age[FortyFive] /\
	name[Jason] `leftof` name[Austin] /\
	skill[Driving] `nextto` age[Thirty] /\
	age[ThirtyFive] `nextto` country[Australia] /\
	skill[ComputerHacking] `leftof` age[ThirtyFive] /\
	tie[Purple] `nextto` skill[ComputerHacking] /\
	name[Austin] == age[Thirty] /\
	accessory[Phone] `leftof`country[Libya] /\
	accessory[Ring] > tie[Purple] /\
	two(tie[Green]) /\
	country[Australia] `rightof` age[Thirty];
	
solve satisfy;
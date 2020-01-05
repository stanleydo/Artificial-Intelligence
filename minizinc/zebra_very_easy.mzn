% Solves Very Easy Crocodile Zebra Puzzle
%
% https://www.brainzilla.com/logic/zebra/who-owns-the-crocodile/
% Five girls are sitting in a row. 
% Each girl has a favorite color, a chocolate bar, a pet, a hobby, and a place to go on holiday.
% Determine the name of the girl who owns the crocodile.

include "globals.mzn";

set of int: Girls = 1..5;

set of int: Colors = 0..4;
int: Blue = 0;
int: Green = 1;
int: Lilac = 2;
int: Pink = 3;
int: Purple = 4;

set of int: Names = 0..4;
int: Georgina = 0;
int: Hannah = 1;
int: Jessica = 2;
int: Jo = 3;
int: Lucy = 4;

set of int: Chocolates = 0..4;
int: Boost = 0;
int: Crunchies = 1;
int: DairyMilk = 2;
int: MilkyBars = 3;
int: WispaBites = 4;

set of int: Pets = 0..4;
int: Crocodile = 0;
int: Hamster = 1;
int: Horse = 2;
int: Puppy = 3;
int: Rabbit = 4;

set of int: Hobbies = 0..4;
int: HorseRiding = 0;
int: Skiing = 1;
int: Swimming = 2;
int: TenPinBowling = 3;
int: Tennis = 4;

set of int: Holidays = 0..4;
int: Australia = 0;
int: Canada = 1;
int: Florida = 2;
int: Maldives = 3;
int: Tobago = 4;

array[Colors] of var Girls: color;
array[Names] of var Girls: name;
array[Chocolates] of var Girls: chocolate;
array[Pets] of var Girls: pet;
array[Hobbies] of var Girls: hobby;
array[Holidays] of var Girls: holiday;

predicate nextto(var Girls:g1, var Girls:g2) = 
       g1 == g2 + 1 \/ g2 == g1 + 1;

predicate rightof(var Girls:g1, var Girls:g2) = 
       g1 == g2 + 1;
       
predicate leftof(var Girls:g1, var Girls:g2) = 
       g1 == g2 - 1;

predicate middle(var Girls:g) = g == 3;

predicate left(var Girls:g) = g = 1;

predicate right(var Girls:g) = g = 5;

constraint
	alldifferent(color) /\
	alldifferent(name) /\
	alldifferent(chocolate) /\
	alldifferent(pet) /\
	alldifferent(hobby) /\
	alldifferent(holiday) /\
	name[Jo] == chocolate[WispaBites] /\
	pet[Hamster] == hobby[Swimming] /\
	name[Hannah] == chocolate[DairyMilk] /\
	name[Jessica] `leftof` name[Georgina] /\
	left(name[Lucy]) /\
	right(hobby[Swimming]) /\
	chocolate[MilkyBars] == pet[Horse] /\
	middle(chocolate[DairyMilk]) /\
	name[Jessica] == color[Green] /\
	holiday[Tobago] `leftof` chocolate[DairyMilk] /\
	holiday[Maldives] == color[Lilac] /\
	chocolate[WispaBites] `nextto` holiday[Florida] /\
	color[Pink] == holiday[Florida] /\
	left(color[Lilac]) /\
	color[Blue] == pet[Puppy] /\
	hobby[Skiing] `nextto` pet[Hamster] /\
	hobby[HorseRiding] `rightof` hobby[Tennis] /\
	chocolate[Boost] `nextto` chocolate[MilkyBars] /\
	color[Purple] == holiday[Canada] /\
	chocolate[Crunchies] == pet[Rabbit] /\
	hobby[Skiing] `nextto` hobby[TenPinBowling] /\
	name[Jessica] == holiday[Australia];
	
solve satisfy;
	
output [
	"zebra:\n",
	"colors = [",
	show(color[0]), ", ",
	show(color[1]), ", ",
	show(color[2]), ", ",
	show(color[3]), ", ",
	show(color[4]), "]\n",
	"names = [",
	show(name[0]), ", ",
	show(name[1]), ", ",
	show(name[2]), ", ",
	show(name[3]), ", ",
	show(name[4]), "]\n",
	"chocolates = [",
	show(chocolate[0]), ", ",
	show(chocolate[1]), ", ",
	show(chocolate[2]), ", ",
	show(chocolate[3]), ", ",
	show(chocolate[4]), "]\n",
	"pets  = [",
	show(pet[0]), ", ",
	show(pet[1]), ", ",
	show(pet[2]), ", ",
	show(pet[3]), ", ",
	show(pet[4]), "]\n",
	"hobbies  = [",
	show(hobby[0]), ", ",
	show(hobby[1]), ", ",
	show(hobby[2]), ", ",
	show(hobby[3]), ", ",
	show(hobby[4]), "]\n",
	"holidays = [",
	show(holiday[0]), ", ",
	show(holiday[1]), ", ",
	show(holiday[2]), ", ",
	show(holiday[3]), ", ",
	show(holiday[4]), "]\n"
];
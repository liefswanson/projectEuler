import std.c.stdlib  : exit;
import std.stdio     : writeln;
import std.file      : readText;

import std.algorithm : map, max, splitter;
import std.array     : array;
import std.conv      : to;

void
main(string[] args) {
	if (args.length < 2) {
		writeln("Specify a path to a file with a triangle of numbers inside it.");
		exit(1);
	}

	string f;
	try {
		f = readText(args[1]);
	} catch {
		writeln("There was a problem reading \"" ~ args[1] ~ "\", is the path correct?");
		exit(1);
	}
	
	int[][] nums       = [];
	int[]   heuristics = [];
	int     maximum    = 0;

	{
		auto lines = splitter(f, "\n");
		auto words = array(map!(a => splitter(a, " "))   (lines));
		auto vals  = map!(map!(a => to!(int) (a))) (words[0 .. $-1]);

		foreach(line; vals){
			nums ~= array(line);
		}
	}
	
	
	foreach(line; nums) {
		int largest = 0;
		foreach(num; line) {
			largest = max(largest, num);
		}
		heuristics ~= largest;
	}

	foreach(num; heuristics) {
		maximum = max(num, maximum);
	}

	// take compliment around the max number
	// eg. 5 around 100 is 95
	foreach(line; nums) {
		foreach(num; line) {
			num = maximum - num;
		}
	}

	foreach(num; heuristics) {
		num = maximum - num;
	}
	
	writeln(maximum);
}

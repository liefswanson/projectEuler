import std.c.stdlib  : exit;
import std.stdio     : writeln;
import std.file      : readText;

import std.algorithm : map, max, splitter, filter;
import std.array     : array;
import std.conv      : to;

import graph;

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
		auto words = map!(a => splitter(a, " "))   (lines);
		auto parse = map!(map!(a => to!(int) (a))) (words);

		// remove empty lines
		foreach(line; parse){
			auto temp = array(line);
			if (temp != []){
				nums ~= temp;
			}
		}
	}

	// writeln(nums);
	foreach(line; nums) {
		int largest = 0;
		foreach(num; line) {
			largest = max(largest, num);
		}
		heuristics ~= largest;
	}

	// writeln(heuristics);
	foreach(num; heuristics) {
		maximum = max(num, maximum);
	}

	// take compliment around the max number
	// eg. 5 around 100 is 95
	// eg. 4 around 25  is 21
	foreach(ref line; nums) {
		foreach(ref num; line) {
			num = maximum - num;
		}
	}

	foreach(ref num; heuristics) {
		num = maximum - num;
	}
	
	// writeln(maximum);
	// writeln(nums);
	// writeln(heuristics);
	Graph g = new Graph(nums);
	writeln(g);
}

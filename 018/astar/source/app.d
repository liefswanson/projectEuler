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
		writeln("There was a problem reading \"", args[1], "\", is the path correct?");
		exit(1);
	}

	int[][] nums       = parsenums(f);
	int[]   heuristics = findheuristics(nums);
	int     maximum    = maxNum(heuristics);

	// take compliment around the max number
	// eg. 5 around 100 is 95
	// eg. 4 around 25  is 21
	foreach(ref line; nums) {
		foreach(ref num; line) {
			num = maximum - num;
		}
	}

	// also compliment the heuristics
	foreach(ref num; heuristics) {
		num = maximum - num;
	}

	int[] cdf   = heuristics;
	int   tally = 0;
	for(int i  = cdf.length-1; i >= 0; i--) {
		tally += cdf[i];
		cdf[i] = tally;
	}
	
	Graph g = new Graph(nums, heuristics);
	writeln(g);
	
	//writeln(*g.start);
	//writeln(*g.start.adjacent[0]);
    writeln(*g.goal);
}

int[][]
parsenums(string input) {
	int[][] nums = [];
	auto lines = splitter(input, "\n");
	auto words = map!(a => splitter(a, " "))   (lines);
	auto parse = map!(map!(a => to!(int) (a))) (words);

	// remove empty lines
	foreach(line; parse){
		auto temp = array(line);
		if (temp != []){
			nums ~= temp;
		}
	}
	return nums;
}

int[]
findheuristics(int[][] nums) {
	int[] heuristics = [];
	foreach(line; nums) {
		int largest = maxNum(line);
		heuristics ~= largest;
	}
	return heuristics;
}

int
maxNum(int[] nums){
	int maximum = int.min;
	foreach(num; nums) {
		maximum = max(num, maximum);
	}
	return maximum;
}

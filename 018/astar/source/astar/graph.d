module graph;

import std.stdio : writeln, write;
import std.conv;
import node;

class Graph {
	public Node[][] nodes;
	public Node*     goal;
	public Node*    start;
	
	// it should be noted that concatenation is probably very slow
	public this (const ref int[][] values,
				 const ref int[]   heuristic) {
		buildNodes(values);
		setHeuristics(heuristic);
		
		this.start = &this.nodes[0][0];
		auto temp  = new Node(0); 
		this.goal  = &temp;

		buildLinks();
	}

	private
	void buildNodes(const ref int[][] values) {
		nodes = [];
		
		foreach(line; values) {
			Node[] current = [];
			
			foreach(value; line) {
				auto temp = new Node(value); 
				current ~= temp;
			}
			nodes ~= current;
		}
	}

	private
	void buildLinks() {
		foreach(i, ref line; nodes[0..$-1]) {
			foreach(j, ref node; line) {
				node.adjacent ~= [&nodes[i+1][j], &nodes[i+1][j+1]];
			}
		}

		foreach(ref node; nodes[$-1]) {
			node.adjacent ~= goal;
		}
	}

	private
	void setHeuristics(const ref int[] heuristics) {
		foreach(i, ref line; nodes) {
			foreach(j, ref node; line) {
				node.heuristic = heuristics[i];
			}
		}
	}

	public override
	string toString() {
		return to!(string)(nodes);
	}
}

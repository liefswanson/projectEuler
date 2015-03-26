module graph;

import std.stdio : writeln;
import std.conv;
import node;

class Graph {
	public Node[][] nodes;
	public Node     goal;
	public Node*    start;
	
	private this (Node[][] nodes){
		this.nodes = nodes;
		this.start = &this.nodes[0][0];

		auto temp = new Node(0);
		this.goal = temp;
	}

	// it should be noted that concatenation is probably very slow
	public this (const ref int[][] values){
		nodes = [];
		
		foreach(line; values) {
			Node[] current = [];
			
			foreach(value; line) {
				auto temp = new Node(value); 
				current ~= temp;
			}
			nodes ~= current;
		}
		
		this.start = &this.nodes[0][0];

		auto temp  = new Node(0);
		this.goal  = temp;
	}

	public override
	string toString() {
		return to!(string)(nodes);
	}
}

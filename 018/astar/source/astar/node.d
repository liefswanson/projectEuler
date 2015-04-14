module node;
import std.conv;

class Node {
	public Node*[] adjacent;
	public int value;
	public int heuristic;

	public this(int value) {
		this.value = value; 
	}

	public override
	string toString(){
		return to!(string)(value);
	}
}

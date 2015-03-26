module node;
import std.conv;

class Node {
	public Node*[] adjacent;
	public int value;
	public int heuristic;

	public this(int value) {
		this.value = value; 
	}

	public void
	AddAdjacent(Node*[] adjacent) {
		this.adjacent ~= adjacent;
	}

	public override
	string toString(){
		return to!(string)(value);
	}
}

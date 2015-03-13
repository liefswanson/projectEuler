//Copyright (C) 2014 Lief Swanson

//This program is free software; you can redistribute it and/or modify
//it under the terms of the GNU General Public License as published by
//the Free Software Foundation; either version 2 of the License, or
//(at your option) any later version.

//This program is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//GNU General Public License for more details.

//You should have received a copy of the GNU General Public License
//along with this program; if not, write to the Free Software
//Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

//Author: Lief Swanson
//URL: https://github.com/liefswanson

/*
Package main:
builds a triangluar single direction graph and then uses A* to find the longest path
- read a file and construct a graph
- inverts the graph about the maximum path value
- build a heuristic for each node
- run A* to find shortest path
- take shortest path and invert about largest value
- sum up the length of the inverted shortest path (aka longest path)
- print the longest path and the sum of the path length
*/

package main


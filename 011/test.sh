#! /bin/bash

# this file is designed for calling the large number of testing grids I built
# it should be noted these test grids checks the edge cases for the diagonal
# it also checks for grids of non square, but still rectilinear, proportionals

# A test can be called successful, only if the product was 20!/(20-productLength)!

# there are no grids designed to check the vertical and horizontal functions
# these would be trivial to construct

# malformed grids could be added to check the programs error-checking abilities
# grids with more integers in one row or column than another
# extra white-space either in a new line, after a line, or between elements
# non-integers value in the grid (ex "5o" vs "50")

productLength="4"
programName="main.go"

function edges {
	echo $1
	echo "square"
	go run $programName $productLength $1
	echo ""
	echo "wide"
	go run $programName $productLength wide$1
	echo ""
	echo "long"
	go run $programName $productLength long$1
	echo "-----------------------------------"
	echo ""
}

edges tl
edges tr
edges bl
edges br
echo "projectEuler solution"
go run $programName $productLength grid

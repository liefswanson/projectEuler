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
Package main takes a file, representing a grid of integers, and finds the largest product of a line of terms, either vertically, horizontally, or diagonally.

example of file formatting.

08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08
49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00
81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65
52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91
22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80
24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50
32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70
67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21
24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72
21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95
78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92
16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57
86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58
19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40
04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66
88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69
04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36
20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16
20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54
01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48

note the number of decimal places in a integer is NOT important.
However, the number of integers per line MUST be the same, or else the program will exit with failure.

*/

package main

import (
	"fmt"
	"log"
	"strconv"
	"os"
	"io/ioutil"
	"strings"
	"sync"
)


func main() {
	if len(os.Args) == 3 {
		filePath := os.Args[2]
		productLength, err := strconv.Atoi(os.Args[1])
		if  err != nil || productLength < 1 {
			log.Fatal("the number of integers in the product must be am integer greater than 0")
		}

		file, err := ioutil.ReadFile(filePath)
		if err != nil {
			log.Fatal(err)
		}

		unparsed := string(file)
		grid, err := translateGrid(unparsed)
		if err != nil {
			log.Fatal(err)
		}
		if productLength > len(grid) || productLength > len(grid[0]) {
			msg := "\n The product was longer than the than one of the dimensions of the grid"
			msg += fmt.Sprintf("\n grid height   : %d",len(grid))
			msg += fmt.Sprintf("\n grid width    : %d",len(grid[0]))
			msg += fmt.Sprintf("\n product length: %d",productLength)

			log.Fatal(msg)
		}

		//fmt.Println(grid)
		
		maxSeq, max := largestProduct(productLength, grid)
		fmt.Println("")
		fmt.Println(maxSeq)
		fmt.Println(max)
	} else {
		msg := "\n Usage:"
		msg += "\n arg0: length of product"
		msg += "\n arg1: path to file containing grid of integers"
		msg += "\n"
		log.Fatal(msg)
	}
}

func largestProduct(productLength int, grid [][]int) ([]int, int) {
	const directions int = 4
	
	maxs := make([]int, directions)
	maxSeqs := make([][]int, directions)
	for i := range maxs {
		maxSeqs[i] = make([]int, productLength)
	}

	var wg sync.WaitGroup
	wg.Add(directions)

	go horizontal(&maxSeqs[0], &maxs[0], grid, productLength, &wg)
	go vertical(&maxSeqs[1], &maxs[1], grid, productLength, &wg)
	go diagonal(&maxSeqs[2], &maxs[2], grid, productLength, &wg)
	go reverseDiagonal(&maxSeqs[3], &maxs[3], grid, productLength, &wg)
	
	wg.Wait()
	
	max := 0
	maxSeq := make([]int, productLength)
	for i := range maxs {
		fmt.Println(maxSeqs[i])
		if maxs[i] > max {
			max = maxs[i]
			copy(maxSeq, maxSeqs[i])
		}
	}
	return maxSeq, max
}


//DEBUGGING NOTE!
//---------------
//len(grid) == # of rows
//len(grid[0]) == # of columns

func horizontal(maxSeq *[]int, max *int, grid [][]int, productLength int, wg *sync.WaitGroup) {

	for row := range grid {
		head := 0
		tail := head + productLength
		
		for tail <= len(grid[0]) {
			tempSeq := grid[row][head:tail]
			temp := 1
			
			for _, val := range tempSeq {
				temp *= val
			}
			if temp > *max {
				*max = temp
				copy(*maxSeq, tempSeq)
			}
			head++
			tail++
		}
	}
	
	wg.Done()
}


func vertical(maxSeq *[]int, max *int, grid [][]int, productLength int, wg *sync.WaitGroup) {
	
	for column := range grid[0] {
		head := 0
		tail := head + productLength
		
		for tail <= len(grid) {
			tempSeq := make([]int, productLength)
			temp := 1
			
			for offset := range tempSeq {
				tempSeq[offset] = grid[head+offset][column]
				temp *= tempSeq[offset]
			}
			if temp > *max {
				*max = temp
				copy(*maxSeq, tempSeq)
			}
			head++
			tail++
		}
	}

	wg.Done()
}

func diagonal(maxSeq *[]int, max *int, grid [][]int, productLength int, wg *sync.WaitGroup) {

	for column := range grid[0][:len(grid[0])-productLength+1] {
		row := 0
		tail := row + productLength
		
		for tail <= len(grid) {
			tempSeq := make([]int, productLength)
			temp := 1
			
			for i := range tempSeq {
				tempSeq[i] = grid[row + i][column + i]
				temp *= tempSeq[i]
			}
			if temp > *max {
				*max = temp
				copy(*maxSeq, tempSeq)
			}
			row++
			tail++
		}
	}
	wg.Done()
}

func reverseDiagonal(maxSeq *[]int, max *int, grid [][]int, productLength int, wg *sync.WaitGroup) {

	for column := len(grid[0])-1; column >= productLength-1; column-- {
		row := 0
		tail := row + productLength
		for tail <= len(grid){
			tempSeq := make([]int, productLength)
			temp := 1
			
			for i := range tempSeq {
				tempSeq[i] = grid[row+i][column-i]
				temp *= tempSeq[i]
			}
			if temp > *max {
				*max = temp
				copy(*maxSeq, tempSeq)
			}
			row++
			tail++
		}
	}
	wg.Done()
}

func translateGrid(unparsed string) ([][]int, error) {

	tempLines := strings.Split(unparsed, "\n")
	parsed := make([][]string, len(tempLines))
	for i, line := range tempLines {
		parsed[i] = strings.Split(line, " ")
	}
	tempLines = nil
	
	formatErr := validateGridFormatting(parsed)
	
	integers := make([][]int, len(parsed))
	for i := range parsed {
		integers[i] = make([]int, len(parsed[0]))
	}

	for i := range integers {
		for j := range integers[i] {
			temp, err := strconv.Atoi(parsed[i][j])
			integers[i][j] = temp
			if err != nil {
				msg := "\n There is a non integer in the grid"
				msg += fmt.Sprintf("\n line = %d \n word = %d \n value = \"%s\"", i+1, j+1, parsed[i][j])
				log.Fatal(msg)
			}
		}
	}

	return integers, formatErr
}

func validateGridFormatting(grid [][]string) error {
	lengths := make([]int, len(grid))

	fail := false
	var lengthErr error = nil

	for i := range grid {
		lengths[i] = len(grid[i])
		if lengths[0] != lengths[i] {
			fail = true
		}
	}
	
	if fail {
		temp := "\n The grid was not properly formatted."
		temp += "\n Not all lines in the grid contain the same number of integers"
		temp += "\n or there are too many spaces between some entries"
		temp += "\n or there are empty lines in the file"
		temp += "\n"
		
		for i, length := range lengths {
			temp += fmt.Sprintf("line %d : length %d\n", i+1, length)
		}
		lengthErr = fmt.Errorf(temp)
		return lengthErr
	}
	
	return nil
}

package main

import (
	"fmt"
	"os"
	"strconv"
	"log"
)

func main() {
	if len(os.Args) > 1 {
		cap, err := strconv.Atoi(os.Args[1])
		if err != nil {
			log.Fatal(err)
		}

		sum := 0
		for i := 1; i <= cap; i++ {
			sum += i
			fmt.Printf("%d: %d\n", i, sum)
		}
		
	} else {
		log.Fatal("\nPlease give an index for the highest traingular number")
	}
}

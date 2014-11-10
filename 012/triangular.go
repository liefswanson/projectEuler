package main

import (
	"fmt"
	"os"
	"strconv"
	"log"
	"math"
)

func main() {
	if len(os.Args) > 1 {
		target, err := strconv.Atoi(os.Args[1])
		if err != nil {
			log.Fatal(err)
		}

		sum := 0
		score := 0
		for i := 1; score <= target; i++ {
			sum += i
			score = factors(sum)
			fmt.Printf("%d : %d : %d\n", i, sum, score)
		}
		
	} else {
		log.Fatal("\nPlease give an index for the highest traingular number")
	}
}

func factors(n int) int {
	//abs to ensure the factoring works
	//cardinality of the factors of -10 = that of 10 
	if n < 0 {
		n = -n
	} else if n == 0 {
		//0 has 0 factors, but will break the algorithm below
		return 0
	}
	
	sqrtn := int(math.Sqrt(float64(n)))
	factors := make([]int,0) 
	count := 0
	for i := 1; i <= sqrtn; i++ {
		if n%i == 0 {
			//fmt.Printf("%d %% %d\n",n,i)
			factors = append(factors,i)
		}
	}

	if n == int(math.Pow(float64(factors[len(factors)-1]), 2.0)) {
		count = (len(factors)-1)*2+1
	} else {
		count = len(factors)*2
	}
	//fmt.Println(factors)
	return count
}

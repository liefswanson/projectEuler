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
		log.Fatal("\nPlease give the number of factors you are looking for")
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

	middleFactor := factors[len(factors)-1]
	if n == sqr(middleFactor){
		count = (len(factors)-1)*2+1 //n is a perfect square
	} else {
		count = len(factors)*2
	}
	//fmt.Println(factors)
	return count
}

func sqr(n int) int {
	return pow(n,2)
}

func pow(n,ex int) int {
	product := 1
	for i:=0; i < ex; i++ {
		product*=n
	}
	return product
}

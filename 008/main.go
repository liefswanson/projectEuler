/*
Package main takes a string of numbers and then iterates over them to find the largest product of any n terms in the sequence+
*/

package main

import (
	"fmt"
	"os"
	"strconv"
	"log"
)

//const q008sequence string = "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450"

func main() {
	if len(os.Args) > 2 {
		numSequence := translateSequence(os.Args[2])
		productLength, err := strconv.Atoi(os.Args[1])
		if err != nil {
			log.Fatal(err)
		}

		composite, product := largestProduct(productLength, numSequence)
		
		fmt.Println(composite)
		fmt.Println(product)
		
	} else {
		log.Fatal("\nMissing arguments: \narg0: length of product \narg1: sequence to iterate over")
	}
}

func largestProduct(productLength int, sequence []int) ([]int,int) {
	head, tail := 0, productLength
	max := 0
	maxSeq := make([]int,0,productLength)

	for tail <= len(sequence) {
		tempSeq := sequence[head:tail]
		temp := 1
		for _, val := range tempSeq {
			temp *= val
		}
		if temp > max {
			max = temp
			maxSeq = tempSeq
		}
		head++
		tail++
	}

	retSeq := make([]int, productLength)
	copy(retSeq, maxSeq)
	return retSeq, max
}


func translateSequence(sequence string) []int {
	result := make([]int,len(sequence))

	i := 0
	for _, runeValue := range sequence {
		temp, err := strconv.Atoi(fmt.Sprintf("%c", runeValue))
		if err != nil {
			log.Fatal(err)
		} 
		result[i] = temp
		i++
	}
	
	return result
}

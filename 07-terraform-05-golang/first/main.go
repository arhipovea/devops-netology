package main

import "fmt"

func main() {
	fmt.Print("Enter length in meters: ")
	var meter float64
	fmt.Scanf("%f", &meter)
	fmt.Println("Footage: ", convert(meter))
}

func convert(meter float64) float64 {
	return meter * 3.28
}

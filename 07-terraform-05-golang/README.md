# Домашнее задание к занятию "7.5. Основы golang"

## Задача 1. Установите golang.

![pic01](https://github.com/arhipovea/devops-netology/blob/main/07-terraform-05-golang/assets/pic01.png)

## Задача 2. Знакомство с gotour.
Есть

## Задача 3. Написание кода. 
1. Напишите программу для перевода метров в футы (1 фут = 0.3048 метр). Можно запросить исходные данные 
у пользователя, а можно статически задать в коде.

[code](https://github.com/arhipovea/devops-netology/tree/main/07-terraform-05-golang/first)

```go
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
```
 
2. Напишите программу, которая найдет наименьший элемент в любом заданном списке, например:
    ```
    x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
    ```

[code](https://github.com/arhipovea/devops-netology/tree/main/07-terraform-05-golang/second)

```go
package main

import "fmt"

func main() {
	x := []int{48, 96, 86, 68, 57, 82, 63, 70, 37, 34, 83, 27, 19, 97, 9, 17}
	
	var index, value = min(x)
	
	fmt.Printf("Minimum is x[%d] = %d\n", index, value)
}

func min(array []int) (min_index int, min_value int) {
	min_index = 0
	min_value = array[min_index]
	for i, v := range array {
		if v < min_value {
			min_value = v
			min_index = i
		}
	}
	return
}
```

3. Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3. То есть `(3, 6, 9, …)`.

[code](https://github.com/arhipovea/devops-netology/tree/main/07-terraform-05-golang/third)

```go
package main

import "fmt"

func main() {
	for i := 3; i <= 100; i += 3 {
		fmt.Printf("%d ", i)
	}
}
```

## Задача 4. Протестировать код (не обязательно).

Создайте тесты для функций из предыдущего задания. 

```go
package main

import "testing"

func TestConvert(t *testing.T) {
	expected := 3.28
	received := convert(1)
	if received != expected {
		t.Errorf("Error, got: %f, want: %f", received, expected)
	}
}
```

```go
package main

import "testing"

func TestMin(t *testing.T) {
	array := [] int {15, 20, 30, 40, 50, 10, 60, 777}
	expected_index := 5
	expected_value := 10
	received_index, received_value := min(array)
	if received_index != expected_index || received_value != expected_value {
		t.Errorf("Error, got: %d, %d, want: %d, %d", received_index, received_value, expected_index, expected_value)
	}
}
```

---
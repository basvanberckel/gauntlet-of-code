package main
 
import (
    "bufio"
    "fmt"
    "os"
)
 
func main() {
 
    readFile, err := os.Open("cases/input/1")
  
    if err != nil {
        fmt.Println(err)
    }
    fileScanner := bufio.NewScanner(readFile)
 
    fileScanner.Split(bufio.ScanLines)

    fileScanner.Scan()
    prev := fileScanner.Text()
    solution := 0
  
    for fileScanner.Scan() {
        cur := fileScanner.Text()
        if cur > prev {
            solution++
        }
        prev = cur
    }

    fmt.Println(solution)
  
    readFile.Close()
}
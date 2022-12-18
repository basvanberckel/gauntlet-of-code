import java.io.File
import java.io.IOException
import java.util.*
 
fun main() {
    val fileName = "cases/input/1"
    val sc = Scanner(File(fileName))
    var solution = 0
    var prev = sc.nextLine().toInt()
    while (sc.hasNextLine()) {
        val cur = sc.nextLine().toInt()
        if (cur > prev) {
            solution++
        }
        prev = cur
    }
    println(solution)
}
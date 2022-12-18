import scala.io.Source
import scala.util.Using

object Solution {
    def main(args: Array[String]) = {
        Using(Source.fromFile("cases/input/1")) { source =>
            val lines = source.getLines()
            var solution = 0
            var prev = lines.next()
            for (cur <- lines) {
                if (cur > prev) 
                    solution += 1
                prev = cur
            }
            println(solution) 
        }
    }
}
<?

$data = file_get_contents("cases/input/2");

$re = "/Monkey \d+:
  Starting items: (?P<items>(?:\d+(?:, )?)*)
  Operation: new = old (?P<operator>.) (?P<operand>\d+|old)
  Test: divisible by (?P<test>\d+)
    If true: throw to monkey (?P<true>\d)
    If false: throw to monkey (?P<false>\d)/";

preg_match_all($re, $data, $matches, PREG_SET_ORDER);

$monkeys = array();
foreach ($matches as $match) {
    $monkey = array(
        "items" => explode(", ", $match["items"]),
        "operator" => $match["operator"],
        "operand" => $match["operand"],
        "test" => $match["test"],
        "to" => array(true => (int)$match["true"], false => (int)$match["false"])
    );
    array_push($monkeys, $monkey);
}

function operation($old, $operator, $operand)
{
    if ($operand == "old") $operand = $old;
    switch ($operator) {
        case '+':
            return $old + $operand;
        case '*':
            return $old * $operand;
        case '/':
            return $old / $operand;
        case '-':
            return $old - $operand;
    }
}

$divisor = 1;
foreach ($monkeys as $monkey) {
    $divisor *= $monkey["test"];
}

$counts = array_fill(0, count($monkeys), 0);
for ($j=0; $j < 10000; $j++) { 
    for($i = 0; $i < count($monkeys); $i++) {
        while($item = array_shift($monkeys[$i]["items"])) {
            $counts[$i]++;
            $item = operation($item, $monkeys[$i]["operator"], $monkeys[$i]["operand"]);
            $item %= $divisor;
            $test = $item % $monkeys[$i]["test"] == 0;
            $to = $monkeys[$i]["to"][$test];
            array_push($monkeys[$to]["items"], $item);
        }
    }
}

rsort($counts);
print_r($counts[0] * $counts[1]);
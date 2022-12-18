<?

$handle = fopen("cases/input/1", "r");

$prev = fgets($handle);
$solution = 0;
while (($cur = fgets($handle)) !== false) {
    $solution += $cur > $prev;
    $prev = $cur;
}

echo $solution;

fclose($handle);
use strict;
use warnings;

my $file = 'cases/input/1';
open my $info, $file or die "Could not open $file: $!";

my $solution = 0;
my $prev = <$info>;

while( my $cur = <$info>)  {
    if ($cur > $prev) {
        $solution++;
    }
    $prev = $cur;
}

print $solution;

close $info;
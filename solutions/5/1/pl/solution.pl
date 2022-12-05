use strict;
use warnings;

my $file = 'cases/input/2';
open my $info, $file or die "Could not open $file: $!";

my @cols;

while( my $line = <$info>)  {
    last if (($line cmp "\n") == 0);
    my $col = 0;
    while($line =~ m/(?:(   )|(?:\[([A-Z])\])) ?/g) {
        push (@{ $cols[$col] }, $2) if(defined($2));
        ++$col;
    }
}

while( my $line = <$info>)  {
    $line =~ m/move (?<amount>\d+) from (?<from>\d+) to (?<to>\d+)/;
    for (1..$+{amount}) {
        unshift @{ $cols[$+{to}-1] }, shift @{ $cols[$+{from}-1] };;
    }
}

for my $col (@cols) {
    print @$col[0];
}

close $info;
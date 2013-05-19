package Vol01;
use strict;
use warnings;
use POSIX;

# Question
sub compound {
	my ($base, $interest, $term) = @_;

	my $BASE_DEFAULT = 10_000;
	my $INTEREST_DEFAULT = 5.0;
	my $TERM_DEFAULT = 10;

	if (!defined($base)) {
		$base = $BASE_DEFAULT;
	}

	if (!defined($interest)) {
		$interest = $INTEREST_DEFAULT;
	}

	if (!defined($term)) {
		$term = $TERM_DEFAULT;
	}

	my $BASE_LIMIT = 1_000_000;
	my $INTEREST_LIMIT = 10.0;
	my $TERM_LIMIT = 50;

	if (isNatural($base,     $BASE_LIMIT,     1) != 1 ||
		isNatural($term,     $TERM_LIMIT,     1) != 1) {
			return 0;
	}

	unless (isFloat($interest) == 1 && isNatural(ceil($interest), 10, 1)) {
		return 0;
	}

	my @repayments = ($base);

	for my $t (1..$term) {
		my $r = floor(($base * (1.0 + $interest / 100) ** $t) + 0.5);
		push(@repayments, int($r));
	}
	return \@repayments;
}

# Question
sub isPrime {
	my $n = shift;	
	if (isNatural($n) == 0) {
		return -1;
	}

	if ($n < 2) {
		return 0;
	}

	for my $a (2..floor(sqrt($n))) {
		if ($n % $a == 0) {
			return 0;
		}
	}

	return 1;
}

# Question
sub sumTotal {
	my $n = shift;
	my $MAX = 92683;
	my $DEFAULT = 100;

	if (!defined($n)) {
		$n = $DEFAULT;
	}

	if (isNatural($n, $MAX) < 1) {
		return -1;
	}

	#my $total = 0;
	#for my $x (1..$n) {
	#	$total += $x;
	#}
	#return $total;
	return (1 + $n) * $n / 2;
}

#
sub isFloat {
	my $f = shift;

	if (defined($f) && $f =~ /^[+-]?(\d+|\d+\.\d+|\.\d+|\d+\.)$/) {
		return 1;
	}

	return 0;
}

# Question
sub isNatural {
	my ($i, $max, $min) = @_;
	my $MAX = 0xFFFFFFFF - 1;
	my $MIN = 0;

	if (!defined($i))	{ return 0; }
	if (!defined($max))	{ $max = $MAX; }
	if (!defined($min))	{ $min = $MIN; }

	if ( !($max =~ /^\d+$/ && $max > 0 && $max <= $MAX) ||
		 !($min =~ /^\d+$/ && $min >= 0 && $min < $max) ){
		return -1;
	}

	if ($i =~ /^\d+$/ && $i >= $min && $i <= $max) {
		return 1;
	}

	return 0;
}

sub circleArea {
	my ($r) = @_;

	if (!defined($r)) {
		$r = 10;
	}

	my $PI = atan2(1,1) * 4;
	my $volume = $PI * ($r ** 2);
	return sprintf("%.8f", $volume);
}

1;

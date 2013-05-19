package Vol00;
use strict;
use warnings;

#Q000
sub kuku {
	my ($x, $y) = @_;

	my $ERROR = "ERROR";

	if (!defined($x) || $x !~ /^[1-9]$/ ||
	 	!defined($y) || $y !~ /^[1-9]$/ ) {
			return $ERROR;
	}

	return $x * $y;
}

1;

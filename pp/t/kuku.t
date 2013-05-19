#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use Digest::SHA1;
use lib './t/lib';
use TestHarness;

BEGIN{ 
	use_ok('Vol00');
	#ok(TestHarness::checkHash($0));
	if (Vol00::kuku() eq -999) {
		notImplement();
		done_testing();
		exit(-9);
	}
};

my $ERROR = "ERROR";
my $MIN = 1;
my $MAX = 9;
my $MED = 5;

# bad
# no arg.
is(Vol00::kuku(),				$ERROR, "no arg");
is(Vol00::kuku($MIN),			$ERROR, "1st arg only. MIN");
is(Vol00::kuku($MAX),			$ERROR, "1st arg only. MAX");
is(Vol00::kuku(undef, $MIN),		$ERROR, "2st arg only. MIN");
is(Vol00::kuku(undef, $MAX),		$ERROR, "2st arg only. MAX");
is(Vol00::kuku(undef, $MIN),		$ERROR, "2st arg only. MIN");
is(Vol00::kuku(undef, $MAX),		$ERROR, "2st arg only. MAX");

is(Vol00::kuku($MIN-1),			$ERROR, "1st arg only. MIN-1");
is(Vol00::kuku($MAX+1),			$ERROR, "1st arg only. MAX+1");
is(Vol00::kuku(undef, $MIN-1),	$ERROR, "2st arg only. MIN-1");
is(Vol00::kuku(undef, $MAX+1),	$ERROR, "2st arg only. MAX+1");
is(Vol00::kuku(undef, $MIN-1),	$ERROR, "2st arg only. MIN-1");
is(Vol00::kuku(undef, $MAX+1),	$ERROR, "2st arg only. MAX+1");

is(Vol00::kuku(0, 0), $ERROR, "0 x 0");
is(Vol00::kuku(0, 1), $ERROR, "0 x 1");
is(Vol00::kuku(0, 5), $ERROR, "0 x 5");
is(Vol00::kuku(0, 9), $ERROR, "0 x 9");

is(Vol00::kuku(0, 0), $ERROR, "0 x 0");
is(Vol00::kuku(1, 0), $ERROR, "1 x 0");
is(Vol00::kuku(5, 0), $ERROR, "5 x 0");
is(Vol00::kuku(9, 0), $ERROR, "9 x 0");

is(Vol00::kuku(10, 0), $ERROR, "10 x 0");
is(Vol00::kuku(10, 1), $ERROR, "10 x 1");
is(Vol00::kuku(10, 5), $ERROR, "10 x 5");
is(Vol00::kuku(10, 9), $ERROR, "10 x 9");

is(Vol00::kuku(0, 10), $ERROR, "0 x 10");
is(Vol00::kuku(1, 10), $ERROR, "1 x 10");
is(Vol00::kuku(5, 10), $ERROR, "5 x 10");
is(Vol00::kuku(9, 10), $ERROR, "9 x 10");

is(Vol00::kuku("a", 1), $ERROR, "alpha");
is(Vol00::kuku(1, "a"), $ERROR, "alpha");

is(Vol00::kuku(0.1, 1), $ERROR, "float");
is(Vol00::kuku(1, 0.1), $ERROR, "float");

# good
is(Vol00::kuku(1, 1),  1, "1 x 1");
is(Vol00::kuku(1, 5),  5, "1 x 5");
is(Vol00::kuku(1, 9),  9, "1 x 9");

is(Vol00::kuku(5, 1),  5, "5 x 1");
is(Vol00::kuku(5, 5), 25, "5 x 5");
is(Vol00::kuku(5, 9), 45, "5 x 9");

is(Vol00::kuku(9, 1),  9, "9 x 1");
is(Vol00::kuku(9, 5), 45, "9 x 5");
is(Vol00::kuku(9, 9), 81, "9 x 9");

done_testing();

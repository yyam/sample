#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use Digest::SHA1;
use POSIX;
use lib './t/lib';
use TestHarness;
 
BEGIN{ 
	use_ok('Vol01');
	#ok(TestHarness::checkHash($0));
	if (Vol01::isNatural() eq -999) {
		notImplement();
		done_testing();
		exit(-9);
	}
};

# default min, max
my $MIN = 0;
my $MAX = 0xFFFFFFFF - 1;
my $MEDIAN = ceil($MAX / 2);

#VALIDS
my @VALIDS = (
	[$MIN, 				undef,	 	undef],
	[$MAX,				undef, 		undef],
	[$MIN,				$MAX,		undef],
	[$MAX,				$MAX,		undef],
	[$MIN,				$MAX - 1,	undef],
	[$MAX - 1,			$MAX - 1,	undef],
	[$MIN,				$MEDIAN,	undef],
	[$MEDIAN,			$MEDIAN,	undef],
	[$MEDIAN,			$MAX,		$MEDIAN],
	[$MEDIAN,			undef,		$MEDIAN],
	[$MAX,				$MAX,		$MEDIAN],
	[$MAX,				$MAX,		$MAX - 1],
	[$MIN,				$MIN + 1,	$MIN],
	[0.0, 				undef,	 	undef],
);

for my $tc (@VALIDS) {
	is(Vol01::isNatural($tc->[0], $tc->[1], $tc->[2]), 1, 
		sprintf("valid values: value: %s, max: %s, min: %s", map{defined($_) ? $_ : "''"} @{$tc})
	);
}

#INVALID ARGS
my @INVALID_ARGS = (
	[$MIN,				0,			undef],
	[$MEDIAN,			$MAX + 1, 	undef],
	[$MEDIAN, 			undef, 		$MAX],
	[$MEDIAN, 			undef, 		$MAX],
	[$MEDIAN + 1,		$MEDIAN, 	$MEDIAN + 1],
	[$MEDIAN,			$MEDIAN, 	$MAX],
	[$MEDIAN, 			'A', 		undef],
	[$MEDIAN, 			undef, 		'A'],
);

for my $tc (@INVALID_ARGS) {
	is(Vol01::isNatural($tc->[0], $tc->[1], $tc->[2]), -1, 
		sprintf("invalid args: value: %s, max: %s, min: %s", map{defined($_) ? $_ : "''"} @{$tc})
	);
}

#INVALID VALUES
my @INVALID_VALUES = (
	[$MIN - 1,			undef,	 	undef],
	[$MAX + 1,			undef, 		undef],
	[$MAX - 2,			undef,	 	$MAX - 1],
	[$MAX + 1,			undef, 		$MAX - 1],
	[$MIN - 1,			$MAX,		undef],
	[$MAX + 1,			$MAX,		undef],
	[$MIN - 1,	 		$MAX - 1,	undef],
	[$MAX + 1,			$MAX - 1,	undef],
	[$MIN - 1,			$MEDIAN,	undef],
	[$MEDIAN + 1,		$MEDIAN,	undef],
	[$MEDIAN - 1,		$MAX,		$MEDIAN],
	[$MAX + 1,			$MAX,		$MEDIAN],
	[$MAX - 2,			$MAX,		$MAX - 1],
	[$MIN + 2,			$MIN + 1,	$MIN],
	[undef,				undef, 		undef],
	['A',				undef, 		undef],
	['',				undef, 		undef],
	[-0.1,				undef, 		undef],
	[0.1,				undef, 		undef],
	[$MAX + 0.1,		undef, 		undef],
	[$MAX - 0.1,		undef, 		undef],
);

for my $tc (@INVALID_VALUES) {
	is(Vol01::isNatural($tc->[0], $tc->[1], $tc->[2]), 0, 
		sprintf("invalid values: %s, %s, %s", map{defined($_) ? $_ : "''"} @{$tc})
	);
}

done_testing();

#!/usr/bin/perl
use strict;
use warnings;
use Test::More; 
use Digest::SHA1;
use lib './t/lib';
use TestHarness;
use Time::HiRes;

BEGIN{ 
	use_ok('Vol01');
	#ok(TestHarness::checkHash($0));
	if (Vol01::circleArea() eq -999) {
		notImplement();
		done_testing();
		exit(-9);
	}
};

my $PI = atan2(1,1) * 4;

my $DEFAULT_EXP = sprintf("%.8f", $PI * 10 ** 2);

is(Vol01::circleArea(), $DEFAULT_EXP, "default");

for my $r (1..100) {
	my $exp = sprintf("%.8f", $PI * $r ** 2);
	print "r = $r , exp = $exp \n";
	is(Vol01::circleArea($r), $exp, "r = $r")
}

done_testing();

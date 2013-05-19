#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use lib './t/lib';
use TestHarness;
use Time::HiRes;

BEGIN{ 
	use_ok('Vol01'); 
    #ok(TestHarness::checkHash($0));
	if (Vol01::sumTotal() eq -999) {
		notImplement();
		done_testing();
		exit(-9);
	}
};

my $MAX = 92683;
my $ODD = 13;
my $TIME_LIMIT = 20.0;

my $start = Time::HiRes::time();

for (my $i = 0; $i <= $MAX ; $i+=$ODD) {
	my $exp = ($i + 1) * $i / 2;
	is(Vol01::sumTotal($i), $exp, "test for $i");
}

my $elapsed = Time::HiRes::time() - $start;

ok($elapsed <= $TIME_LIMIT, "perfornce test: execute time " . $elapsed);

is(Vol01::sumTotal(),      5050, "test for no arg");
is(Vol01::sumTotal(undef), 5050, "test for undef");

is(Vol01::sumTotal(-1),    -1,    "test for -1");
is(Vol01::sumTotal($MAX + 1), -1, "test for " . ($MAX + 1));
is(Vol01::sumTotal(''),    -1, "test for ''");

done_testing();

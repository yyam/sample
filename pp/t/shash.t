#!/usr/bin/perl
use strict;
use warnings;
use Test::More; 
use Digest::SHA1;
use lib './t/lib';
use TestHarness;
use Time::HiRes;
use Data::Dumper;
use utf8;

BEGIN{ 
	use_ok('Vol02');
	#ok(TestHarness::checkHash($0));
	if (Vol02::shash() eq -999 || Vol02::shashCheck() eq -999) {
		notImplement();
		done_testing();
		exit(-9);
	}
};

my $b64s = join( "", ("a".."f", "0".."9"));
my $TRIES = 10;
my $SALTED_LENGTH = 42;

my @phs = ("secret", "helloworld", "this is my scret", " ", "!\"#$%%&'");
for my $ph (@phs) {
	for (0..$TRIES) {
		my $salted = Vol02::shash($ph);
		like(lc($salted), qr/^[${b64s}]{$SALTED_LENGTH}$/, "test $salted");
		is(Vol02::shashCheck($ph, $salted), 1, "test $salted");
	}
}

is(Vol02::shash(), 0, "no arg");
is(Vol02::shashCheck(), 0, "no arg");
is(Vol02::shashCheck("secret"), 0, "no 2nd arg");

done_testing();

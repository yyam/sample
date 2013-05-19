#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use Digest::SHA1;
use lib './t/lib';
use TestHarness;

BEGIN{ 
	use_ok('Vol01');
	#ok(TestHarness::checkHash($0));
	if (Vol01::isFloat() eq -999) {
		notImplement();
		done_testing();
		exit(-9);
	}
};

# no arg.
is(Vol01::isFloat(), 0, "undef");

my @VALID = qw/
	0
	123.456  
	123
	0.123
	.123
	123.0
	123.
	+123.456
	-.123
/;

for my $valid (@VALID) {
	is(Vol01::isFloat($valid), 1, "test for $valid");
}

my @INVALID = qw/
	12A3		
	123_		
	123+456	
	123-
	++123	
	123--
	1.2.3
	12..3
	123..	
	..123
	.	
	'123 445' 
/;

for my $invalid (@INVALID) {
	is(Vol01::isFloat($invalid), 0, "test for $invalid");
}

done_testing();

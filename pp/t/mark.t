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
	if (Vol02::mark() eq -999) {
		notImplement();
		done_testing();
		exit(-9);
	}
};

my $exp = +{
	'Suzuki Jiro'   => { 'Q005' => 7 },
	'Okada Keiko'   => { 'Q005' => 10 },
	'Aoki Masashi'  => { 'Q005' => 9 },
	'Yamada Yoshio' => { 'Q005' => 8 }
};

is_deeply(Vol02::mark(), $exp);

done_testing();

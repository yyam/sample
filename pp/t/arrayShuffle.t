#!/usr/bin/perl
use strict;
use warnings;
use Test::More; 
use Digest::SHA1;
use lib './t/lib';
use TestHarness;
use Time::HiRes;

BEGIN{ 
	use_ok('Vol02');
	#ok(TestHarness::checkHash($0));
	if (Vol02::arrayShuffle() eq -999) {
		notImplement();
		done_testing();
		exit(-9);
	}
};

is(Vol02::arrayShuffle(),    0, "no args");
is(Vol02::arrayShuffle(1),   0, "no array ref");
is(Vol02::arrayShuffle('a'), 0, "no array ref");
is(Vol02::arrayShuffle({"hash", "hash"}), 0, "no array ref");

my $EXAMPLE = [qw/apple banana kiwi grape orange pine cherry pear papaya lime/];
my $TRIES = 10000;
my $SAME_LIMIT = 2; # 10! = 3_628_800
my $ok_flg = 1;
my $same = 0;

for (1..$TRIES) {
	my $shuffled = Vol02::arrayShuffle($EXAMPLE);	

	#check size
	if ( scalar(@{$shuffled}) != scalar(@{$EXAMPLE})) {
		$ok_flg = 0;
		last;
	}

	#check difference
	if (_arrayDiff($shuffled, $EXAMPLE)) {
		$same++;
		if ($same >= $SAME_LIMIT) {
			$ok_flg = 0;
			last;
		}
	}
}

ok( $ok_flg, "accept shuffled");

done_testing();

sub _arrayDiff {
	my ($ar, $br) = @_;
	my @a = @{$ar};
	my @b = @{$br};

	if (scalar(@a) != scalar(@b)) {
		return 0;
	}

	for my $i (0..$#a) {
		if (!grep(/^$a[$i]$/, @b)) {
			return 0;
		}

		if ($a[$i] ne $b[$i]) {
			return 0;
		}
	}
	return 1;
}

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
	if (Vol02::full2half() eq -999) {
		notImplement();
		done_testing();
		exit(-9);
	}
};

my @PATTERN = (
	["Ｔｈｉｓ　ｉｓ　全角." , "This is 全角."],
	["ａ", "a"],
	["ａｂｃ", "abc"],
	["ＡＢＣ", "ABC"],
	["ｘｙｚ", "xyz"],
	["ＸＹＺ", "XYZ"],
	["０１２", "012"],
	["７８９", "789"],
	["ａｂｃＡＢＣｘｙｚＸＹＺ０１２７８９", "abcABCxyzXYZ012789"],
	["ａｂｃＡＢＣｘ-HALF-ｙｚＸＹＺ０１２７８９", "abcABCx-HALF-yzXYZ012789"]
);

for my $tc (@PATTERN) {
	is(Vol02::full2half($tc->[0]), $tc->[1]);
}

is(Vol02::full2half(), 0, "blank");


done_testing();

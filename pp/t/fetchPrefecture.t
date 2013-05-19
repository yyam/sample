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
	if (Vol02::fetchPrefecture() eq -999) {
		notImplement();
		done_testing();
		exit(-9);
	}
};

# Hokkaido
#14,"","01000","a","2010","2000","北海道",5506419,5627737,-121318,-2.1557155212,83456.87,70.2
is_deeply( Vol02::fetchPrefecture('01000'), 
	{ 	code => '01000',
		name => '北海道',
		population => ['5506419', '5627737'],
		area => '83456.87'
	}, "Hokkaido - 01000" );

# Okinawa
#4443,"","47000","a","2010","2000","沖縄県",1392818,1361594,31224,2.2931945940,2276.15,611.9
is_deeply( Vol02::fetchPrefecture('47000'),
    {   code => '47000',
        name => '沖縄県',
        population => ['1392818', '1361594'],
        area => '2276.15'
    }, "Okinawa - 47000" );

#no record
is(Vol02::fetchPrefecture('X'), 0, "no record");

#no arg
is(Vol02::fetchPrefecture(), 0, "no args");

#no file
is(Vol02::fetchPrefecture("01000", "nofile"), -9, "01000, nofile");

done_testing();

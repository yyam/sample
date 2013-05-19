#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use Digest::SHA1;
use lib './t/lib';
use TestHarness;
use Time::HiRes;

my $MAX = 4294967294;
 
BEGIN{ 
	use_ok('Vol01');
	#ok(TestHarness::checkHash($0));
	if (Vol01::isPrime() eq -999) {
		notImplement();
		done_testing();
		exit(-9);
	}
};

my $MAX_PRIME = 4294967291;
my $TIME_LIMIT = 5;
my $start = Time::HiRes::time();
is(Vol01::isPrime($MAX_PRIME), 1, "max prime for performance.");
my $elapse = Time::HiRes::time() - $start;
my $result = ok($elapse <= $TIME_LIMIT, "peroramce test. spend time is $elapse sec.");

if ($elapse >= $TIME_LIMIT) {
	BAIL_OUT("time over. $elapse.");
}

# http://www.prime-numbers.org
my @PRIMES = qw/
	2      3      5      7      
	11      13      17      19      
	23      29      31      37      
	41      43      47      53      
	59      61      67      71      
	73      79      83      89      
	97      101      103      107      
	109      113      127      131      
	137      139      149      151      
	157      163      167      173      
	179      181      191      193      
	197      199      211      223      
	227      229      233      239      
	241      251      257      263      
	269      271      277      281      
	283      293      307      311      
	313      317      331      337      
	347      349      353      359      
	367      373      379      383      
	389      397      401      409      
	419      421      431      433      
	439      443      449      457      
	461      463      467      479      
	487      491      499      503      
	509      521      523      541      
	547      557      563      569      
	571      577      587      593      
	599      601      607      613      
	617      619      631      641      
	643      647      653      659      
	661      673      677      683      
	691      701      709      719      
	727      733      739      743      
	751      757      761      769      
	773      787      797      809      
	811      821      823      827      
	829      839      853      857      
	859      863      877      881      
	883      887      907      911      
	919      929      937      941      
	947      953      967      971      
	977      983      991      997
	4294966177      4294966187      4294966217      4294966231      
	4294966237      4294966243      4294966297      4294966337      
	4294966367      4294966373      4294966427      4294966441      
	4294966447      4294966477      4294966553      4294966583      
	4294966591      4294966619      4294966639      4294966651      
	4294966657      4294966661      4294966667      4294966769      
	4294966813      4294966829      4294966877      4294966909      
	4294966927      4294966943      4294966981      4294966997      
	4294967029      4294967087      4294967111      4294967143      
	4294967161      4294967189      4294967197      4294967231      
	4294967279      4294967291
/;

my @NONPRIMES = qw/
	0 1 4 6 8 9 10 4294967292 4294967293 4294967294
/;

for my $p (@PRIMES) {
	is(Vol01::isPrime($p),   1, "test for prime $p");
}

for my $np (@NONPRIMES) {
	is(Vol01::isPrime($np), 0, "test for compsite $np");
}



is(Vol01::isPrime(undef), -1, "test for undef");
is(Vol01::isPrime(''),    -1, "test for ''");
is(Vol01::isPrime(),      -1, "test for no arg");
is(Vol01::isPrime('A'),   -1, "test for A");
is(Vol01::isPrime($MAX + 1),   -1, "test for " . ($MAX + 1));

done_testing();

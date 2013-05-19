#!/usr/bin/perl
use strict;
use warnings;
use Test::More; 
use Digest::SHA1;
use lib './t/lib';
use TestHarness;
use Time::HiRes;
use Data::Dumper;

BEGIN{ 
	use_ok('Vol02');
	#ok(TestHarness::checkHash($0));
	if (Vol02::pattern() eq -999) {
		notImplement();
		done_testing();
		exit(-9);
	}
};

is(Vol02::pattern(), 0, "undef");


my @HELLOWORLD = qw/
helloworld helloworlD helloworLd helloworLD hellowoRld
hellowoRlD hellowoRLd hellowoRLD hellowOrld hellowOrlD 
hellowOrLd hellowOrLD hellowORld hellowORlD hellowORLd 
hellowORLD helloWorld helloWorlD helloWorLd helloWorLD 
helloWoRld helloWoRlD helloWoRLd helloWoRLD helloWOrld 
helloWOrlD helloWOrLd helloWOrLD helloWORld helloWORlD 
helloWORLd helloWORLD hellOworld hellOworlD hellOworLd 
hellOworLD hellOwoRld hellOwoRlD hellOwoRLd hellOwoRLD 
hellOwOrld hellOwOrlD hellOwOrLd hellOwOrLD hellOwORld 
hellOwORlD hellOwORLd hellOwORLD hellOWorld hellOWorlD 
hellOWorLd hellOWorLD hellOWoRld hellOWoRlD hellOWoRLd 
hellOWoRLD hellOWOrld hellOWOrlD hellOWOrLd hellOWOrLD 
hellOWORld hellOWORlD hellOWORLd hellOWORLD helLoworld 
helLoworlD helLoworLd helLoworLD helLowoRld helLowoRlD 
helLowoRLd helLowoRLD helLowOrld helLowOrlD helLowOrLd 
helLowOrLD helLowORld helLowORlD helLowORLd helLowORLD 
helLoWorld helLoWorlD helLoWorLd helLoWorLD helLoWoRld 
helLoWoRlD helLoWoRLd helLoWoRLD helLoWOrld helLoWOrlD 
helLoWOrLd helLoWOrLD helLoWORld helLoWORlD helLoWORLd 
helLoWORLD helLOworld helLOworlD helLOworLd helLOworLD 
helLOwoRld helLOwoRlD helLOwoRLd helLOwoRLD helLOwOrld 
helLOwOrlD helLOwOrLd helLOwOrLD helLOwORld helLOwORlD 
helLOwORLd helLOwORLD helLOWorld helLOWorlD helLOWorLd 
helLOWorLD helLOWoRld helLOWoRlD helLOWoRLd helLOWoRLD 
helLOWOrld helLOWOrlD helLOWOrLd helLOWOrLD helLOWORld 
helLOWORlD helLOWORLd helLOWORLD heLloworld heLloworlD 
heLloworLd heLloworLD heLlowoRld heLlowoRlD heLlowoRLd 
heLlowoRLD heLlowOrld heLlowOrlD heLlowOrLd heLlowOrLD 
heLlowORld heLlowORlD heLlowORLd heLlowORLD heLloWorld 
heLloWorlD heLloWorLd heLloWorLD heLloWoRld heLloWoRlD 
heLloWoRLd heLloWoRLD heLloWOrld heLloWOrlD heLloWOrLd 
heLloWOrLD heLloWORld heLloWORlD heLloWORLd heLloWORLD 
heLlOworld heLlOworlD heLlOworLd heLlOworLD heLlOwoRld 
heLlOwoRlD heLlOwoRLd heLlOwoRLD heLlOwOrld heLlOwOrlD 
heLlOwOrLd heLlOwOrLD heLlOwORld heLlOwORlD heLlOwORLd 
heLlOwORLD heLlOWorld heLlOWorlD heLlOWorLd heLlOWorLD 
heLlOWoRld heLlOWoRlD heLlOWoRLd heLlOWoRLD heLlOWOrld 
heLlOWOrlD heLlOWOrLd heLlOWOrLD heLlOWORld heLlOWORlD 
heLlOWORLd heLlOWORLD heLLoworld heLLoworlD heLLoworLd 
heLLoworLD heLLowoRld heLLowoRlD heLLowoRLd heLLowoRLD 
heLLowOrld heLLowOrlD heLLowOrLd heLLowOrLD heLLowORld 
heLLowORlD heLLowORLd heLLowORLD heLLoWorld heLLoWorlD 
heLLoWorLd heLLoWorLD heLLoWoRld heLLoWoRlD heLLoWoRLd 
heLLoWoRLD heLLoWOrld heLLoWOrlD heLLoWOrLd heLLoWOrLD 
heLLoWORld heLLoWORlD heLLoWORLd heLLoWORLD heLLOworld 
heLLOworlD heLLOworLd heLLOworLD heLLOwoRld heLLOwoRlD 
heLLOwoRLd heLLOwoRLD heLLOwOrld heLLOwOrlD heLLOwOrLd 
heLLOwOrLD heLLOwORld heLLOwORlD heLLOwORLd heLLOwORLD 
heLLOWorld heLLOWorlD heLLOWorLd heLLOWorLD heLLOWoRld 
heLLOWoRlD heLLOWoRLd heLLOWoRLD heLLOWOrld heLLOWOrlD 
heLLOWOrLd heLLOWOrLD heLLOWORld heLLOWORlD heLLOWORLd 
heLLOWORLD hElloworld hElloworlD hElloworLd hElloworLD 
hEllowoRld hEllowoRlD hEllowoRLd hEllowoRLD hEllowOrld 
hEllowOrlD hEllowOrLd hEllowOrLD hEllowORld hEllowORlD 
hEllowORLd hEllowORLD hElloWorld hElloWorlD hElloWorLd 
hElloWorLD hElloWoRld hElloWoRlD hElloWoRLd hElloWoRLD 
hElloWOrld hElloWOrlD hElloWOrLd hElloWOrLD hElloWORld 
hElloWORlD hElloWORLd hElloWORLD hEllOworld hEllOworlD 
hEllOworLd hEllOworLD hEllOwoRld hEllOwoRlD hEllOwoRLd 
hEllOwoRLD hEllOwOrld hEllOwOrlD hEllOwOrLd hEllOwOrLD 
hEllOwORld hEllOwORlD hEllOwORLd hEllOwORLD hEllOWorld 
hEllOWorlD hEllOWorLd hEllOWorLD hEllOWoRld hEllOWoRlD 
hEllOWoRLd hEllOWoRLD hEllOWOrld hEllOWOrlD hEllOWOrLd 
hEllOWOrLD hEllOWORld hEllOWORlD hEllOWORLd hEllOWORLD 
hElLoworld hElLoworlD hElLoworLd hElLoworLD hElLowoRld 
hElLowoRlD hElLowoRLd hElLowoRLD hElLowOrld hElLowOrlD 
hElLowOrLd hElLowOrLD hElLowORld hElLowORlD hElLowORLd 
hElLowORLD hElLoWorld hElLoWorlD hElLoWorLd hElLoWorLD 
hElLoWoRld hElLoWoRlD hElLoWoRLd hElLoWoRLD hElLoWOrld 
hElLoWOrlD hElLoWOrLd hElLoWOrLD hElLoWORld hElLoWORlD 
hElLoWORLd hElLoWORLD hElLOworld hElLOworlD hElLOworLd 
hElLOworLD hElLOwoRld hElLOwoRlD hElLOwoRLd hElLOwoRLD 
hElLOwOrld hElLOwOrlD hElLOwOrLd hElLOwOrLD hElLOwORld 
hElLOwORlD hElLOwORLd hElLOwORLD hElLOWorld hElLOWorlD 
hElLOWorLd hElLOWorLD hElLOWoRld hElLOWoRlD hElLOWoRLd 
hElLOWoRLD hElLOWOrld hElLOWOrlD hElLOWOrLd hElLOWOrLD 
hElLOWORld hElLOWORlD hElLOWORLd hElLOWORLD hELloworld 
hELloworlD hELloworLd hELloworLD hELlowoRld hELlowoRlD 
hELlowoRLd hELlowoRLD hELlowOrld hELlowOrlD hELlowOrLd 
hELlowOrLD hELlowORld hELlowORlD hELlowORLd hELlowORLD 
hELloWorld hELloWorlD hELloWorLd hELloWorLD hELloWoRld 
hELloWoRlD hELloWoRLd hELloWoRLD hELloWOrld hELloWOrlD 
hELloWOrLd hELloWOrLD hELloWORld hELloWORlD hELloWORLd 
hELloWORLD hELlOworld hELlOworlD hELlOworLd hELlOworLD 
hELlOwoRld hELlOwoRlD hELlOwoRLd hELlOwoRLD hELlOwOrld 
hELlOwOrlD hELlOwOrLd hELlOwOrLD hELlOwORld hELlOwORlD 
hELlOwORLd hELlOwORLD hELlOWorld hELlOWorlD hELlOWorLd 
hELlOWorLD hELlOWoRld hELlOWoRlD hELlOWoRLd hELlOWoRLD 
hELlOWOrld hELlOWOrlD hELlOWOrLd hELlOWOrLD hELlOWORld 
hELlOWORlD hELlOWORLd hELlOWORLD hELLoworld hELLoworlD 
hELLoworLd hELLoworLD hELLowoRld hELLowoRlD hELLowoRLd 
hELLowoRLD hELLowOrld hELLowOrlD hELLowOrLd hELLowOrLD 
hELLowORld hELLowORlD hELLowORLd hELLowORLD hELLoWorld 
hELLoWorlD hELLoWorLd hELLoWorLD hELLoWoRld hELLoWoRlD 
hELLoWoRLd hELLoWoRLD hELLoWOrld hELLoWOrlD hELLoWOrLd 
hELLoWOrLD hELLoWORld hELLoWORlD hELLoWORLd hELLoWORLD 
hELLOworld hELLOworlD hELLOworLd hELLOworLD hELLOwoRld 
hELLOwoRlD hELLOwoRLd hELLOwoRLD hELLOwOrld hELLOwOrlD 
hELLOwOrLd hELLOwOrLD hELLOwORld hELLOwORlD hELLOwORLd 
hELLOwORLD hELLOWorld hELLOWorlD hELLOWorLd hELLOWorLD 
hELLOWoRld hELLOWoRlD hELLOWoRLd hELLOWoRLD hELLOWOrld 
hELLOWOrlD hELLOWOrLd hELLOWOrLD hELLOWORld hELLOWORlD 
hELLOWORLd hELLOWORLD Helloworld HelloworlD HelloworLd 
HelloworLD HellowoRld HellowoRlD HellowoRLd HellowoRLD 
HellowOrld HellowOrlD HellowOrLd HellowOrLD HellowORld 
HellowORlD HellowORLd HellowORLD HelloWorld HelloWorlD 
HelloWorLd HelloWorLD HelloWoRld HelloWoRlD HelloWoRLd 
HelloWoRLD HelloWOrld HelloWOrlD HelloWOrLd HelloWOrLD 
HelloWORld HelloWORlD HelloWORLd HelloWORLD HellOworld 
HellOworlD HellOworLd HellOworLD HellOwoRld HellOwoRlD 
HellOwoRLd HellOwoRLD HellOwOrld HellOwOrlD HellOwOrLd 
HellOwOrLD HellOwORld HellOwORlD HellOwORLd HellOwORLD 
HellOWorld HellOWorlD HellOWorLd HellOWorLD HellOWoRld 
HellOWoRlD HellOWoRLd HellOWoRLD HellOWOrld HellOWOrlD 
HellOWOrLd HellOWOrLD HellOWORld HellOWORlD HellOWORLd 
HellOWORLD HelLoworld HelLoworlD HelLoworLd HelLoworLD 
HelLowoRld HelLowoRlD HelLowoRLd HelLowoRLD HelLowOrld 
HelLowOrlD HelLowOrLd HelLowOrLD HelLowORld HelLowORlD 
HelLowORLd HelLowORLD HelLoWorld HelLoWorlD HelLoWorLd 
HelLoWorLD HelLoWoRld HelLoWoRlD HelLoWoRLd HelLoWoRLD 
HelLoWOrld HelLoWOrlD HelLoWOrLd HelLoWOrLD HelLoWORld 
HelLoWORlD HelLoWORLd HelLoWORLD HelLOworld HelLOworlD 
HelLOworLd HelLOworLD HelLOwoRld HelLOwoRlD HelLOwoRLd 
HelLOwoRLD HelLOwOrld HelLOwOrlD HelLOwOrLd HelLOwOrLD 
HelLOwORld HelLOwORlD HelLOwORLd HelLOwORLD HelLOWorld 
HelLOWorlD HelLOWorLd HelLOWorLD HelLOWoRld HelLOWoRlD 
HelLOWoRLd HelLOWoRLD HelLOWOrld HelLOWOrlD HelLOWOrLd 
HelLOWOrLD HelLOWORld HelLOWORlD HelLOWORLd HelLOWORLD 
HeLloworld HeLloworlD HeLloworLd HeLloworLD HeLlowoRld 
HeLlowoRlD HeLlowoRLd HeLlowoRLD HeLlowOrld HeLlowOrlD 
HeLlowOrLd HeLlowOrLD HeLlowORld HeLlowORlD HeLlowORLd 
HeLlowORLD HeLloWorld HeLloWorlD HeLloWorLd HeLloWorLD 
HeLloWoRld HeLloWoRlD HeLloWoRLd HeLloWoRLD HeLloWOrld 
HeLloWOrlD HeLloWOrLd HeLloWOrLD HeLloWORld HeLloWORlD 
HeLloWORLd HeLloWORLD HeLlOworld HeLlOworlD HeLlOworLd 
HeLlOworLD HeLlOwoRld HeLlOwoRlD HeLlOwoRLd HeLlOwoRLD 
HeLlOwOrld HeLlOwOrlD HeLlOwOrLd HeLlOwOrLD HeLlOwORld 
HeLlOwORlD HeLlOwORLd HeLlOwORLD HeLlOWorld HeLlOWorlD 
HeLlOWorLd HeLlOWorLD HeLlOWoRld HeLlOWoRlD HeLlOWoRLd 
HeLlOWoRLD HeLlOWOrld HeLlOWOrlD HeLlOWOrLd HeLlOWOrLD 
HeLlOWORld HeLlOWORlD HeLlOWORLd HeLlOWORLD HeLLoworld 
HeLLoworlD HeLLoworLd HeLLoworLD HeLLowoRld HeLLowoRlD 
HeLLowoRLd HeLLowoRLD HeLLowOrld HeLLowOrlD HeLLowOrLd 
HeLLowOrLD HeLLowORld HeLLowORlD HeLLowORLd HeLLowORLD 
HeLLoWorld HeLLoWorlD HeLLoWorLd HeLLoWorLD HeLLoWoRld 
HeLLoWoRlD HeLLoWoRLd HeLLoWoRLD HeLLoWOrld HeLLoWOrlD 
HeLLoWOrLd HeLLoWOrLD HeLLoWORld HeLLoWORlD HeLLoWORLd 
HeLLoWORLD HeLLOworld HeLLOworlD HeLLOworLd HeLLOworLD 
HeLLOwoRld HeLLOwoRlD HeLLOwoRLd HeLLOwoRLD HeLLOwOrld 
HeLLOwOrlD HeLLOwOrLd HeLLOwOrLD HeLLOwORld HeLLOwORlD 
HeLLOwORLd HeLLOwORLD HeLLOWorld HeLLOWorlD HeLLOWorLd 
HeLLOWorLD HeLLOWoRld HeLLOWoRlD HeLLOWoRLd HeLLOWoRLD 
HeLLOWOrld HeLLOWOrlD HeLLOWOrLd HeLLOWOrLD HeLLOWORld 
HeLLOWORlD HeLLOWORLd HeLLOWORLD HElloworld HElloworlD 
HElloworLd HElloworLD HEllowoRld HEllowoRlD HEllowoRLd 
HEllowoRLD HEllowOrld HEllowOrlD HEllowOrLd HEllowOrLD 
HEllowORld HEllowORlD HEllowORLd HEllowORLD HElloWorld 
HElloWorlD HElloWorLd HElloWorLD HElloWoRld HElloWoRlD 
HElloWoRLd HElloWoRLD HElloWOrld HElloWOrlD HElloWOrLd 
HElloWOrLD HElloWORld HElloWORlD HElloWORLd HElloWORLD 
HEllOworld HEllOworlD HEllOworLd HEllOworLD HEllOwoRld 
HEllOwoRlD HEllOwoRLd HEllOwoRLD HEllOwOrld HEllOwOrlD 
HEllOwOrLd HEllOwOrLD HEllOwORld HEllOwORlD HEllOwORLd 
HEllOwORLD HEllOWorld HEllOWorlD HEllOWorLd HEllOWorLD 
HEllOWoRld HEllOWoRlD HEllOWoRLd HEllOWoRLD HEllOWOrld 
HEllOWOrlD HEllOWOrLd HEllOWOrLD HEllOWORld HEllOWORlD 
HEllOWORLd HEllOWORLD HElLoworld HElLoworlD HElLoworLd 
HElLoworLD HElLowoRld HElLowoRlD HElLowoRLd HElLowoRLD 
HElLowOrld HElLowOrlD HElLowOrLd HElLowOrLD HElLowORld 
HElLowORlD HElLowORLd HElLowORLD HElLoWorld HElLoWorlD 
HElLoWorLd HElLoWorLD HElLoWoRld HElLoWoRlD HElLoWoRLd 
HElLoWoRLD HElLoWOrld HElLoWOrlD HElLoWOrLd HElLoWOrLD 
HElLoWORld HElLoWORlD HElLoWORLd HElLoWORLD HElLOworld 
HElLOworlD HElLOworLd HElLOworLD HElLOwoRld HElLOwoRlD 
HElLOwoRLd HElLOwoRLD HElLOwOrld HElLOwOrlD HElLOwOrLd 
HElLOwOrLD HElLOwORld HElLOwORlD HElLOwORLd HElLOwORLD 
HElLOWorld HElLOWorlD HElLOWorLd HElLOWorLD HElLOWoRld 
HElLOWoRlD HElLOWoRLd HElLOWoRLD HElLOWOrld HElLOWOrlD 
HElLOWOrLd HElLOWOrLD HElLOWORld HElLOWORlD HElLOWORLd 
HElLOWORLD HELloworld HELloworlD HELloworLd HELloworLD 
HELlowoRld HELlowoRlD HELlowoRLd HELlowoRLD HELlowOrld 
HELlowOrlD HELlowOrLd HELlowOrLD HELlowORld HELlowORlD 
HELlowORLd HELlowORLD HELloWorld HELloWorlD HELloWorLd 
HELloWorLD HELloWoRld HELloWoRlD HELloWoRLd HELloWoRLD 
HELloWOrld HELloWOrlD HELloWOrLd HELloWOrLD HELloWORld 
HELloWORlD HELloWORLd HELloWORLD HELlOworld HELlOworlD 
HELlOworLd HELlOworLD HELlOwoRld HELlOwoRlD HELlOwoRLd 
HELlOwoRLD HELlOwOrld HELlOwOrlD HELlOwOrLd HELlOwOrLD 
HELlOwORld HELlOwORlD HELlOwORLd HELlOwORLD HELlOWorld 
HELlOWorlD HELlOWorLd HELlOWorLD HELlOWoRld HELlOWoRlD 
HELlOWoRLd HELlOWoRLD HELlOWOrld HELlOWOrlD HELlOWOrLd 
HELlOWOrLD HELlOWORld HELlOWORlD HELlOWORLd HELlOWORLD 
HELLoworld HELLoworlD HELLoworLd HELLoworLD HELLowoRld 
HELLowoRlD HELLowoRLd HELLowoRLD HELLowOrld HELLowOrlD 
HELLowOrLd HELLowOrLD HELLowORld HELLowORlD HELLowORLd 
HELLowORLD HELLoWorld HELLoWorlD HELLoWorLd HELLoWorLD 
HELLoWoRld HELLoWoRlD HELLoWoRLd HELLoWoRLD HELLoWOrld 
HELLoWOrlD HELLoWOrLd HELLoWOrLD HELLoWORld HELLoWORlD 
HELLoWORLd HELLoWORLD HELLOworld HELLOworlD HELLOworLd 
HELLOworLD HELLOwoRld HELLOwoRlD HELLOwoRLd HELLOwoRLD 
HELLOwOrld HELLOwOrlD HELLOwOrLd HELLOwOrLD HELLOwORld 
HELLOwORlD HELLOwORLd HELLOwORLD HELLOWorld HELLOWorlD 
HELLOWorLd HELLOWorLD HELLOWoRld HELLOWoRlD HELLOWoRLd 
HELLOWoRLD HELLOWOrld HELLOWOrlD HELLOWOrLd HELLOWOrLD 
HELLOWORld HELLOWORlD HELLOWORLd HELLOWORLD
/;

@HELLOWORLD = sort(@HELLOWORLD);

is_deeply(Vol02::pattern("HelloWorld"), \@HELLOWORLD, "HelloWrold");

done_testing();

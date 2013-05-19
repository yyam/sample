package Vol02;
use strict;
use warnings;
use Digest::SHA1;
use utf8;
use Conf::Questions;
use Conf::Students;
use Data::Dumper;

# Q201
sub full2half {
	my $s = shift || return 0;
	$s =~ tr/ａ-ｚＡ-Ｚ０-９　/a-zA-Z0-9 /;
	return $s;
}

# Q202
sub pattern {
	my $str = shift;

	if (!defined($str)) {
		return 0;
	}
	my $len = 2 ** length($str);
	my @strPattern;
	for my $d (0..$len - 1) {
		my $pat = sprintf("%0" . length($str) . "b", $d);
		my $cStr;
		for my $n (0..length($pat)) {
			my $c = substr($str, $n, 1);	
			if ($c !~ /^[a-zA-Z]$/) {
				$cStr .= $c;
				next;
			}
			$cStr .= substr($pat, $n, 1) ? uc($c) : lc($c);
		}
		push(@strPattern, $cStr);
	}
	@strPattern = sort(@strPattern);
	return \@strPattern;
}


# Q203
sub arrayShuffle {
	my $aref = shift;
	
	if (!defined($aref) || ref($aref) ne 'ARRAY') {
		return 0;
	}

	my @array = @{$aref};
	my @tmp;
	for (0..$#array) {
		my $r = int(rand(scalar(@array)));
		my $f = splice(@array, $r, 1);
		push(@tmp, $f);
	}

	return \@tmp;
}

# Q204
sub shash {
	my $word = shift;
	
	if (!defined($word)) {
		return 0;
	}

	my $SALT_LENGTH = 2; 
	my @SALT_SEED = ('a'..'f','0'..'9');

	my $salt;
	for (1..$SALT_LENGTH) {
		my $r = int(rand(scalar(@SALT_SEED)));
		$salt .= $SALT_SEED[$r];
	}

	return  $salt . Digest::SHA1::sha1_hex($salt . $word);
}

sub shashCheck {
	my ($word, $shash) = @_;
	my $SALT_LENGTH = 2;

	if (!defined($word) || !defined($shash)) {
		return 0;
	}

	my $salt = substr($shash, 0, $SALT_LENGTH);	
	my $hash = Digest::SHA1::sha1_hex($salt . $word);

	if (substr($shash, $SALT_LENGTH) eq $hash) {
		return 1;
	}

	return 0;
}

# Q205
sub fetchPrefecture {
	my ($c, $file) = @_;
	my $DEFAULT_FILE = "data/japan-2011-population.csv";

	if (!defined($c)) {
		return 0;
	}

	if (!defined($file)) {
		$file = $DEFAULT_FILE;
	}

	open(P, "<" . $file) || return -9;
	while (<P>) {
		my $line = $_;
		chomp($line);
		$line =~ tr/"//d;
		my ($ln, $code, $year, $name, $p2010, $p2005, $area) 
			= (split(",", $line))[0,2,4,6,7,8,11];

		if (!defined($year) || $year ne '2010') {
			next;
		}

		if ($c eq $code) {
			close(P);
			return +{
				code => $code,
				name => $name,
				population => [$p2010, $p2005],
				area => $area
			};
		}
	}
	close(P);
	return 0;
}

# Q206
sub mark {
	my $qno = 'Q005';

	my $questions = $Conf::Questions::QUESTIONS;
	my $students = $Conf::Students::STUDENTS;
	
	my @corrects;
	for my $q ($questions->{$qno}->{questions}) {
		for my $s (@$q) {
			push(@corrects, $s->[0] * $s->[1]);
		}
	}

	my $marks = +{};

	for my $name (keys(%$students)) {
		my @answers = @{$students->{$name}{$qno}};
		my $mark= 0;
		for (my $no = 0; $no < scalar(@corrects); $no++) {
			if ($corrects[$no] == $answers[$no]) {
				$mark++;
			}
		}
		$marks->{$name} = +{ $qno => $mark};
	}
	return $marks;
}

1;

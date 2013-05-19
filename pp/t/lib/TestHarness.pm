package TestHarness;
use strict qw/vars refs/;
use warnings;
use base Exporter;
our @EXPORT = qw/notImplement/;

use Digest::SHA1;

my $MANIFEST = "./t/lib/sha1.txt";

sub notImplement {
	print STDERR "not yet implement.\n";
	return -999;
}

sub checkHash {
	my $file = shift;
	open(T, "< $file") || return -1;
	my $sha1 = new Digest::SHA1();
	$sha1->addfile(*T);
	close(T);
	my $hash = $sha1->hexdigest();

	open(M, "< $MANIFEST"); 
	while(<M>) {
		my $line = $_;
		chomp($line);
		if ($line =~ /$file/) {
			my $h = (split(/=\s*/, $line))[1];
			print "HASH..." , $h, "\n";
			if ($h eq $hash) {
				close(M);
				return 1;
			}
		}
	}
	close(M);
	return 0;
}

1;

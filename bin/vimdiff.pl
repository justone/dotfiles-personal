#!/usr/bin/perl

# $Id: vimdiff.pl 322 2010-03-21 03:20:29Z jkline $
# $URL: http://svn.jonfram.net/home/trunk/bin/vimdiff.pl $

use strict;
use warnings;

my $diff_prog = "/usr/bin/vimdiff";
my $temp_file_re = qr{
	\A
	/tmp/          # something in the temp directory
	(?:
		svndiff    # svn 1.5.1
	|
		tempfile   # svn 1.6.4
	)
	(?: [.] \d+ )? # this may not be the first one created
	[.]tmp
	\z
}xsm;

print STDERR join( ' ', @ARGV), "\n";

my $file1 = $ARGV[5];
my $file2 = $ARGV[6];

# Some versions of subversion copy the modified file into tmp, thereby losing
# any modifications you make in vimd will diffing.
# Files get copied to tmp if they have svn:keywords.
# http://stackoverflow.com/questions/396176/why-does-svn-diff-sometimes-copy-working-files-to-a-temp-file
# newly created files will have both sides as a tmp file
if ( $file1 =~ m{$temp_file_re} ) {
	$file2 = $ARGV[2];
	$file2 =~ s{ \t [(] .* \z }{}xsm;
}
elsif ( $file2 =~ m{$temp_file_re} ) {
    $file2 = $file1;
    $file2 =~ s{ [.]svn/text-base/   }{}xsm;
    $file2 =~ s{ [.]svn-base       \z}{}xsm;
}

my @cmd = ( "$diff_prog", "$file2", "$file1" );
print STDERR join( ' ', @cmd ), "\n";
system( @cmd );

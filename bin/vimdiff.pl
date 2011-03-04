#!/usr/bin/perl

# $Id: vimdiff.pl 322 2010-03-21 03:20:29Z jkline $
# $URL: http://svn.jonfram.net/home/trunk/bin/vimdiff.pl $

use strict;
use warnings;

my $diff_prog    = "/usr/bin/vimdiff";
my $temp_file_re = qr{
	/-?Tmp-?/          # something in the temp directory
	(?:
		svndiff    # svn 1.5.1
	|
		tempfile   # svn 1.6.4
	)
	(?: [.] \d+ )? # this may not be the first one created
	[.]tmp
	\z
}xsmi;

print STDERR join( ' ', @ARGV ), "\n";

# the left or previous file
my $previous_file = $ARGV[5];

# the right or new file
my $new_file = $ARGV[6];

# Some versions of subversion copy the modified file into tmp, thereby losing
# any modifications you make in vimd will diffing.
# Files get copied to tmp if they have svn:keywords.
# http://stackoverflow.com/questions/396176/why-does-svn-diff-sometimes-copy-working-files-to-a-temp-file
# newly created files will have both sides as a tmp file
if ( $previous_file =~ m{$temp_file_re} ) {
    $new_file = $ARGV[2];
    $new_file =~ s{ \t [(] .* \z }{}xsm;
}
elsif ( $new_file =~ m{$temp_file_re} ) {
    $new_file = $previous_file;
    $new_file =~ s{ [.]svn/text-base/   }{}xsm;
    $new_file =~ s{ [.]svn-base       \z}{}xsm;
}

# get the description of the left/previous buffer and replace tab with space
my $previous_file_desc = $ARGV[2];
$previous_file_desc =~ s/\t/ /g;

# same for the right/new buffer description
my $new_file_desc = $ARGV[4];
$new_file_desc =~ s/\t/ /g;

# These commands make it so the names of the buffers in vimdiff make sense
# first, we set the name we want in a buffer variable (b:name)
# next, we update the statusline for the buffer (setlocal only modifies for
#   current buffer) to be the same as the default status line with the exception
#   that the file name is replaced by our description.
# then, 'wincmd w' switches to the next (right) buffer, and we do the above for the other side.
#
# for reference, the default status line is: "%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P"
# type ":help statusline" in vim to see what that means
# see also: https://wincent.com/wiki/Set_the_Vim_statusline

my @VIM_COMMANDS = (
    '-c', "let b:name=\"$previous_file_desc\"",
    '-c', "setlocal statusline=%<%{b:name}\\ %h%m%r%=%-14.(%l,%c%V%)\\ %P",
    '-c', "wincmd w",
    '-c', "let b:name=\"$new_file_desc\"",
    '-c', "setlocal statusline=%<%{b:name}\\ %h%m%r%=%-14.(%l,%c%V%)\\ %P",
);

my @cmd = ( "$diff_prog", @VIM_COMMANDS, "$previous_file", "$new_file" );
print STDERR join( ' ', @cmd ), "\n";
system(@cmd);

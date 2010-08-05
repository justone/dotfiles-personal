#!/usr/bin/perl -w

my $diff_prog = "/usr/bin/vimdiff";

my $file1 = $ARGV[5];
my $file2 = $ARGV[6];

# some versions of subversion copy the modified file into tmp, thereby losing any modifications
if ( ( $file2 =~ /svndiff/ || $file2 =~ /tempfile/ ) && $file1 !~ /tempfile/ )
{
    $file2 = $file1;
    $file2 =~ s/.svn\/text-base\///;
    $file2 =~ s/.svn-base$//;
}

system( "$diff_prog", "$file1", "$file2" );


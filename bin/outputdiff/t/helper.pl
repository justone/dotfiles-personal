#!/usr/bin/perl

use strict;
use warnings;
use FindBin qw($Bin);
use File::Path qw(mkpath);
use Test::More;

BEGIN {

    package OD;
    require "outputdiff";
    die $@ if $@;
}

ok defined &OD::run_outputdiff, 'OD::run_outputdiff is defined';

sub run_outputdiff {
    my ($args) = @_;

    my $basedir = "$Bin/diffs";
    mkpath($basedir);

    my $config = { basedir => $basedir };
    trap {
        OD::run_outputdiff( $args, $config );
    };
}

1;

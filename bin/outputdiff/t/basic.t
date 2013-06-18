#!perl

use Test::More;
use Test::Trap qw/ :output(systemsafe) /;
use strict;

use FindBin qw($Bin);
require "$Bin/helper.pl";

subtest 'first' => sub {

    run_outputdiff([qw(--clean)]);

    {
        open my $stdin, '<', \"1\n2\n3\n";
        local *STDIN = $stdin;
        run_outputdiff([qw(-n)]);
    }

    {
        open my $stdin, '<', \"1\n4\n3\n";
        local *STDIN = $stdin;
        run_outputdiff([qw(-v -c)]);
    }

    like($trap->stdout, qr/-2/msi, '2 is gone');
    like($trap->stdout, qr/\+4/msi, '4 is now there');

    run_outputdiff([qw(--last)]);
    like($trap->stdout, qr/-2/msi, '2 is gone');
    like($trap->stdout, qr/\+4/msi, '4 is now there');

    run_outputdiff([qw(--output)]);
    is($trap->stdout, "1\n4\n3\n", 'output is correct');

    run_outputdiff([qw(--list)]);
    unlike($trap->stdout, qr/CURRENT/msi, 'CURRENT file is not in the list');
};

done_testing;

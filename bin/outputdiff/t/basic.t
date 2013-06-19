#!perl

use Test::More;
use Test::Trap qw/ :output(systemsafe) /;
use strict;

use FindBin qw($Bin);
require "$Bin/helper.pl";

subtest 'simple' => sub {

    run_outputdiff( [qw(--clean)] );

    {
        open my $stdin, '<', \"1\n2\n3\n";
        local *STDIN = $stdin;
        run_outputdiff( [qw(-n)] );
    }

    {
        open my $stdin, '<', \"1\n4\n3\n";
        local *STDIN = $stdin;
        run_outputdiff( [qw(-v -c)] );
    }

    like( $trap->stdout, qr/-2/msi,  '2 is gone' );
    like( $trap->stdout, qr/\+4/msi, '4 is now there' );

    run_outputdiff( [qw(--last)] );
    like( $trap->stdout, qr/-2/msi,  '2 is gone' );
    like( $trap->stdout, qr/\+4/msi, '4 is now there' );

    run_outputdiff( [qw(--output)] );
    is( $trap->stdout, "1\n4\n3\n", 'output is correct' );

    run_outputdiff( [qw(--list)] );
    unlike( $trap->stdout, qr/CURRENT/msi,
        'CURRENT file is not in the list' );
};

subtest 'named' => sub {

    run_outputdiff( [qw(--clean)] );

    {
        open my $stdin, '<', \"1\n2\n3\n";
        local *STDIN = $stdin;
        run_outputdiff( [qw(-n first)] );
    }

    {
        open my $stdin, '<', \"4\n5\n6\n";
        local *STDIN = $stdin;
        run_outputdiff( [qw(-n second)] );
    }

    {
        open my $stdin, '<', \"1\n7\n3\n";
        local *STDIN = $stdin;
        run_outputdiff( [qw(-c first)] );
    }

    like( $trap->stdout, qr/-2/msi,  '2 is gone' );
    like( $trap->stdout, qr/\+7/msi, '7 is now there' );

    {
        open my $stdin, '<', \"4\n8\n6\n";
        local *STDIN = $stdin;
        run_outputdiff( [qw(-c second)] );
    }

    like( $trap->stdout, qr/-5/msi,  '5 is gone' );
    like( $trap->stdout, qr/\+8/msi, '8 is now there' );

    run_outputdiff( [qw(--last first)] );
    like( $trap->stdout, qr/-2/msi,  '2 is gone' );
    like( $trap->stdout, qr/\+7/msi, '7 is now there' );

    run_outputdiff( [qw(--last second)] );
    like( $trap->stdout, qr/-5/msi,  '5 is gone' );
    like( $trap->stdout, qr/\+8/msi, '8 is now there' );

    run_outputdiff( [qw(--output first)] );
    is( $trap->stdout, "1\n7\n3\n", 'output is correct' );

    run_outputdiff( [qw(--output second)] );
    is( $trap->stdout, "4\n8\n6\n", 'output is correct' );

    run_outputdiff( [qw(--list)] );
    unlike( $trap->stdout, qr/CURRENT/msi,
        'CURRENT file is not in the list' );
    like( $trap->stderr, qr/first/msi,  'first is in the list' );
    like( $trap->stderr, qr/second/msi, 'second is in the list' );

    run_outputdiff( [qw(--log first)] );
    like( $trap->stdout, qr/result 2/msi, 'second result message in list' );
    my $first_output = $trap->stdout;

    run_outputdiff( [qw(--log second)] );
    ok( $first_output ne $trap->stdout,
        'log output from first and second is different' );

    run_outputdiff( [qw(--clean second)] );

    run_outputdiff( [qw(--list)] );
    like( $trap->stderr, qr/first/msi, 'first is in the list' );
    unlike( $trap->stderr, qr/second/msi, 'second is not in the list' );
};

subtest 'nonexistant repo' => sub {

    run_outputdiff( [qw(--clean)] );

    {
        open my $stdin, '<', \"1\n2\n3\n";
        local *STDIN = $stdin;
        run_outputdiff( [qw(-c first)] );
    }

    like(
        $trap->stderr,
        qr/no comparison called 'first'/,
        'right error message for -c with name'
    );
    is( $trap->exit, 1, 'non-clean exit' );

    {
        open my $stdin, '<', \"1\n2\n3\n";
        local *STDIN = $stdin;
        run_outputdiff( [qw(-c)] );
    }

    like(
        $trap->stderr,
        qr/No previous comparison/,
        'right error message for -c'
    );
    is( $trap->exit, 1, 'non-clean exit' );

    foreach my $flag (qw(--last --output --log)) {
        run_outputdiff( [ $flag, qw(first) ] );

        like(
            $trap->stderr,
            qr/no comparison called 'first'/,
            "right error message for $flag with name"
        );
        is( $trap->exit, 1, 'non-clean exit' );

        run_outputdiff( [$flag] );

        like(
            $trap->stderr,
            qr/No previous comparison/,
            "right error message for $flag"
        );
        is( $trap->exit, 1, 'non-clean exit' );
    }
};

done_testing;

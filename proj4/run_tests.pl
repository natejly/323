#!/usr/bin/perl -w
use strict;

our $debug = 0;
our $CLASS  = "323";
our $PROJ   = "4";
our $NAME   = "Bash";            # Name of program
our $LANG   = "C";               # Language (C, Perl, ...)
our $CLASS_DIR       = "/c/cs$CLASS";
our $PROJ_DIR        = "$CLASS_DIR/proj$PROJ";
our $TESTS_DIR       = "$PROJ_DIR/tests";
our $CLASS_BIN_DIR   = "$CLASS_DIR/bin";

# Common test functions and actions.
do "/c/cs323/proj4/runner.pl";

&limitCpuTime (2, 4);                           # Limit CPU-time per process
&limitWallClock (10);                           # Limit wall-clock per process
&limitFileSize (100000);                        # Limit size of files created
&limitHeapSize (1000000);                       # Limit size of heap
&limitProcesses (1000);                         # Limit #processes

my $total = 0;

&header ('Local variables');
$total += &runTest ('01', 'With simple command');

&header ('Redirect stdin to file (<)');
$total += &runTest ('02', 'Redirect stdin to file');

&header ('Redirect stdin to HERE document (<<)');
$total += &runTest ('03', 'No expansion in HERE document');

&header ('Redirect stdout to file (>, >>)');
$total += &runTest ('04', 'Redirect stdout to nonexistent/writable file');

&header ('Redirect stdout to pipe (|)');
$total += &runTest ('05', 'Simple pipe');
$total += &runTest ('06', 'Very long pipeline using few descriptors');

&header ('Multiple commands per line');
$total += &runTest ('07', 'Multiple commands separated by ;');

&header ('Background commands (&)');
$total += &runTest ('08', 'Simple background command');

&header ('&& or ||');
$total += &runTest ('09', 'Simple && and ||');

&header ('Grouped commands');
$total += &runTest ('10', 'Redirect stdin to group of simple commands');

&header ('cd');
$total += &runTest ('11', 'cd directoryName AND cd');
$total += &runTest ('12', 'cd errors (ERROR)');

&header ('pushd/popd');
$total += &runTest ('13', 'pushd directoryName');

&header ('Setting STATUS');
$total += &runTest ('14', 'Simple cases of $?');
$total += &runTest ('15', 'Pipe status ');

&header ('Errors');
$total += &runTest ('16', 'Nonexistent / unreadable / unwritable files (ERROR)');

print "\nEnd of Public Script\n";

printf ("\n%3d points Total for $NAME\n", $total);

#&header ("Non-credit Tests");

&sectionHeader ("POSSIBLE DEDUCTIONS");
print "These deductions are assessed after submission, as appropriate.\n\n";
&possibleDeduction ( -5, "Does not make");
&possibleDeduction ( -1, "Compilation errors using -Wall -std=c11 -pedantic");

&cleanupTesting ();
exit $total;

# Author: Vinni Yu     September 2024

#!/usr/bin/perl
use strict;
use warnings;
use File::Compare;    # For comparing files
use File::Temp qw/ tempfile /;   # For creating temporary files
use File::Find;       # For finding test files in the directory

# Change the paths to your executable and your reference solution executable.
# NOTE: I changed the name of the reference solution to "ref". C
my $proj1_path = './proj1';
my $ref_path = './ref';
my $tests_path = './hw1-tests';

# Check if the test folder exists
unless (-d $tests_path) {
    die "Test folder $tests_path does not exist\n";
}

# Check if the proj1 and rf executables exist
unless (-x $proj1_path) {
    die "proj1 executable not found at $proj1_path\n";
}
unless (-x $ref_path) {
    die "ref executable not found at $ref_path\n";
}

# Find all .txt files in the test folder
my @test_files;
find(sub {
    push @test_files, $File::Find::name if $_ =~ /\.txt$/;
}, $tests_path);

if (@test_files == 0) {
    die "No .txt test files found in $tests_path\n";
}

foreach my $test_file (@test_files) {
    # Create temporary files for storing outputs
    my ($proj1_out_fh, $proj1_out_file) = tempfile();
    my ($ref_out_fh, $ref_out_file) = tempfile();

    print "Running test on file: $test_file\n";

    # Run proj1 on the test file and capture the output and exit status
    my $proj1_status = system("$proj1_path $test_file > $proj1_out_file 2>&1");
    my $proj1_exit_code = $? >> 8;

    # Run rf (reference solution) on the test file and capture the output and exit status
    my $ref_status = system("$ref_path $test_file > $ref_out_file 2>&1");
    my $ref_exit_code = $? >> 8;

    # Check if both executables returned an error
    my $proj1_error = ($proj1_exit_code != 0);
    my $ref_error = ($ref_exit_code != 0);

    if ($proj1_error && $ref_error) {
        # Both executables threw an error, output comparison is skipped
        print "PASSED: Test $test_file (both executables threw an error)\n";
    } elsif ($proj1_error != $ref_error) {
        # One executable threw an error and the other did not
        print "FAILED: Test $test_file (error state differs)\n";
        print "proj1 exit code: $proj1_exit_code, rf exit code: $ref_exit_code\n";
    } else {
        # No errors, compare the outputs
        if (compare($proj1_out_file, $ref_out_file) == 0) {
            print "PASSED: Test $test_file (outputs and exit codes match)\n";
        } else {
            print "FAILED: Test $test_file failed (outputs differ)\n";
        }
    }

    print "\n";

    # Clean up temporary files
    unlink $proj1_out_file;
    unlink $ref_out_file;
}
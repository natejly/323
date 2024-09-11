
#!/bin/bash

# AUTHOR: ERIC YOON (emy8)
# 2024-01-30
# LICENSE: PUBLIC DOMAIN


# CHANGE THE BELOW `cd` COMMAND TO WHEREVER YOUR CODE LIVES
cd ../implementation

# CHANGE THE BELOW VARIABLE TO WHEREVER YOU PUT THIS DIRECTORY
TESTS_DIR="../test-inputs/"


# Let's start with the special tests. We have to make sure these
# exited with a FAILURE status code, rather than comparing stdout. 
./Proj1 "${TESTS_DIR}comment-error.txt" 2>/dev/null
diff  <(echo "$?") <(echo "1")

./Proj1 "${TESTS_DIR}macro-with-no-arg.txt" 2>/dev/null
diff  <(echo "$?") <(echo "1")


# OK, now on to the diff tests.

# This test is special because it takes two files.
./Proj1 "${TESTS_DIR}comments-multifile.1.txt" "${TESTS_DIR}comments-multifile.2.txt" | diff - "${TESTS_DIR}comments-multifile.out"

# comments
./Proj1 "${TESTS_DIR}comments.txt" | diff - "${TESTS_DIR}comments.out"
# expand-after
./Proj1 "${TESTS_DIR}expand-after.txt" | diff - "${TESTS_DIR}expand-after.out"
# include
./Proj1 "${TESTS_DIR}include.txt" | diff - "${TESTS_DIR}include.out"
# list-of-values
./Proj1 "${TESTS_DIR}list-of-values.txt" | diff - "${TESTS_DIR}list-of-values.out"
# multiple-line-argument
./Proj1 "${TESTS_DIR}multiple-line-argument.txt" | diff - "${TESTS_DIR}multiple-line-argument.out"
# plain-text
./Proj1 "${TESTS_DIR}plain-text.txt" | diff - "${TESTS_DIR}plain-text.out"
# sample-1 (from spec)
./Proj1 "${TESTS_DIR}sample-1.txt" | diff - "${TESTS_DIR}sample-1.out"
# sample-2 (from spec)
./Proj1 "${TESTS_DIR}sample-2.txt" | diff - "${TESTS_DIR}sample-2.out"
# sequential-evaluation
./Proj1 "${TESTS_DIR}sequential-evaluation.txt" | diff - "${TESTS_DIR}sequential-evaluation.out"

echo "If you see no output other than this line, you've passed. Otherwise, see diffs."

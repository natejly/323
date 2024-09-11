REF="/c/cs323/proj1/proj1"
MY_EXE="./Proj1" # Put your executable name here

#All
if diff <($MY_EXE All.txt) <($REF All.txt) > /dev/null; then
    # No differences
    echo "All: Outputs are identical"
else
    # Differences found
    echo "All: Differences found"
fi

valgrind --leak-check=full $MY_EXE All.txt 2> valgrind_output.txt
if grep -q "ERROR SUMMARY: [^0]" valgrind_output.txt; then
    echo "
Memory errors detected
    "
else
    echo "
No memory errors detected
    "
fi

#Test 1
if diff <($MY_EXE test1_1.txt test1_2.txt) <($REF test1_1.txt test1_2.txt) > /dev/null; then
    # No differences
    echo "Test 1: Outputs are identical"
else
    # Differences found
    echo "Test 1: Differences found"
fi

valgrind --leak-check=full $MY_EXE test1_1.txt test1_2.txt 2> valgrind_output.txt
if grep -q "ERROR SUMMARY: [^0]" valgrind_output.txt; then
    echo "
Memory errors detected
    "
else
    echo "
No memory errors detected
    "
fi

#Test 2
if diff <($MY_EXE test2_1.txt test2_2.txt) <($REF test2_1.txt test2_2.txt) > /dev/null; then
    # No differences
    echo "Test 2: Outputs are identical"
else
    # Differences found
    echo "Test 2: Differences found"
fi

valgrind --leak-check=full $MY_EXE test2_1.txt test2_2.txt 2> valgrind_output.txt
if grep -q "ERROR SUMMARY: [^0]" valgrind_output.txt; then
    echo "
Memory errors detected
    "
else
    echo "
No memory errors detected
    "
fi

#Error 1
$MY_EXE Error_1.txt

#Error 2
$MY_EXE Error_2.txt

#Error 3
$MY_EXE Error_3.txt

#Error 4
$MY_EXE Error_4.txt

#Error 5
$MY_EXE Error_5.txt

#Error 6
$MY_EXE Error_6.txt

#Error 7
$MY_EXE Error_7.txt

rm valgrind_output.txt
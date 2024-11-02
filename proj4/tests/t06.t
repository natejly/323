(1)$ (1)$ Richard M. Stallman, Linus Thorvalds, and
Donald E. Knuth engage in a discussion on
whose impact on the computerized world was
the greatest.

Stallman: "God told me I have programmed the
best editor in the world!"

Thorvalds: "Well, God told *me* that I have
programmed the best operating system in
the world!"

Knuth: "Wait, wait - I never said that."
(2)$ (2)$ (2)$ 				Valgrind$$$$$
				~~~~~~~~$$$$$
$$$$$
Valgrind is a system that detects uninitialized variables, malloc() errors,$$$$$
etc.  To use it, compile your PROGRAM with the -g flag and type$$$$$
$$$$$
  % /c/cs223/bin/valgrind OPTIONS PROGRAM ARGUMENTS$$$$$
$$$$$
where OPTIONS may be any subset of the options listed below and ARGUMENTS are$$$$$
the command-line arguments (if any).  For example:$$$$$
$$$$$
  % valgrind -q ./Psched 3 7 6 4 8 5 4 7 -lw -lwd -bw -bwd$$$$$
$$$$$
When addressing errors, correct the first one first to avoid error cascades.$$$$$
$$$$$
-------------------------------------------------------------------------------$$$$$
$$$$$
			   Useful Valgrind Options$$$$$
			   ~~~~~~~~~~~~~~~~~~~~~~~$$$$$
$$$$$
--log-file=<filename>$$$$$
  Specifies that Valgrind should send all of its messages to the specified$$$$$
  file.  If the file name is empty, it causes an abort.$$$$$
$$$$$
--leak-check=<no|summary|yes|full> [default: summary]$$$$$
  When enabled, search for memory leaks when the client program finishes.  If$$$$$
  set to summary, it says how many leaks occurred.  If set to full or yes, it$$$$$
  also gives details of each individual leak.$$$$$
   $$$$$
--show-reachable=<yes|no> [default: no]$$$$$
  When disabled, the memory leak detector only shows "definitely lost" and$$$$$
  "possibly lost" blocks.  When enabled, the leak detector also shows$$$$$
  "reachable" and "indirectly lost" blocks.  (In other words, it shows all$$$$$
  blocks, except suppressed ones, so --show-all would be a better name for it.)$$$$$
$$$$$
-vgdb-error=0 [default: 999999999]$$$$$
  Start Valgrind using this option:$$$$$
    % valgrind --vgdb-error=0 PROGRAM$$$$$
  In another shell/window, start GDB:$$$$$
    % gdb PROGRAM$$$$$
  and give the following commands to GDB:$$$$$
    (gdb) target remote | vgdb$$$$$
    (gdb) continue$$$$$
  You can now debug your program e.g. by inserting a breakpoint and then using$$$$$
  the GDB continue command.  For more details, see$$$$$
    http://www.valgrind.org/docs/manual/manual-core-adv.html#manual-core-adv.gdbserver$$$$$
$$$$$
-q, --quiet$$$$$
  Run silently, and only print error messages.  Useful if you are running$$$$$
  regression tests or have some other automated test machinery.$$$$$
$$$$$
-------------------------------------------------------------------------------$$$$$
$$$$$
       Common Valgrind Errors and Possible Explanations of their Origin$$$$$
       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$$$$$
$$$$$
Note: Lower parts of the call stack may have been suppressed.  The line number$$$$$
subst (Subst19.c:194) means Line 194 in file Subst19.c in the function subst().$$$$$
The explanations are based entirely on what appears; no attempt was made to$$$$$
verify them by looking at the code.$$$$$
$$$$$
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$$$$$
$$$$$
==15874== Use of uninitialised value of size 8$$$$$
==15874==    at 0x4C2E6D4: strstr (in /usr/lib64/valgrind/vgpreload_mem...)$$$$$
==15874==    by 0x400A9E: main (Subst19.c:79)$$$$$
$$$$$
At least one argument in the call to strstr() at Subst19.c:79 was never$$$$$
assigned a value.$$$$$
$$$$$
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$$$$$
$$$$$
==30047== Invalid read of size 1$$$$$
==30047==    at 0x400C44: main (Subst19.c:88)$$$$$
==30047==  Address 0x51cc528 is 0 bytes after a block of size 88 alloc'd$$$$$
==30047==    at 0x4C2B362: realloc (in /usr/lib64/valgrind/vgpreload_mem...)$$$$$
==30047==    by 0x400C24: main (Subst19.c:86)$$$$$
$$$$$
The statement at main (Subst19.c:88) is attempting to read the first byte$$$$$
following the end of the block of storage that was realloc()-ed on Line 86.$$$$$
$$$$$
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$$$$$
$$$$$
==31573== Invalid read of size 1$$$$$
==31573==    at 0x4016A3: nextProg (Subst19.c:228)$$$$$
==31573==  Address 0x51c230f is 1 bytes before a block of size 1 alloc'd$$$$$
==31573==    at 0x4C2B14B: malloc (in /usr/lib64/valgrind/vgpreload_mem...)$$$$$
==31573==    by 0x400DFE: nextProg (Subst19.c:133)$$$$$
$$$$$
The statement at nextProg (Subst19.c:228) is attempting to read the byte$$$$$
before the start of the block of storage that was malloc()-ed on Line 133.$$$$$
$$$$$
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$$$$$
$$$$$
==11644== Invalid read of size 1$$$$$
==11644==    at 0x4C2BB72: __GI_strlen (in /usr/lib64/valgrind/vgpreload_mem...)$$$$$
==11644==    by 0x4E9B02B: puts (in /lib64/libc-2.14.1.so)$$$$$
==11644==    by 0x401204: main (Subst19.c:154)$$$$$
==11644==  Address 0x51c21c0 is 0 bytes inside a block of size 53 free'd$$$$$
==11644==    at 0x4C29E3C: free (in /usr/lib64/valgrind/vgpreload_mem...)$$$$$
==11644==    by 0x4013BB: subst (Subst19.c:194)$$$$$
$$$$$
The statement at main (Subst19.c:154) called puts(), which begins by finding$$$$$
the length of the string.  However, the pointer passed to puts() points to a$$$$$
block of storage that was free()-ed on Line 194.$$$$$
$$$$$
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$$$$$
$$$$$
==5932== Invalid read of size 1$$$$$
==5932==    at 0x401DD9: swap (Subst19.c:378)$$$$$
==5932==  Address 0x51c21c3 is 3 bytes inside a block of size 35 free'd$$$$$
==5932==    at 0x4C2B362: realloc (in /usr/lib64/valgrind/vgpreload_mem...)$$$$$
==5932==    by 0x401D60: swap (Subst19.c:374)$$$$$
$$$$$
The statement at swap (Subst19.c:378) is trying to read a byte inside a block$$$$$
that was realloc()-ed on Line 374.  Most likely realloc() returned a pointer$$$$$
to a new block (freeing the old one), but the value returned was not assigned$$$$$
to the variable holding the old pointer.$$$$$
$$$$$
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$$$$$
$$$$$
==677== Invalid read of size 1$$$$$
==677==    at 0x400832: stringSize (Subst19.c:15)$$$$$
...$$$$$
==677==  Address 0x0 is not stack'd, malloc'd or (recently) free'd$$$$$
$$$$$
The statement at stringSize (Subst19.c:15) is attempting to dereference a$$$$$
NULL pointer.$$$$$
$$$$$
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$$$$$
$$$$$
==29188== Invalid read of size 1$$$$$
==29188==    at 0x4C2C811: strcmp (in /usr/lib64/valgrind/vgpreload_mem...)$$$$$
==29188==    by 0x400B90: main (Subst19.c:121)$$$$$
==29188==  Address 0x0 is not stack'd, malloc'd or (recently) free'd$$$$$
$$$$$
One argument in the call to to strcmp() at main (Subst19.c:121) has the$$$$$
value NULL.$$$$$
$$$$$
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$$$$$
$$$$$
==2149== Invalid read of size 1$$$$$
==2149==    at 0x4C2E6D4: strstr (in /usr/lib64/valgrind/vgpreload_mem...)$$$$$
==2149==    by 0x402800: findStringIndex (Subst19.c:528)$$$$$
...$$$$$
==2149==  Address 0x740 is not stack'd, malloc'd or (recently) free'd$$$$$
$$$$$
One argument in the call to to strstr() at findStringIndex (Subst19.c:528)$$$$$
does not point to a null-terminated string.$$$$$
$$$$$
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$$$$$
$$$$$
==30206== Conditional jump or move depends on uninitialised value(s)$$$$$
==30206==    at 0x400CBA: main (Subst19.c:90)$$$$$
$$$$$
Some value in the conditional expression at main (Subst19.c:90) was never$$$$$
initialized.$$$$$
$$$$$
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$$$$$
$$$$$
==11091== Conditional jump or move depends on uninitialised value(s)$$$$$
==11091==    at 0x4C2B867: strcat (in /usr/lib64/valgrind/vgpreload_mem...)$$$$$
==11091==    by 0x401BB5: replace (Subst19.c:311)$$$$$
$$$$$
strcat() searches for the end of the first string argument, and then copies$$$$$
characters until it reaches the end of the second.  One of the arguments in$$$$$
the call at replace (Subst19.c:311) is not null-terminated.$$$$$
$$$$$
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$$$$$
$$$$$
==26935== Conditional jump or move depends on uninitialised value(s)$$$$$
==26935==    at 0x4C2C81C: strcmp (in /usr/lib64/valgrind/vgpreload_mem...)$$$$$
==26935==    by 0x400D97: main (Subst19.c:182)$$$$$
$$$$$
strcmp() compares characters one at a time until it finds a mismatch or$$$$$
reaches the end of one string.  One of the arguments in the call at replace$$$$$
(Subst19.c:182) is not null-terminated.$$$$$
$$$$$
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$$$$$
$$$$$
==30760== Conditional jump or move depends on uninitialised value(s)$$$$$
==30760==    at 0x4C29DF2: free (in /usr/lib64/valgrind/vgpreload_mem...)$$$$$
==30760==    by 0x40131F: main (Subst19.c:200)$$$$$
$$$$$
The argument to free() was never assigned a value.$$$$$
$$$$$
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$$$$$
$$$$$
==29559== Invalid write of size 1$$$$$
==29559==    at 0x4C2BE00: strncpy (in /usr/lib64/valgrind/vgpreload_mem...)$$$$$
==29559==    by 0x4011CC: replace (Subst19.c:235)$$$$$
==29559==  Address 0x51c2295 is 0 bytes after a block of size 5 alloc'd$$$$$
==29559==    at 0x4C2B14B: malloc (in /usr/lib64/valgrind/vgpreload_mem...)$$$$$
==29559==    by 0x4011A9: replace (Subst19.c:234)$$$$$
$$$$$
The call to strncpy() at replace (Subst19.c:235) is trying to copy more chars$$$$$
Subs the size of the block allocated at replace (Subst19.c:234) can hold,$$$$$
possibly because there is no room for the null terminator.$$$$$
$$$$$
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$$$$$
$$$$$
==5320== Invalid write of size 1$$$$$
==5320==    at 0x4C2BD67: strncpy (in /usr/lib64/valgrind/vgpreload_mem...)$$$$$
==5320==    by 0x40146F: s (Subst19.c:334)$$$$$
==5320==  Address 0x51c20e0 is 0 bytes inside a block of size 8 free'd$$$$$
==5320==    at 0x4C2B362: realloc (in /usr/lib64/valgrind/vgpreload_mem...)$$$$$
==5320==    by 0x40142D: s (Subst19.c:325)$$$$$
$$$$$
The first argument in the call to strncpy() at s (Subst19.c:334) is a pointer$$$$$
to a block that was free()-ed at s (Subst19.c:325).$$$$$
$$$$$
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$$$$$
$$$$$
==31365== Invalid write of size 1$$$$$
==31365==    at 0x4C2BBAC: strcpy (in /usr/lib64/valgrind/vgpreload_mem...)$$$$$
==31365==    by 0x400E2E: subst (Subst19.c:171)$$$$$
==31365==  Address 0x0 is not stack'd, malloc'd or (recently) free'd$$$$$
$$$$$
The value of the first argument to strcpy() at subst (Subst19.c:171) is the$$$$$
NULL pointer.$$$$$
$$$$$
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$$$$$
$$$$$
==5750== Invalid write of size 1$$$$$
==5750==    at 0x4C2BBAC: strcpy (in /usr/lib64/valgrind/vgpreload_mem...)$$$$$
==5750==    by 0x401069: strbufAppend (Subst19.c:102)$$$$$
...$$$$$
==5750==  Address 0x4ffffe is not stack'd, malloc'd or (recently) free'd$$$$$
$$$$$
The value of the first argument to strcpy() at strbufAppend (Subst19.c:102) is$$$$$
not a pointer to a block of storage.$$$$$
$$$$$
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$$$$$
$$$$$
==1894== Invalid write of size 8$$$$$
==1894==    at 0x40096B: main (Subst19.c:34)$$$$$
==1894==  Address 0x51c2140 is 16 bytes inside a block of size 18 alloc'd$$$$$
==1894==    at 0x4C2B14B: malloc (in /usr/lib64/valgrind/vgpreload_mem...)$$$$$
==1894==    by 0x40090A: main (Subst19.c:31)$$$$$
$$$$$
A block of storage for a pointer array was allocated at main (Subst19.c:31)$$$$$
but the size was not a multiple of 8 (= sizeof(anytype*)).  The attempt to$$$$$
store a pointer in that array at main (Subst19.c:34) ran off the end of the$$$$$
block.$$$$$
$$$$$
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$$$$$
$$$$$
==7331== Invalid free() / delete / delete[] / realloc()$$$$$
==7331==    at 0x4C2B362: realloc (in /usr/lib64/valgrind/vgpreload_mem...)$$$$$
==7331==    by 0x4012F0: parseEscape (Subst19.c:108)$$$$$
==7331==  Address 0x51c24f3 is 3 bytes inside a block of size 6 alloc'd$$$$$
==7331==    at 0x4C2B14B: malloc (in /usr/lib64/valgrind/vgpreload_mem...)$$$$$
==7331==    by 0x401654: replace (Subst19.c:151)$$$$$
$$$$$
The first argument to realloc() at parseEscape (Subst19.c:108) was a pointer$$$$$
into the middle of the block that was allocated at replace (Subst19.c:151).$$$$$
$$$$$
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$$$$$
								CS-323-09/30/19$$$$$
(3)$ End of test
(4)$ 

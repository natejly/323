// process.h                                 Stan Eisenstat (12/04/15)
//
// Backend for Bsh.  See spec for details.

#define _GNU_SOURCE
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <signal.h>
#include <stdbool.h>
#include <sys/file.h>
#include <sys/wait.h>
#include <limits.h>
#include "parse.h"

// Write message to stderr using format FORMAT
#define WARN(format,...) fprintf (stderr, format, __VA_ARGS__)

// Write message to stderr using format FORMAT and exit.
#define DIE(format,...)  WARN(format,__VA_ARGS__), exit (EXIT_FAILURE)

// Change allocated size of array X to S elements
#define REALLOC(x,s) x = realloc (x, (s) * sizeof(*(x)))

// Extract status from value returned by waitpid(); ensure that a process
// that is killed has nonzero status; ignores the possibility of stop/continue.
#define STATUS(x) (WIFEXITED(x) ? WEXITSTATUS(x) : 128+WTERMSIG(x))

// Execute command list CMDLIST and return status of last command executed
int process (const CMD *cmdList);
int checkCD(const CMD *cmd);
int processBG(const CMD *cmd);
int processSimple(const CMD *cmd);
int processPipe(const CMD *cmd);
int checkCD(const CMD *cmd);
int checkPush(const CMD *cmd);
int checkPop(const CMD *cmd);
int handleInputRedirection(const CMD *cmd);
int handleOutputRedirection(const CMD *cmd);
void reap();
int processSubcmd(const CMD *cmdList);
void reportstatus(int status);






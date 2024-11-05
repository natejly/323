#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include "process.h"
#include "parse.h"
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
// typedef struct cmd {
//   int type;             // Node type: SIMPLE, PIPE, SEP_AND, SEP_OR, SEP_END,
//                         //   SEP_BG, SUBCMD, or NONE (default)

//   int argc;             // Number of command-line arguments
//   char **argv;          // Null-terminated argument vector or NULL

//   int nLocal;           // Number of local variable assignments
//   char **locVar;        // Array of local variable names and the values to
//   char **locVal;        //   assign to them when the command executes

//   int fromType;         // Redirect stdin: NONE (default), RED_IN (<), or
//                         //   RED_IN_HERE (<<)
//   char *fromFile;       // File to redirect stdin, contents of here document,
//                         //   or NULL (default)

//   int toType;           // Redirect stdout: NONE (default), RED_OUT (>),
//                         //   RED_OUT_APP (>>), or  RED_OUT_ERR (&>)
//   char *toFile;         // File to redirect stdout or NULL (default)

//   struct cmd *left;     // Left subtree or NULL (default)
//   struct cmd *right;    // Right subtree or NULL (default)
// } CMD;
int process(const CMD *cmdList) {
    int status = 0; // Initialize status to a default value

    switch (cmdList->type) {
        case SIMPLE:
            return processSimple(cmdList);

        case PIPE:
            return processPipe(cmdList);

        case SEP_AND:
            status = process(cmdList->left);
            // If the left command succeeded, process the right command
            if (status == 0) {
                status = process(cmdList->right);
            }
            return status; // Return the final status

        case SEP_OR:
            status = process(cmdList->left);
            // If the left command failed, process the right command
            if (status != 0) {
                status = process(cmdList->right);
            }
            return status; // Return the final status

        case SEP_END:
            process(cmdList->left);
            status = process(cmdList->right);
            return status; // Return the status of the right command

        case SEP_BG:
            status = processBG(cmdList);
            return status; // Return status from processBG

        case SUBCMD:
            // status = processSubcmd(cmdList);
            // return status; // Return status from processSubcmd

        case NONE:
            // Do nothing, return default status
            return status;

        default:
            // Unrecognized command type, possibly set an error status
            fprintf(stderr, "Unsupported command type\n");
            return 1; // Return a non-zero status to indicate failure
    }
}

int processBG(const CMD *cmd){
    //fork a child process
    //execute the left command
    //parent process continues to the next command
    return 1;
}

int handleInputRedirection(const CMD *cmd) {
    if (cmd->fromType == NONE) return 0;

    int fd_in;
    if (cmd->fromType == RED_IN) {
        fd_in = open(cmd->fromFile, O_RDONLY);
        if (fd_in < 0) {
            perror("open");
            return errno;
        }
    } else if (cmd->fromType == RED_IN_HERE) {
        char template[] = "/tmp/hereXXXXXX";
        fd_in = mkstemp(template);
        if (fd_in < 0) {
            perror("mkstemp");
            return errno;
        }
        if (write(fd_in, cmd->fromFile, strlen(cmd->fromFile)) < 0) {
            perror("write");
            close(fd_in);
            return errno;
        }
        lseek(fd_in, 0, SEEK_SET);
        unlink(template);
    } else {
        fprintf(stderr, "Unsupported input redirection type\n");
        return 1;
    }

    if (dup2(fd_in, STDIN_FILENO) < 0) {
        perror("dup2");
        close(fd_in);
        return errno;
    }
    close(fd_in);
    return 0;
}

int handleOutputRedirection(const CMD *cmd) {
    if (cmd->toType == NONE) return 0;

    int fd_out;
    if (cmd->toType == RED_OUT) {
        fd_out = open(cmd->toFile, O_WRONLY | O_CREAT | O_TRUNC, 0644);
    } else if (cmd->toType == RED_OUT_APP) {
        fd_out = open(cmd->toFile, O_WRONLY | O_CREAT | O_APPEND, 0644);
    } else if (cmd->toType == RED_OUT_ERR) {
        fd_out = open(cmd->toFile, O_WRONLY | O_CREAT | O_TRUNC, 0644);
    } else {
        fprintf(stderr, "Unsupported output redirection type\n");
        return 1;
    }

    if (fd_out < 0) {
        perror("open");
        return errno;
    }

    if (cmd->toType == RED_OUT_ERR) {
        if (dup2(fd_out, STDOUT_FILENO) < 0 || dup2(fd_out, STDERR_FILENO) < 0) {
            perror("dup2");
            close(fd_out);
            return errno;
        }
    } else if (dup2(fd_out, STDOUT_FILENO) < 0) {
        perror("dup2");
        close(fd_out);
        return errno;
    }
    close(fd_out);
    return 0;
}


int checkCD(const CMD *cmd){
        // Handle variable assignments for 'cd'
        for (int i = 0; i < cmd->nLocal; i++){
            if (setenv(cmd->locVar[i], cmd->locVal[i], 1) != 0) {
                perror("setenv");
                return 1;
            }
        }

        // Determine the target directory
        const char *targetDir;
        if (cmd->argc > 1) {
            targetDir = cmd->argv[1];
        } else {
            // No argument provided; default to HOME directory
            targetDir = getenv("HOME");
            if (targetDir == NULL) {
                fprintf(stderr, "cd: HOME not set\n");
                return 1;
            }
        }

        // Change directory
        if (chdir(targetDir) != 0) {
            perror("cd");
            return errno;
        }

        // Success
        return 0;
    }

int processSimple(const CMD *cmd) {
    if (cmd->argc > 0 && strcmp(cmd->argv[0], "cd") == 0) {
        return checkCD(cmd);
    }
    int status;
    pid_t pid = fork();
    if (pid < 0) {
        perror("fork");
        return errno;
    }
    if (pid == 0) {
        // Child process

        // Set environment variables
        for (int i = 0; i < cmd->nLocal; i++) {
            if (setenv(cmd->locVar[i], cmd->locVal[i], 1) != 0) {
                perror("setenv");
                exit(1);
            }
        }

        // Handle redirections using helper functions
        if (handleInputRedirection(cmd) != 0) {
            exit(1);
        }
        if (handleOutputRedirection(cmd) != 0) {
            exit(1);
        }

        // Execute command
        execvp(cmd->argv[0], cmd->argv);
        perror("execvp");
        exit(errno);
    }
    // Parent process: wait for child
    if (waitpid(pid, &status, 0) < 0) {
        perror("waitpid");
        return errno;
    }

    return WEXITSTATUS(status);
}

 
int processPipe(const CMD *cmd) {
    if (cmd == NULL) {
        return 0;
    }

    int status = 0;
    int in_fd = 0;          // Input file descriptor for the first command
    int fd[2];              // Pipe file descriptors
    pid_t pid;
    int cmd_count = 0;

    // Arrays to store commands and PIDs
    const CMD *cmds[1024];
    pid_t pid_list[1024];

    // Flatten the pipeline into an array of commands
    const CMD *current_cmd = cmd;
    while (current_cmd->type == PIPE) {
        cmds[cmd_count++] = current_cmd->right;
        current_cmd = current_cmd->left;
    }
    cmds[cmd_count++] = current_cmd; // Add the last command

    // Reverse the array to maintain correct order of execution
    for (int i = 0; i < cmd_count / 2; ++i) {
        const CMD *temp = cmds[i];
        cmds[i] = cmds[cmd_count - i - 1];
        cmds[cmd_count - i - 1] = temp;
    }

    // Setup input redirection for the first command if needed
    if (cmds[0]->fromType != NONE) {
        in_fd = open(cmds[0]->fromFile, O_RDONLY);
        if (in_fd < 0) {
            perror("open");
            return errno;
        }
    }

    // Iterate over the commands in the pipeline
    for (int i = 0; i < cmd_count; ++i) {
        // Create a pipe for all but the last command
        if (i < cmd_count - 1) {
            if (pipe(fd) < 0) {
                perror("pipe");
                return errno;
            }
        } else {
            fd[0] = fd[1] = -1; // No pipe needed for the last command
        }

        pid = fork();
        if (pid < 0) {
            perror("fork");
            return errno;
        } else if (pid == 0) {
            // Child process

            // Set environment variables
            for (int j = 0; j < cmds[i]->nLocal; j++) {
                if (setenv(cmds[i]->locVar[j], cmds[i]->locVal[j], 1) != 0) {
                    perror("setenv");
                    exit(1);
                }
            }

            // Input redirection for first command or via pipe
            if (i == 0 && cmds[i]->fromType != NONE) {
                if (handleInputRedirection(cmds[i]) != 0) exit(1);
            } else if (in_fd != 0) {
                if (dup2(in_fd, STDIN_FILENO) < 0) {
                    perror("dup2");
                    exit(errno);
                }
            }

            // Output redirection
            if (i < cmd_count - 1) {
                if (dup2(fd[1], STDOUT_FILENO) < 0) {
                    perror("dup2");
                    exit(errno);
                }
            } else if (cmds[i]->toType != NONE) {
                if (handleOutputRedirection(cmds[i]) != 0) exit(1);
            }

            // Close unused file descriptors
            if (fd[0] != -1) close(fd[0]);
            if (fd[1] != -1) close(fd[1]);
            if (in_fd != 0) close(in_fd);

            // Execute command
            execvp(cmds[i]->argv[0], cmds[i]->argv);
            perror("execvp");
            exit(errno);
        } else {
            // Parent process
            pid_list[i] = pid;

            // Close file descriptors in the parent
            if (in_fd != 0) close(in_fd);
            if (fd[1] != -1) close(fd[1]);

            // Prepare input for the next command
            in_fd = fd[0];
        }
    }

    // Wait for all child processes to complete
    int final_status = 0;
    for (int i = 0; i < cmd_count; ++i) {
        int wstatus;
        if (waitpid(pid_list[i], &wstatus, 0) < 0) {
            perror("waitpid");
            return errno;
        }
        if (WIFEXITED(wstatus)) {
            final_status = WEXITSTATUS(wstatus);
        } else if (WIFSIGNALED(wstatus)) {
            final_status = 128 + WTERMSIG(wstatus);
        }
    }

    return final_status;
}

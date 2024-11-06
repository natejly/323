#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <assert.h>
#include "process.h"
#include "parse.h"




typedef struct CMDNode {
    const CMD *cmd;
    struct CMDNode *next;
} CMDNode;

void push(CMDNode **stack, const CMD *cmd) {
    CMDNode *new_node = malloc(sizeof(CMDNode));
    new_node->cmd = cmd;
    new_node->next = *stack;
    *stack = new_node;
}

const CMD *pop(CMDNode **stack) {
    if (*stack == NULL) return NULL;
    CMDNode *top = *stack;
    const CMD *cmd = top->cmd;
    *stack = top->next;
    free(top);
    return cmd;
}
// char* stack implementation from James Aspnes 223 lecture
struct elt {
    struct elt *next;
    char* value;
};
struct elt *head = NULL;
struct elt *curr = NULL;
#define STACK_EMPTY (0)
void stackPush(char* dir){
    struct elt *e = malloc(sizeof(struct elt));
    assert(e);
    e->value = malloc(strlen(dir) + 1);
    e->value = strcpy(e->value, dir);
    e->next = head;
    head = e;
}
char* stackPop(){
    if(head == NULL){
        return STACK_EMPTY;
    }
    char* ret = head->value;
    struct elt *e = head;
    head = e->next;
    free(e->value);
    free(e); // Do not free e->value here
    return ret;
}
void stackPrint(){
    struct elt *ptr;
    for(ptr = head; ptr != 0; ptr = ptr->next) {
        printf(" %s", ptr->value);
    }
    printf("\n");
}
int process(const CMD *cmdList) {
    reap();
    int status = 0; 
    switch (cmdList->type) {
        case SIMPLE:
            return processSimple(cmdList);

        case PIPE:
            return processPipe(cmdList);

        case SEP_AND:
            status = process(cmdList->left);
            if (status == 0) {
                status = process(cmdList->right);
            }
            return status;

        case SEP_OR:
            status = process(cmdList->left);
            if (status != 0) {
                status = process(cmdList->right);
            }
            return status;

        case SEP_END:
            status = process(cmdList->left);
            reap();  
            status = process(cmdList->right);  
            return status;

        case SEP_BG:
            processBG(cmdList);
            return 0; // Status is 0 in the invoking shell

        case SUBCMD:
            status = processSubcmd(cmdList);
            return status; // Return status from processSubcmd

        case NONE:
            // Grouped command
            if (cmdList->left != NULL) {
                status = process(cmdList->left);
            }
            return status;

        default:
            fprintf(stderr, "Unsupported command type\n");
            return 1; // Return a non-zero status to indicate failure
    }
}
int processSimple(const CMD *cmd) {
    // Set local variables if any
    for (int i = 0; i < cmd->nLocal; i++) {
        if (setenv(cmd->locVar[i], cmd->locVal[i], 1) != 0) {
            perror("setenv");
            return errno;
        }
    }

    // Check for built-in commands
    if (cmd->argc > 0 && strcmp(cmd->argv[0], "cd") == 0) {
        int status = checkCD(cmd);
        reportstatus(status);
        return status;
    } else if (cmd->argc > 0 && strcmp(cmd->argv[0], "pushd") == 0) {
        int status = checkPush(cmd);
        reportstatus(status);
        return status;
    } else if (cmd->argc > 0 && strcmp(cmd->argv[0], "popd") == 0) {
        int status = checkPop(cmd);
        reportstatus(status);
        return status;
    }

    // Fork to create a new process for non-built-in commands
    pid_t pid = fork();
    if (pid < 0) {
        perror("fork");
        return errno;
    } else if (pid == 0) {
        // Child process
        if (handleInputRedirection(cmd) != 0) {
            exit(errno);
        }
        if (handleOutputRedirection(cmd) != 0) {
            exit(errno);
        }

        // Execute the command
        if (execvp(cmd->argv[0], cmd->argv) < 0) {
            perror("execvp");
            exit(errno);
        }
    } else {
        // Parent process
        int status;
        if (waitpid(pid, &status, 0) < 0) {
            perror("waitpid");
            return errno;
        }
        
        int final_status = STATUS(status);  // Use STATUS macro to get the correct status
        reportstatus(final_status);  // Report status
        return final_status;
    }
    
    return 0;  // Should not reach here
}
int checkCD(const CMD *cmd){
    // Determine the target directory
    const char *target;
    if (cmd->argc == 1) {
        target = getenv("HOME");
        if (target == NULL) {
            fprintf(stderr, "cd: HOME not set\n");
            return 1;
        }
    } else if (cmd->argc == 2){
        target = cmd->argv[1];
    } else {
        fprintf(stderr, "cd: too many arguments\n");
        return 1;
    }
    // Change directory
    if (chdir(target) != 0) {
        perror("cd");
        return errno;
    }
    // Success
    return 0;
}
int checkPush(const CMD *cmd){
    // Set local variables
    for (int i = 0; i < cmd->nLocal; i++) {
        if (setenv(cmd->locVar[i], cmd->locVal[i], 1) != 0) {
            perror("setenv");
            return errno;
        }
    }

    // Get current directory
    char *cwd = getcwd(NULL, 0);
    if (cwd == NULL) {
        perror("getcwd");
        return errno;
    }

    if (cmd->argc == 1){
        char *home = getenv("HOME");
        if (home == NULL) {
            perror("getenv");
            free(cwd);
            return errno;
        }
        stackPush(home);
        if (chdir(home) != 0) {
            perror("pushd: chdir");
            free(cwd);
            return errno;
        }
        printf("%s", getcwd(NULL, 0));
        stackPrint();
    } else if (cmd->argc == 2) {
        stackPush(cwd);
        if (chdir(cmd->argv[1]) != 0) {
            perror("pushd: chdir");
            free(cwd);
            return errno;
        }
        printf("%s", getcwd(NULL, 0));
        stackPrint();
    } else {
        fprintf(stderr, "pushd: Usage: pushd [dir]\n");
        free(cwd);
        return 1;
    }
    free(cwd);
    return 0;
}
int checkPop(const CMD *cmd){
    // Set local variables
    for (int i = 0; i < cmd->nLocal; i++) {
        if (setenv(cmd->locVar[i], cmd->locVal[i], 1) != 0) {
            perror("setenv");
            return errno;
        }
    }

    if(cmd->argc == 1){
        if (head == NULL) {
            fprintf(stderr, "popd: directory stack empty\n");
            return 1;
        }
        char *dir = stackPop();
        if (chdir(dir) != 0) {
            perror("popd: chdir");
            free(dir);
            return errno;
        }
        printf("%s", getcwd(NULL, 0));
        stackPrint();
        free(dir);
        return 0;
    } else {
        fprintf(stderr, "popd: Usage: popd\n");
        return 1;
    }
}
int handleInputRedirection(const CMD *cmd) {
    if (cmd->fromType == NONE) {
        return 0;
    }
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
        if (dup2(fd_out, STDERR_FILENO) < 0) {
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
int processPipe(const CMD *cmd) {
    if (cmd == NULL) {
        return 0;
    }

    int in_fd = 0;  // Input file descriptor for the first command
    int fd[2];      // Pipe file descriptors
    pid_t pid;

    CMDNode *stack = NULL;

    // Flatten the pipeline into a stack of commands
    const CMD *current_cmd = cmd;
    int cmd_count = 0;
    while (current_cmd->type == PIPE) {
        push(&stack, current_cmd->right);
        current_cmd = current_cmd->left;
        cmd_count++;
    }
    push(&stack, current_cmd);
    cmd_count++;

    pid_t pid_list[cmd_count];
    int status_list[cmd_count];
    cmd_count = 0;

    // Process each command in the pipeline
    while ((current_cmd = pop(&stack)) != NULL) {
        if (stack != NULL) {
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
            if (in_fd != 0) {
                dup2(in_fd, STDIN_FILENO);
                close(in_fd);
            }
            if (stack != NULL) {
                dup2(fd[1], STDOUT_FILENO);
                close(fd[1]);
            }
            // Close unused file descriptors
            if (fd[0] != -1) close(fd[0]);

            // Execute the command
            int status = process(current_cmd);
            exit(status);
        } else {
            // Parent process
            pid_list[cmd_count++] = pid;

            // Close pipes in the parent
            if (in_fd != 0) close(in_fd);
            if (fd[1] != -1) close(fd[1]);

            in_fd = fd[0]; // Set up input for the next command
        }
    }

    // Wait for all child processes to complete
    int final_status = 0;
    int any_failed = 0;
    for (int i = 0; i < cmd_count; ++i) {
        int wstatus;
        if (waitpid(pid_list[i], &wstatus, 0) < 0) {
            perror("waitpid");
            return errno;
        }
        status_list[i] = STATUS(wstatus);
        if (status_list[i] != 0) {
            any_failed = 1;
            final_status = status_list[i]; // Keep updating to the latest failure
        }
    }

    // Report the final status of the pipeline
    reportstatus(any_failed ? final_status : 0);
    return any_failed ? final_status : 0;
}

//------------------------------------------------------------------


typedef struct PIDNode {
    pid_t pid;
    struct PIDNode *next;
} PIDNode;

PIDNode *bg_stack = NULL;  // Stack for background processes

// Push a process ID onto the background stack
void push_bg_process(pid_t pid) {
    PIDNode *new_node = malloc(sizeof(PIDNode));
    if (new_node == NULL) {
        perror("malloc");
        exit(1);
    }
    new_node->pid = pid;
    new_node->next = bg_stack;
    bg_stack = new_node;
}

// Reap all background processes in the stack
void reap() {
    PIDNode **current = &bg_stack;
    while (*current != NULL) {
        int status;
        pid_t pid = (*current)->pid;
        pid_t result = waitpid(pid, &status, WNOHANG);
        if (result == 0) {
            // Process has not terminated yet
            current = &(*current)->next;
        } else if (result == pid) {
            // Process terminated
            int final_status = STATUS(status);
            if (WIFEXITED(status)) {
                printf("Completed: %d (%d)\n", pid, WEXITSTATUS(status));
            } else if (WIFSIGNALED(status)) {
                printf("Process %d terminated by signal %d\n", pid, WTERMSIG(status));
            }
            reportstatus(final_status);  // Report the final status of the background job

            // pop the node
            PIDNode *temp = *current;
            *current = (*current)->next;
            free(temp);
        } else {
            // Error
            perror("waitpid");
            current = &(*current)->next;
        }
    }
}


int processBG(const CMD *cmd) {
    pid_t pid = fork();  // Fork a new process

    if (pid < 0) {  // Error handling for fork failure
        perror("fork");
        return errno;
    }

    if (pid == 0) {  // Child process: Execute the left command in the background
        int status = process(cmd->left);  // Recursively process the left command
        exit(status);  // Exit child with the status of the left command
    } else {  // Parent process: Do not wait for the child
        fprintf(stderr, "Backgrounded: %d\n", pid);
        push_bg_process(pid);  // Push background PID onto stack
        
        // Process the right command and report its status
        int status = process(cmd->right);
        reportstatus(status);
        return status;
    }
}



int processSubcmd(const CMD *cmd) {
    pid_t pid = fork();

    if (pid < 0) {
        perror("fork");
        return errno;
    } else if (pid == 0) {
        // Child process: execute the subcommand in a subshell
        // Handle input/output redirections
        if (handleInputRedirection(cmd) != 0) {
            exit(errno);
        }
        if (handleOutputRedirection(cmd) != 0) {
            exit(errno);
        }

        // Set local variables
        for (int i = 0; i < cmd->nLocal; i++) {
            if (setenv(cmd->locVar[i], cmd->locVal[i], 1) != 0) {
                perror("setenv");
                exit(errno);
            }
        }

        // Recursively process the subcommand
        int status = process(cmd->left); // Assuming the subcommand is in cmd->left
        exit(status);
    } else {
        // Parent process: wait for the child to finish
        int status;
        if (waitpid(pid, &status, 0) < 0) {
            perror("waitpid");
            return errno;
        }
        
        int final_status = STATUS(status);  // Get the final status
        reportstatus(final_status);  // Report the final status
        return final_status;
    }
}




void reportstatus(int status) {
    char status_str[12];  // Buffer to hold the status as a string
    snprintf(status_str, sizeof(status_str), "%d", status);  // Convert status to string
    if (setenv("?", status_str, 1) != 0) {  // Set $? environment variable
        perror("setenv");
    }
}
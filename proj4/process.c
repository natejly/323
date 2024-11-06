#define _POSIX_C_SOURCE 200809L
#define STACK_EMPTY (0)
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <assert.h>
#include "process.h"
#include "parse.h"
#include <stdbool.h>
int process (const CMD *cmdList);
int checkCD(const CMD *cmd);
int processBG(const CMD *cmd, bool f);
int processSep(const CMD *cmd, bool f);
int processSimple(const CMD *cmd);
int processPipe(const CMD *cmd);
int checkCD(const CMD *cmd);
int checkPush(const CMD *cmd);
int checkPop(const CMD *cmd);
int handleInputRedirection(const CMD *cmd);
int handleOutputRedirection(const CMD *cmd);
void reap();
int processSubcmd(const CMD *cmd);
void reportstatus(int status);
int bg_push(const CMD *cmd);



// char* stack implementation from James Aspnes 223 lecture
// process SEP and background were from whiteboard pic on OH

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
struct elt {
    struct elt *next;
    char* value;
};
struct elt *head = NULL;
struct elt *curr = NULL;
void stackPush(char* dir){
    struct elt *e = malloc(sizeof(struct elt));
    assert(e);
    e->value = malloc(strlen(dir) + 1);
    strcpy(e->value, dir);

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
    free(e->value); // Free the string memory as well
    free(e);
    return ret;
}

void stackPrint(){
    struct elt *ptr;
    for(ptr = head; ptr != 0; ptr = ptr->next) {
        printf(" %s", ptr->value);
    }
    printf("\n");
}

typedef struct PIDNode {
    pid_t pid;
    struct PIDNode *next;
} PIDNode;

PIDNode *bg_stack = NULL; 
typedef struct varlist {
    char *var;
    char *original_val;
} varlist;
//---------------------------------------------------------------------------------------------------
int process(const CMD *cmdList) {
    reap(); 
    int status = 0; 

    if (cmdList == NULL) return 0;

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
            return processSep(cmdList, 0); 
        case SEP_BG:
            return processBG(cmdList, 0);  

        case SUBCMD:
            status = processSubcmd(cmdList);
            return status;

        default:
            fprintf(stderr, "Unsupported command type\n");
            return 1;  
    }
}

int processSep(const CMD *cmd, bool f) {
    if (cmd == NULL) return 0;
    int status = 0;
    if (cmd->left != NULL) {
        if (cmd->left->type == SEP_END) {
            status = processSep(cmd->left, false);

        } else if (cmd->left->type == SEP_BG) {
            status = processBG(cmd->left, false);
        } else {
            status = process(cmd->left);
        }
    }
    if (cmd->right != NULL) {
        if (f) {
            status = bg_push(cmd->right);
        } else {
            status = process(cmd->right);
        }
    }
    return status;
}

int processBG(const CMD *cmd, bool f) {
    if (cmd == NULL) return 0;

    if (cmd->left != NULL) {
        if (cmd->left->type == SEP_END) {
            processSep(cmd->left, true);

        } else if (cmd->left->type == SEP_BG) {
            processBG(cmd->left, true);

        } else {
            bg_push(cmd->left);
        }
    }

    if (cmd->right != NULL) {
        if (f) {
            processBG(cmd->right, true);
        } else {
            process(cmd->right);
        }
    }

    return 0;
}

int processSimple(const CMD *cmd) {
    varlist *ogs = malloc(cmd->nLocal * sizeof(varlist));
    if (ogs == NULL) {
        perror("malloc");
        return errno;
    }

    for (int i = 0; i < cmd->nLocal; i++) {
        if (cmd->locVar[i] != NULL && cmd->locVal[i] != NULL) {
            ogs[i].var = cmd->locVar[i];
            ogs[i].original_val = getenv(cmd->locVar[i]) ? strdup(getenv(cmd->locVar[i])) : NULL;
            setenv(cmd->locVar[i], cmd->locVal[i], 1);
        }
    }

    if (cmd->argc > 0 && strcmp(cmd->argv[0], "cd") == 0) {
        int status = checkCD(cmd);
        reportstatus(status);
        for (int i = 0; i < cmd->nLocal; i++) {
            if (ogs[i].original_val != NULL) {
                setenv(ogs[i].var, ogs[i].original_val, 1);
                free(ogs[i].original_val);
            } else {
                unsetenv(ogs[i].var);
            }
        }
        free(ogs);

        return status;
    } else if (cmd->argc > 0 && strcmp(cmd->argv[0], "pushd") == 0) {
        int status = checkPush(cmd);
        reportstatus(status);
        
        for (int i = 0; i < cmd->nLocal; i++) {
            if (ogs[i].original_val != NULL) {
                setenv(ogs[i].var, ogs[i].original_val, 1);
                free(ogs[i].original_val);
            } else {
                unsetenv(ogs[i].var);
            }
        }
        free(ogs);

        return status;
    } else if (cmd->argc > 0 && strcmp(cmd->argv[0], "popd") == 0) {
        int status = checkPop(cmd);
        reportstatus(status);

        for (int i = 0; i < cmd->nLocal; i++) {
            if (ogs[i].original_val != NULL) {
                setenv(ogs[i].var, ogs[i].original_val, 1);
                free(ogs[i].original_val);
            } else {
                unsetenv(ogs[i].var);
            }
        }
        free(ogs);

        return status;
    }

    pid_t pid = fork();
    if (pid < 0) {
        perror("fork");
        
        for (int i = 0; i < cmd->nLocal; i++) {
            free(ogs[i].original_val);
        }
        free(ogs);
        
        return errno;
    } else if (pid == 0) {
        // Child process
        if (handleInputRedirection(cmd) != 0) {
            exit(errno);
        }
        if (handleOutputRedirection(cmd) != 0) {
            exit(errno);
        }
        if (execvp(cmd->argv[0], cmd->argv) < 0) {
            perror("execvp");
            exit(errno);
        }
    } else {
        int status;
        if (waitpid(pid, &status, 0) < 0) {
            perror("waitpid");
            status = errno;
        } else {
            status = STATUS(status); 
        }
        reportstatus(status);

        // Restore 
        for (int i = 0; i < cmd->nLocal; i++) {
            if (ogs[i].original_val != NULL) {
                setenv(ogs[i].var, ogs[i].original_val, 1);
                free(ogs[i].original_val);
            } else {
                unsetenv(ogs[i].var);
            }
        }
        free(ogs);
        return status;
    }
    return 0;  
}

int checkCD(const CMD *cmd){
    const char *target;
if (cmd->argc == 1) {
    target = getenv("HOME");
    if (target == NULL) {
        fprintf(stderr, "cd: HOME not set\n");
        return 1;
    }
} else if (cmd->argc == 2) {
    target = cmd->argv[1];
} else {
    fprintf(stderr, "cd: too many arguments\n");
    return 1;
}

    if (chdir(target) != 0) {
        perror("cd");
        return errno;
    }

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

    if (cmd->argc == 1) {
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
        char *new_cwd = getcwd(NULL, 0);
        if (new_cwd != NULL) {
            printf("%s", new_cwd);
            free(new_cwd);  
        }
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
        free(dir); // Free dir after use

        char *new_cwd = getcwd(NULL, 0);
        if (new_cwd != NULL) {
            printf("%s", new_cwd);
            fflush(stdout);
            free(new_cwd);
        }
        stackPrint();
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
        unlink(template); // Ensure the temporary file is removed
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

    int in_fd = 0;
    int fd[2];     
    pid_t pid;

    CMDNode *stack = NULL;
    const CMD *current_cmd = cmd;
    int cmd_count = 0;

    // Flatten the pipeline commands into the stack
    while (current_cmd != NULL && current_cmd->type == PIPE) {
        push(&stack, current_cmd->right);
        current_cmd = current_cmd->left;
        cmd_count++;
    }
    if (current_cmd != NULL) {
        push(&stack, current_cmd);
        cmd_count++;
    }

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
            fd[0] = fd[1] = -1; 
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
            if (fd[0] != -1) close(fd[0]);

            int status = process(current_cmd);
            exit(status);
        } else {
            pid_list[cmd_count++] = pid;

            if (in_fd != 0) close(in_fd);
            if (fd[1] != -1) close(fd[1]);
            in_fd = fd[0]; 
        }
    }
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
            final_status = status_list[i]; 
        }
    }

    // Report the final status of the pipeline
    reportstatus(any_failed ? final_status : 0);
    return any_failed ? final_status : 0;
}

int bg_push(const CMD *cmd) {
    pid_t pid = fork();
    if (pid == -1) {
        perror("fork failed");
        return errno;
    } else if (pid == 0) {
        exit(process(cmd));
    } else {
        fprintf(stderr, "Backgrounded: %d\n", pid);
        PIDNode *new_node = malloc(sizeof(PIDNode));
        if (new_node == NULL) {
            perror("malloc");
            return 1;  
        }
        new_node->pid = pid;
        new_node->next = bg_stack;
        bg_stack = new_node;
    }
    return 0;
}

void reap() {
    PIDNode **current = &bg_stack;
while (*current != NULL) {
    int status;
    pid_t pid = (*current)->pid;
    pid_t result = waitpid(pid, &status, WNOHANG);
    
    if (result == 0) {
        current = &(*current)->next;
    } else if (result == pid) {
        int final_status = STATUS(status);
        if (WIFEXITED(status)) {
            fprintf(stderr, "Completed: %d (%d)\n", pid, WEXITSTATUS(status));
        }
        reportstatus(final_status);
        
        PIDNode *temp = *current;
        *current = (*current)->next;
        free(temp);
    } else {
        perror("waitpid");
        current = &(*current)->next;
    }
}

}

int processSubcmd(const CMD *cmd) {
    pid_t pid = fork();
    if (pid < 0) {
        perror("fork");
        return errno;
    } else if (pid == 0) {
        if (handleInputRedirection(cmd) != 0 || handleOutputRedirection(cmd) != 0) {
            exit(errno);
        }

        varlist *ogs = malloc(cmd->nLocal * sizeof(varlist));
        if (ogs == NULL) {
            perror("malloc");
            exit(errno);
        }

        for (int i = 0; i < cmd->nLocal; i++) {
            if (cmd->locVar[i] != NULL && cmd->locVal[i] != NULL) {
                ogs[i].var = cmd->locVar[i];
                ogs[i].original_val = getenv(cmd->locVar[i]) ? strdup(getenv(cmd->locVar[i])) : NULL;
                setenv(cmd->locVar[i], cmd->locVal[i], 1);
            }
        }

        int status = process(cmd->left);

        for (int i = 0; i < cmd->nLocal; i++) {
            if (ogs[i].original_val != NULL) {
                setenv(ogs[i].var, ogs[i].original_val, 1);
                free(ogs[i].original_val);
            } else {
                unsetenv(ogs[i].var);
            }
        }
        free(ogs);

        exit(status);  
    } else {
        int status;
        if (waitpid(pid, &status, 0) < 0) {
            perror("waitpid");
            return errno;
        }
        int final_status = STATUS(status);
        reportstatus(final_status);
        return final_status;
    }
}

void reportstatus(int status) {
    char status_str[24];  
    snprintf(status_str, sizeof(status_str), "%d", status);  
    if (setenv("?", status_str, 1) != 0) {  
        perror("setenv");
    }
}
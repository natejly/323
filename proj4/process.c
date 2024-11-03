#include "process.h"
#include "parse.h"
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
int process (const CMD *cmdList){
    // itterate through list 
    
    
}
 
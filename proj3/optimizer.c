#include "optimizer.h"


void Optimizer(NodeList *funcdecls) {
    // run through list
    while(funcdecls != NULL){
        Node *node = funcdecls->node;
        // get expressions 
        // if expression check if we can fold
        funcdecls = funcdecls->next;
    }
// constant folding (solve expressions a = 3+ 5, a = 8)
//constant propogation  (replace vars c = b/a c = 16/8)
// eliminate dead code (removes lines where var innit but not used)
}

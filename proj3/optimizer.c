#include "optimizer.h"


void Optimizer(NodeList *funcdecls) {
    bool changes = false;
    // run through list
    while (funcdecls != NULL) {
        // run through each function
        // this logic isn't right but just here for now
        // if(ConstantFolding(funcdecls)){
        //     changes = true;
        // }
        // if(ConstProp(funcdecls)){
        //     changes = true;
        // }
        if(DeadAssign(funcdecls)){
            changes = true;
        }   
        funcdecls = funcdecls->next;
    }

// constant folding (solve expressions a = 3+ 5, a = 8)
//constant propogation  (replace vars c = b/a c = 16/8)
// eliminate dead code (removes lines where var innit but not used)
}

#include "optimizer.h"


void Optimizer(NodeList *funcdecls) {
    bool changes = true;

    // run through list
    while (funcdecls != NULL) {
        if(ConstantFolding(funcdecls)){
            changes = true;
        }
        if(ConstProp(funcdecls)){
            changes = true;
        }
        // if(DeadAssign(funcdecls)){
        //     changes = true;
        // }   
        funcdecls = funcdecls->next;
    }
    
    
}

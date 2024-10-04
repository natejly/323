#include "optimizer.h"

void Optimizer(NodeList *funcdecls) {
    bool changes = true;

    while (changes) {
        changes = false;
        NodeList *current = funcdecls; 

        while (current != NULL) {
            if (ConstantFolding(current)) {
                changes = true; 
            }
            if (ConstProp(current)) {
                changes = true; 
            }
            if (DeadAssign(current)) {
                changes = true;  
            }
            current = current->next; 
        }

    }

}

/*
********************************************************************************
  CONSTPROP.C : IMPLEMENT THE DOWNSTREAM CONSTANT PROPOGATION OPTIMIZATION HERE
*********************************************************************************
*/

#include "constprop.h"

refConst *lastNode, *headNode;
/*
*************************************************************************************
   YOUR CODE IS TO BE FILLED IN THE GIVEN TODO BLANKS. YOU CAN CHOOSE TO USE ALL
   UTILITY FUNCTIONS OR NONE. YOU CAN ADD NEW FUNCTIONS. BUT DO NOT FORGET TO
   DECLARE THEM IN THE HEADER FILE.
**************************************************************************************
*/

/*
***********************************************************************
  FUNCTION TO FREE THE CONSTANTS-ASSOCIATED VARIABLES LIST
************************************************************************
*/
void FreeConstList()
{
   refConst* tmp;
   while (headNode != NULL)
    {
       tmp = headNode;
       headNode = headNode->next;
       free(tmp);
    }

}

/*
*************************************************************************
  FUNCTION TO ADD A CONSTANT VALUE AND THE ASSOCIATED VARIABLE TO THE LIST
**************************************************************************
*/
void UpdateConstList(char* name, long val) {
    refConst* node = malloc(sizeof(refConst));
    if (node == NULL) return;
    node->name = name;
    node->val = val;
    node->next = NULL;
    if(headNode == NULL) {
        lastNode = node;
        headNode = node;
    }
    else {
        lastNode->next = node;
        lastNode = node;
    }
}

/*
*****************************************************************************
  FUNCTION TO LOOKUP IF A CONSTANT ASSOCIATED VARIABLE IS ALREADY IN THE LIST
******************************************************************************
*/
refConst* LookupConstList(char* name) {
    refConst *node;
    node = headNode; 
    while(node!=NULL){
        if(!strcmp(name, node->name))
            return node;
        node = node->next;
    }
    return NULL;
}

/*
**********************************************************************************************************************************
 YOU CAN MAKE CHANGES/ADD AUXILLIARY FUNCTIONS BELOW THIS LINE
**********************************************************************************************************************************
*/


/*
************************************************************************************
  THIS FUNCTION IS MEANT TO UPDATE THE CONSTANT LIST WITH THE ASSOCIATED VARIABLE
  AND CONSTANT VALUE WHEN ONE IS SEEN. IT SHOULD ALSO PROPOGATE THE CONSTANTS WHEN 
  WHEN APPLICABLE. YOU CAN ADD A NEW FUNCTION IF YOU WISH TO MODULARIZE BETTER.
*************************************************************************************
*/
void TrackConst(NodeList* statements) {
       Node* node;
       while(statements != NULL) {
	    node = statements->node;
        // for each statement
        // if the statement is an assignment
        if (node->stmtCode == ASSIGN){
            // if right side is expression
            if (node->right->exprCode == CONSTANT){
                // update the constant list
                UpdateConstList(node->name, node->right->value);
                // printf("added %s %ld\n", node->name, node->right->value);
            }
        }

        statements = statements->next;
    }
}

void ReplaceConst(NodeList* statements){
    // using pairs in const list replace
    Node* node;
    refConst* temp;
    while(statements != NULL) {
        node = statements->node;
        if (node->stmtCode == ASSIGN){
            // if we have variable assignment lookup
            // print expression code
            if (node->right->opCode == FUNCTIONCALL){
                NodeList *args = node->right->arguments;
                while(args != NULL){
                    if (args->node->exprCode == VARIABLE){
                        temp = LookupConstList(args->node->name);
                        if (temp != NULL){
                            args->node->exprCode = CONSTANT;
                            args->node->value = temp->val;
                        }
                    }
                    args = args->next;
                }
            }
            if (node->right->exprCode == VARIABLE){
                temp = LookupConstList(node->right->name);
                // printf("looking up %s\n", node->right->name);
                if (temp != NULL){
                    // if found in list replace
                    node->right->exprCode = CONSTANT;
                    node->right->value = temp->val;
                }
            }
            if (node->right->exprCode == OPERATION){
                // also check for functions calls on right side


                // printf("rhs is opp\n");
                if(node->right->left != NULL){
                if (node->right->left->exprCode == VARIABLE){
                    temp = LookupConstList(node->right->left->name);
                    // printf("looking up %s\n", node->right->left->name);
                    if (temp != NULL){
                        node->right->left->exprCode = CONSTANT;
                        node->right->left->value = temp->val;
                    }
                }
                }
                // check to make sure right is not null
                if(node->right->right != NULL){
                if (node->right->right->exprCode == VARIABLE){
                    temp = LookupConstList(node->right->right->name);
                    // printf("looking up %s\n", node->right->right->name);
                    if (temp != NULL){
                        node->right->right->exprCode = CONSTANT;
                        node->right->right->value = temp->val;
                    }
                }
                }
                
                    

            }
        }
        statements = statements->next;
    }
}

bool ConstProp(NodeList* worklist) {
    while(worklist!=NULL){
        TrackConst(worklist->node->statements);
        ReplaceConst(worklist->node->statements);
        worklist = worklist->next;
    }
    return madeChange;
}

/*
**********************************************************************************************************************************
 YOU CAN MAKE CHANGES/ADD AUXILLIARY FUNCTIONS ABOVE THIS LINE
**********************************************************************************************************************************
*/

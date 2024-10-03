/*
   CONSTFOLDING.C : THIS FILE IMPLEMENTS THE CONSTANT FOLDING OPTIMIZATION
*/

#include "constfolding.h"
/*
*************************************************************************************
   YOUR CODE IS TO BE FILLED IN THE GIVEN TODO BLANKS. YOU CAN CHOOSE TO USE ALL 
   UTILITY FUNCTIONS OR NONE. YOU CAN ADD NEW FUNCTIONS. BUT DO NOT FORGET TO 
   DECLARE THEM IN THE HEADER FILE.
**************************************************************************************
*/                                                                                                          
bool madeChange;

/*
******************************************************************************************
FUNCTION TO CALCULATE THE CONSTANT EXPRESSION VALUE 
OBSERVE THAT THIS IMPLEMENTATION CONSIDERS ADDITIONAL OPTIMIZATIONS SUCH AS:
1.  IDENTITY MULTIPLY = 1 * ANY_VALUE = ANY_VALUE - AVOID MULTIPLICATION CYCLE IN THIS CASE
2.  ZERO MULTIPLY = 0 * ANY_VALUE = 0 - AVOID MULTIPLICATION CYCLE
3.  DIVIDE BY ONE = ORIGINAL_VALUE - AVOID DIVISION CYCLE
4.  SUBTRACT BY ZERO = ORIGINAL_VALUE - AVOID SUBTRACTION
5.  MULTIPLICATION BY 2 = ADDITION BY SAME VALUE [STRENGTH REDUCTION]
******************************************************************************************
*/
long CalcExprValue(Node* node)
{
     long result;
     Node *leftNode, *rightNode;
     leftNode = node->left;
     rightNode = node->right; 
     switch(node->opCode){
        // print opcode
         case MULTIPLY:
             if(leftNode->value == 1) {
                 result = rightNode->value;
             } 
             else if(rightNode->value == 1) {
                 result = leftNode->value;
             }
             else if(leftNode->value == 0 || rightNode->value == 0) {
                 result = 0;
             }
             else if(leftNode->value == 2) {
                 result = rightNode->value + rightNode->value;
             }              
             else if(rightNode->value == 2) {
                 result = leftNode->value + leftNode->value;
             }
             else {
                 result = leftNode->value * rightNode->value;
             }
             break;
         case DIVIDE:
             if(rightNode->value == 1) {
                 result = leftNode->value;
             }
             else {
                 result = leftNode->value / rightNode->value;
             }
             break;
         case ADD:
             result = leftNode->value + rightNode->value;
             break;
         case SUBTRACT:
             result = leftNode->value - rightNode->value;
             break;
         case NEGATE:
             result = -leftNode->value;
             break;
         default:
             break;
     }
     return result;
}


/*
**********************************************************************************************************************************
// YOU CAN MAKE CHANGES/ADD AUXILLIARY FUNCTIONS BELOW THIS LINE
**********************************************************************************************************************************
*/

/*
*****************************************************************************************************
THIS FUNCTION IS MEANT TO PROCESS THE CANDIDATE STATEMENTS AND PERFORM CONSTANT FOLDING 
WHEREVER APPLICABLE.
******************************************************************************************************
*/
long ConstFoldPerStatement(Node* stmtNodeRight){
    if (stmtNodeRight == NULL) {
        return -1;
    }
    long result;
    Node *right;
    Node *left;
    right = stmtNodeRight->right;
    left = stmtNodeRight->left;
    // null checks

    if (left == NULL || right == NULL){
        return -1;
    }

    if (left->exprCode == CONSTANT && right->exprCode == CONSTANT) {
        result = CalcExprValue(stmtNodeRight);
        printf("result is %ld \n", result);
        return result;
    }                                                                                              
    return -1;
}


/*
*****************************************************************************************************
THIS FUNCTION IS MEANT TO IDENTIFY THE STATEMENTS THAT ARE ACTUAL CANDIDATES FOR CONSTANT FOLDING
AND CALL THE APPROPRIATE FUNCTION FOR THE IDENTIFIED CANDIDATE'S CONSTANT FOLDING
******************************************************************************************************
*/
void ConstFoldPerFunction(Node* funcNode) {
      Node *rightNode, *leftNode, *stmtNodeRight;
      long result;
      NodeList* statements = funcNode->statements;
      while(statements != NULL) {
        if (statements->node != NULL){
          stmtNodeRight = statements->node->right;
          // check if the statement is an assignment 
          if (statements->node->stmtCode == ASSIGN) {
              // check if the right side of the assignment is an expression
              if (stmtNodeRight->type == EXPRESSION) {
                
                  // call the constant folding function
                  result = ConstFoldPerStatement(stmtNodeRight);
                  // if the result is not -1 then we can replace the expression with the constant
                  if (result != -1) {
                      // free the expression
                      free(stmtNodeRight);
                      // create a new node
                      Node* newNode = AllocateNode();
                      newNode->type = EXPRESSION;
                      newNode->exprCode = CONSTANT;
                      newNode->value = result;
                      // replace the expression with the constant
                      statements->node->right = newNode;
                      madeChange = true;
                  }

              }
          }
        }
          // then left is variable and right is the expression
          // if right is an expression 
          // if right is an operation then call exr val and replace the value
        // make sure we free

                                                                                                                                  
	    statements = statements->next;
      }
     
}



/*
**********************************************************************************************************************************
// YOU CAN MAKE CHANGES/ADD AUXILLIARY FUNCTIONS ABOVE THIS LINE
********************************************************************************************************************************
*/

/*
*****************************************************************************************************
THIS FUNCTION ENSURES THAT THE CONSTANT FOLDING OPTIMIZATION IS DONE FOR EVERY FUNCTION IN THE PROGRAM
******************************************************************************************************
*/

bool ConstantFolding(NodeList* list) {
    madeChange = false;
    size_t functionnum = 0;
    while(list != NULL) {
        printf(" on function %zu",functionnum);

        ConstFoldPerFunction(list->node);

	    list = list->next;
        functionnum++;
    }
    return madeChange;
}

/*
****************************************************************************************************************************
 END OF CONSTANT FOLDING
*****************************************************************************************************************************
*/                

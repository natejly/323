/*
***********************************************************************
  CODEGEN.C : IMPLEMENT CODE GENERATION HERE
************************************************************************
*/
#include "codegen.h"

int argCounter;
int lastUsedOffset;
char lastOffsetUsed[100];
FILE *fptr;
regInfo *regList, *regHead, *regLast;
varStoreInfo *varList, *varHead, *varLast;

/*
*************************************************************************************
   YOUR CODE IS TO BE FILLED IN THE GIVEN TODO BLANKS. YOU CAN CHOOSE TO USE ALL
   UTILITY FUNCTIONS OR NONE. YOU CAN ADD NEW FUNCTIONS. BUT DO NOT FORGET TO
   DECLARE THEM IN THE HEADER FILE.
**************************************************************************************
*/

/*
***********************************************************************
  FUNCTION TO INITIALIZE THE ASSEMBLY FILE WITH FUNCTION DETAILS
************************************************************************
*/
void InitAsm(char* funcName) {
    fprintf(fptr, "\n.globl %s", funcName);
    fprintf(fptr, "\n%s:", funcName); 

    // Init stack and base ptr
    fprintf(fptr, "\npushq %%rbp");  
    fprintf(fptr, "\nmovq %%rsp, %%rbp"); 
}

/*
***************************************************************************
   FUNCTION TO WRITE THE RETURNING CODE OF A FUNCTION IN THE ASSEMBLY FILE
****************************************************************************
*/
void RetAsm() {
    fprintf(fptr,"\npopq  %%rbp");
    fprintf(fptr, "\nretq\n");
} 

/*
***************************************************************************
  FUNCTION TO CONVERT OFFSET FROM LONG TO CHAR STRING 
****************************************************************************
*/
void LongToCharOffset() {
     lastUsedOffset = lastUsedOffset - 8;
     snprintf(lastOffsetUsed, 100,"%d", lastUsedOffset);
     strcat(lastOffsetUsed,"(%rbp)");
}

/*
***************************************************************************
  FUNCTION TO CONVERT CONSTANT VALUE TO CHAR STRING
****************************************************************************
*/
void ProcessConstant(Node* opNode) {
     char value[10];
     LongToCharOffset();
     snprintf(value, 10,"%ld", opNode->value);
     char str[100];
     snprintf(str, 100,"%d", lastUsedOffset);
     strcat(str,"(%rbp)");
     AddVarInfo("", str, opNode->value, true);
     fprintf(fptr, "\nmovq  $%s, %s", value, str);
}

/*
***************************************************************************
  FUNCTION TO SAVE VALUE IN ACCUMULATOR (RAX)
****************************************************************************
*/
void SaveValInRax(char* name) {
    char *tempReg;
    tempReg = GetNextAvailReg(true);
    if(!(strcmp(tempReg, "NoReg"))) {
        LongToCharOffset();
        fprintf(fptr, "\n movq %%rax, %s", lastOffsetUsed);
        UpdateVarInfo(name, lastOffsetUsed, INVAL, false);
        UpdateRegInfo("%rax", 1);
    }
    else {
        fprintf(fptr, "\nmovq %%rax, %s", tempReg);
        UpdateRegInfo(tempReg, 0);
        UpdateVarInfo(name, tempReg, INVAL, false);
        UpdateRegInfo("%rax", 1);
    }
}



/*
***********************************************************************
  FUNCTION TO ADD VARIABLE INFORMATION TO THE VARIABLE INFO LIST
************************************************************************
*/
void AddVarInfo(char* varName, char* location, long val, bool isConst) {
   varStoreInfo* node = malloc(sizeof(varStoreInfo));
   node->varName = varName;
   node->value = val;
   strcpy(node->location,location);
   node->isConst = isConst;
   node->next = NULL;
   node->prev = varLast;
   if(varHead==NULL) {
       varHead = node;
       varLast = node;;
       varList = node;
   } else {
       //node->prev = varLast;
       varLast->next = node;
       varLast = varLast->next;
   }
   varList = varHead;
}

/*
***********************************************************************
  FUNCTION TO FREE THE VARIABLE INFORMATION LIST
************************************************************************
*/
void FreeVarList()
{  
   varStoreInfo* tmp;
   while (varHead != NULL)
    {  
       tmp = varHead;
       varHead = varHead->next;
       free(tmp);
    }

}

/*
***********************************************************************
  FUNCTION TO LOOKUP VARIABLE INFORMATION FROM THE VARINFO LIST
************************************************************************
*/
char* LookUpVarInfo(char* name, long val) {
    varList = varLast;
    if(varList == NULL) printf("NULL varlist");
    while(varList!=NULL) {
        if(varList->isConst == true) {
            if(varList->value == val) return varList->location;
        }
        else {
            if(!strcmp(name,varList->varName)) return varList->location;
        }
        varList = varList->prev;
    }
    varList = varHead;
    return "";
}

/*
***********************************************************************
  FUNCTION TO UPDATE VARIABLE INFORMATION 
************************************************************************
*/
void UpdateVarInfo(char* varName, char* location, long val, bool isConst) {
  
   if(!(strcmp(LookUpVarInfo(varName, val), ""))) {
       AddVarInfo(varName, location, val, isConst);
   }
   else {
       varList = varHead;
       if(varList == NULL) printf("NULL varlist");
       while(varList!=NULL) {
           if(!strcmp(varList->varName,varName)) {
               varList->value = val;
               strcpy(varList->location,location);
               varList->isConst = isConst;
               break;
        }
        varList = varList->next;
       }
    }
    varList = varHead;
}

/*
***********************************************************************
  FUNCTION TO PRINT THE VARIABLE INFORMATION LIST
************************************************************************
*/
void PrintVarListInfo() {
    varList = varHead;
    if(varList == NULL) printf("NULL varlist");
    while(varList!=NULL) {
        if(!varList->isConst) {
            printf("\t %s : %s", varList->varName, varList->location);
        }
        else {
            printf("\t %ld : %s", varList->value, varList->location);
        }
        varList = varList->next;
    }
    varList = varHead;
}

/*
***********************************************************************
  FUNCTION TO ADD NEW REGISTER INFORMATION TO THE REGISTER INFO LIST
************************************************************************
*/
void AddRegInfo(char* name, int avail) {

   regInfo* node = malloc(sizeof(regInfo));
   node->regName = name;
   node->avail = avail;
   node->next = NULL; 

   if(regHead==NULL) {
       regHead = node;
       regList = node;
       regLast = node;
   } else {
       regLast->next = node;
       regLast = node;
   }
   regList = regHead;
}

/*
***********************************************************************
  FUNCTION TO FREE REGISTER INFORMATION LIST
************************************************************************
*/
void FreeRegList()
{  
   regInfo* tmp;
   while (regHead != NULL)
    {  
       tmp = regHead;
       regHead = regHead->next;
       free(tmp);
    }

}

/*
***********************************************************************
  FUNCTION TO UPDATE THE AVAILIBILITY OF REGISTERS IN THE REG INFO LIST
************************************************************************
*/
void UpdateRegInfo(char* regName, int avail) {
    while(regList!=NULL) {
        if(regName == regList->regName) {
            regList->avail = avail;
        }
        regList = regList->next;
    }
    regList = regHead;
}

/*
***********************************************************************
  FUNCTION TO RETURN THE NEXT AVAILABLE REGISTER
************************************************************************
*/
char* GetNextAvailReg(bool noAcc) {
    regList = regHead;
    if(regList == NULL) printf("NULL reglist");
    while(regList!=NULL) {
        if(regList->avail == 1) {
            if(!noAcc) return regList->regName;
            // if not rax and dont return accumulator set to true, return the other reg
            // if rax and noAcc == true, skip to next avail
            if(noAcc && strcmp(regList->regName, "%rax")) { 
                return regList->regName;
            }
        }
        regList = regList->next;
    }
    regList = regHead;
    return "NoReg";
}

/*
***********************************************************************
  FUNCTION TO DETERMINE IF ANY REGISTER APART FROM OR INCLUDING 
  THE ACCUMULATOR(RAX) IS AVAILABLE
************************************************************************
*/
int IfAvailReg(bool noAcc) {
    regList = regHead;
    if(regList == NULL) printf("NULL reglist");
    while(regList!=NULL) {
        if(regList->avail == 1) {
            // registers available
            if(!noAcc) return 1;
            if(noAcc && strcmp(regList->regName, "%rax")) {
                return 1;
            }
        }
        regList = regList->next;
    }
    regList = regHead;
    return 0;
}

/*
***********************************************************************
  FUNCTION TO DETERMINE IF A SPECIFIC REGISTER IS AVAILABLE
************************************************************************
*/
bool IsAvailReg(char* name) {
    regList = regHead;
    if(regList == NULL) printf("NULL reglist");
    while(regList!=NULL) {
        if(!strcmp(regList->regName, name)) {
           if(regList->avail == 1) {
               return true;
           } 
        }
        regList = regList->next;
    }
    regList = regHead;
    return false;
}

/*
***********************************************************************
  FUNCTION TO PRINT THE REGISTER INFORMATION
************************************************************************
*/
void PrintRegListInfo() {
    regList = regHead;
    if(regList == NULL) printf("NULL reglist");
    while(regList!=NULL) {
        printf("\t %s : %d", regList->regName, regList->avail);
        regList = regList->next;
    }
    regList = regHead;
}

/*
***********************************************************************
  FUNCTION TO CREATE THE REGISTER LIST
************************************************************************
*/
void CreateRegList() {
    // Create the initial reglist which can be used to store variables.
    // 4 general purpose registers : AX, BX, CX, DX
    // 4 special purpose : SP, BP, SI , DI. 
    // Other registers: r8, r9
    // You need to decide which registers you will add in the register list 
    // use. Can you use all of the above registers?
    AddRegInfo("%rax", 1); //ret
    AddRegInfo("%rbx", 1); // storage
    AddRegInfo("%rdi", 1); //1st arg
    AddRegInfo("%rsi", 1); //2nd arg
    AddRegInfo("%rdx", 1); //3rd arg
    AddRegInfo("%rcx", 1); //4th arg
    AddRegInfo("%r8", 1); //5th arg
    AddRegInfo("%r9", 1); //6th arg
    AddRegInfo("%rbp", 1); //base ptr
    AddRegInfo("%rsp", 1); //stack ptr



}



/*
***********************************************************************
  THIS FUNCTION IS MEANT TO PUT THE FUNCTION ARGUMENTS ON STACK
************************************************************************
*/
int PutArgumentsFromStack(NodeList* arguments) {
    argCounter = 0;
    NodeList* temp = arguments;
    // Count arguments
    while(temp != NULL) {
        argCounter++;
        temp = temp->next;
    }
    // allocate spaxe on stack for arguments by moving the stack pointer

    // Move the stack pointer to allocate space for arguments


    int i = 0; // Argument index
    NodeList* argPtr = arguments;
    while(argPtr != NULL) {
        Node* arg = argPtr->node;
            // char array with registers list
            char* regList[] = {"%rdi", "%rsi", "%rdx", "%rcx", "%r8", "%r9"};
            char* regName = regList[i];
            LongToCharOffset();               
                // Move the argument from the stack location to the register
                fprintf(fptr, "\nmovq %s, %s", regName, lastOffsetUsed);
                AddVarInfo(arg->name, lastOffsetUsed, INVAL, false);
        i++;
        argPtr = argPtr->next;
    }
    // get number of s
    return argCounter;
}



/*
*************************************************************************
  THIS FUNCTION IS MEANT TO GET THE FUNCTION ARGUMENTS FROM THE  STACK
**************************************************************************
*/
void PutArgumentsOnStack(NodeList* arguments) {
    /*
     ****************************************
              TODO : YOUR CODE HERE
     ****************************************
    */
    while(arguments!=NULL) {

        arguments = arguments->next;
    }
}

/*
 ***********************************************************************
  THIS FUNCTION IS MEANT TO PROCESS EACH CODE STATEMENT AND GENERATE 
  ASSEMBLY FOR IT. 
  TIP: YOU CAN MODULARIZE BETTER AND ADD NEW SMALLER FUNCTIONS IF YOU 
  WANT THAT CAN BE CALLED FROM HERE.
 ************************************************************************
 */  

void ProcessStatements(NodeList* statements) {
    // get number of variables that we are going to store in the stack
    //IDK IF THIS WORKS
    int varCounter = 0;
    NodeList* temp = statements;
    while(temp != NULL) {
        Node* statement = temp->node;
        // recursively check for constants and variables
        if(statement->stmtCode == ASSIGN){
            // add variable to the list
            Node* left = statement->left;
            Node* right = statement->right;
            varCounter++;

            // right is an expression
            if (right->exprCode == OPERATION){
                varCounter += 2;
            }else{
                // right is a constant
                varCounter++;
            }
        }
        
        temp = temp->next;
    }
    // move stack pointer to allocate space for variables
    fprintf(fptr, "\nsubq $%d, %%rsp", varCounter*8);

    while(statements != NULL) {
        Node* statement = statements->node;
        if (statement->stmtCode == ASSIGN){
            processAssign(statement);
    }
                statements = statements->next;
    // move stack poitner back
}
    fprintf(fptr, "\naddq $%d, %%rsp", varCounter*8);
}

/*
 ***********************************************************************
  THIS FUNCTION IS MEANT TO DO CODEGEN FOR ALL THE FUNCTIONS IN THE FILE
 ************************************************************************
*/
void Codegen(NodeList* worklist) {
    fptr = fopen("assembly.s", "w+");
    if(fptr == NULL) {
        printf("\n Could not create assembly file");
        return; 
    }

    while(worklist != NULL) {
        Node* func = worklist->node;
        InitAsm(func->name);
        PutArgumentsFromStack(func->arguments);
        ProcessStatements(func->statements);
        PrintVarListInfo();
        RetAsm();
        FreeVarList();
        // reset offset
        lastUsedOffset = 0;
        worklist = worklist->next; 
    }
    fclose(fptr);
}

/*
**********************************************************************************************************************************
 YOU CAN MAKE ADD AUXILLIARY FUNCTIONS BELOW THIS LINE. DO NOT FORGET TO DECLARE THEM IN THE HEADER
**********************************************************************************************************************************
*/
              


/*
**********************************************************************************************************************************
 YOU CAN MAKE ADD AUXILLIARY FUNCTIONS ABOVE THIS LINE. DO NOT FORGET TO DECLARE THEM IN THE HEADER
**********************************************************************************************************************************
*/


void processAssign(Node* statement) {
    Node* right = statement->right;

    // add varname to the list
    LongToCharOffset();    
    char* varloc = lastOffsetUsed;           
    AddVarInfo(statement->name, lastOffsetUsed, INVAL, false);



    if (right->exprCode == CONSTANT) {
        ProcessConstant(right);
        fprintf(fptr, "\nmovq %s, %%rax", LookUpVarInfo("", right->value));
    } else if (right->exprCode == VARIABLE) {
        char* loc = LookUpVarInfo(right->name, INVAL);
        fprintf(fptr, "\nmovq %s, %%rax", loc);
    } 
    else if (right->exprCode == OPERATION) {
        if(right->opCode == FUNCTIONCALL){
            processCall(right);
        }else{
        processOperation(right);
        }
    } 
    // then we need to save the value in rax to the variable
    fprintf(fptr, "\nmovq %%rax, %s", varloc);
}

void processCall(Node* node){
    //callq
    fprintf(fptr, "\ncallq %s", node->left->name);
}

void processOperation(Node* node){

    Node* left = node->left;
    Node* right = node->right;
    // check if either is a constant and innit 
    if (left->exprCode == CONSTANT) {
        ProcessConstant(left);
    }
    if (right->exprCode == CONSTANT) {
        ProcessConstant(right);
    } 
    // move left into rax
    if (left->exprCode == VARIABLE) {
        char* loc = LookUpVarInfo(left->name, INVAL);
        fprintf(fptr, "\nmovq %s, %%rax", loc);
    }
    //IDK IF THIS WORKS
    if (left->exprCode == CONSTANT) {
        char* loc = LookUpVarInfo("", left->value);
        fprintf(fptr, "\nmovq %s, %%rax", loc);
    }
    char* opstring = "";
    switch (node->opCode){

        case ADD:
            opstring = "addq";
            break;
        case SUBTRACT:
            opstring = "subq";
            break;
        case MULTIPLY:
            opstring = "imulq";
            break;
        case DIVIDE:
            opstring = "idivq";
            break;
        case NEGATE:
            opstring = "negq";
            break;
        case BOR:
            opstring = "orq";
            break;
        case BAND:
            opstring = "andq";
            break;
        case BXOR:
            opstring = "xorq";
            break;
        case BSHR:
            opstring = "shr";
            break;
        case BSHL:
            opstring = "shl";
            break;
    }
    if (right->exprCode == VARIABLE) {
        char* loc = LookUpVarInfo(right->name, INVAL);
        fprintf(fptr, "\n%s %s, %%rax", opstring, loc);
    } else if (right->exprCode == CONSTANT) {
        char* loc = LookUpVarInfo("", right->value);
        fprintf(fptr, "\n%s %s, %%rax", opstring, loc);
    }
            //IDK IF THIS WORKS
}

    

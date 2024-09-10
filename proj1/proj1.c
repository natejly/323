// Linked List Fuctions for Macros from 223
#include "proj1.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
// STRING FUNCTIONS
#define INITIAL_CAPACITY 1024
#define BUFFER_SIZE 1024

String make_empty_string(){
    //make string lengfth buffer size
    String string;
    string.length = 0;
    string.capacity = BUFFER_SIZE;
    string.text = (char *)malloc(BUFFER_SIZE);
    if (string.text == NULL){
        DIE("Memory allocation failed", BUFFER_SIZE);
    }
    string.text[0] = '\0';
    return string;
}

String make_string(char *str) {
    String string;
    string.length = strlen(str);
    size_t size = (string.length + 1) * sizeof(char); 
    string.text = (char *)malloc(size);
    if (string.text == NULL) {
        DIE("Memory allocation failed", size);
    }
    string.capacity = size;
    strcpy(string.text, str);
    return string;
}


void destroy_string(String *str){
    free(str->text);
    str->text = NULL;
    str->length = 0;
    str->capacity = 0;
}

void append(String *str, char *other) {
    size_t other_length = strlen(other);
    
    // Ensure there's enough capacity
    while (str->length + other_length + 1 > str->capacity) { // +1 for null terminator
        size_t new_capacity = str->capacity * 2;
        char *new_text = DOUBLE(str->text, new_capacity);
        
        if (new_text == NULL) {
            DIE("Memory allocation failed", new_capacity);
        }
        
        str->text = new_text;
        str->capacity = new_capacity;
    }

    // Append the other string to the end of the string
    memcpy(str->text + str->length, other, other_length);
    str->length += other_length;
    str->text[str->length] = '\0'; // Ensure null termination
}



void concatenate(String *str, String *other){
    // Ensure there's enough capacity
    while (str->length + other->length + 1 > str->capacity) { // +1 for null terminator
        size_t new_capacity = str->capacity * 2;
        char *new_text = DOUBLE(str->text, new_capacity);
        
        if (new_text == NULL) {
            DIE("Memory allocation failed", new_capacity);
        }
        
        str->text = new_text;
        str->capacity = new_capacity;
    }
    
    // Append the other string to the end of the string
    strcat(str->text, other->text);
    str->length += other->length;
}
void reverse_string(String *str){
    char temp;
    int half = str->length/2;
    for (size_t i = 0; i<half; i++){
        temp = str->text[i];
        str->text[i] = str->text[str->length - i - 1];
        str->text[str->length - i - 1] = temp;
    }
}

bool compare_string(String *str1, String *str2){
    // check if the length of the strings are the same
    if (str1->length != str2->length){
        return false;
    }
    // make sure contents are the same too 
    for (size_t i = 0; i<str1->length; i++){
        if (str1->text[i] != str2->text[i]){
            return false;
        }
    }
    return true;
}

void print_string(String *str){
    printf("%s", str->text);
}

size_t length_string(String *str){
    return str->length;
}

size_t capacity_string(String *str){
    return str->capacity;
}

String substring(String *str, size_t start_index, size_t end_index){
    String substr = make_empty_string();
    char temp[2];
    temp[1] = '\0';
    // Append characters one by one
    for (size_t i = start_index; i < end_index; i++) {
        temp[0] = str->text[i]; 
        append(&substr, temp);
    }

    return substr;
}

String asubstring(String *str, size_t start_index, size_t end_index){
    // check for alphanumeric substring
    String substr = make_empty_string();
    char temp[2];
    temp[1] = '\0';
    // Append characters one by one
    for (size_t i = start_index; i < end_index; i++) {
        temp[0] = str->text[i]; 
        // check if alphanumeric
        if (isalnum(temp[0])){
            append(&substr, temp);
        }else{
            DIE("Substring must be alphanumeric", 0);
        }
    }
    return substr;
}

void replace_hash(String *input, String *output, String *arg) {
    typedef enum { NORMAL, ESCAPE } State;
    State state = NORMAL;
    size_t i = 0;

    while (i < input->length) {
        char current_char = input->text[i];

        switch (state) {
            case NORMAL:
                if (current_char == '\\') {
                    state = ESCAPE;
                } else if (current_char == '#') {
                    append(output, arg->text);
                } else {
                    char temp[2] = {current_char, '\0'};
                    append(output, temp);
                }
                break;

            case ESCAPE:
                if (current_char == '\\') {
                    char temp[2] = {'\\', '\0'};
                    append(output, temp);
                } else if (current_char == '#') {
                    char temp[2] = {'#', '\0'};
                    append(output, temp);
                } else {
                    char temp[2] = {'\\', '\0'};
                    append(output, temp);
                    char non_escape[2] = {current_char, '\0'};
                    append(output, non_escape);
                }
                state = NORMAL;
                break;
        }
        i++;
    }
}

// MACRO DICTRIONARY FUNCTIONS
Macro *create_macro(char *name, char *value){
    Macro *macro = malloc(sizeof(Macro));
    if (macro == NULL){
        DIE("Memory allocation failed", sizeof(Macro));
    }
    macro->name = name;
    macro->value = value;
    macro->active = true;
    macro->next = NULL;
    return macro;
}

void macro_destroy(Macro *macro){
    free(macro->name);
    free(macro->value);
    free(macro);
}

MacroList *list_create(){
    MacroList *list = malloc(sizeof(MacroList));
    if (list == NULL){
        DIE("Memory allocation failed", sizeof(MacroList));
    }
    list->head = NULL;
    list->size = 0;
    list->capacity = INITIAL_CAPACITY;
    return list;
}

void list_destroy(MacroList *list){
    Macro *current = list->head;
    Macro *next;
    while (current != NULL){
        next = current->next;
        macro_destroy(current);
        current = next;
    }
    free(list);
}

void list_add(MacroList *list, Macro *macro){
    if (list->size == list->capacity){
        list->capacity *= 2;
        list = DOUBLE(list, list->capacity);
        if (list == NULL){
            DIE("Memory allocation failed", list->capacity);
        }
    }
    // replace the head with the new macro
    macro->next = list->head;
    list->head = macro;
    list->size++;
}

void list_print(MacroList *list){
    Macro *current = list->head;
    while (current != NULL){
        printf("Name: %s\n", current->name);
        printf("Value: %s\n", current->value);
        current = current->next;
    }
}

Macro *list_find(MacroList *list, char *name) {

    Macro *current = list->head;
    while (current != NULL) {
        if (current->name != NULL && strcmp(current->name, name) == 0) {
            return current;
        }
        current = current->next;
    }

    return NULL; 
}


void list_remove(MacroList *list, char *name){
    Macro *current = list->head;
    Macro *prev = NULL;
    while (current != NULL){
        if (strcmp(current->name, name) == 0){
            // if we are at the head
            if (prev == NULL){
                list->head = current->next;
            }
            else {
            // walk around the current node
                prev->next = current->next;
            }
            macro_destroy(current);
            list->size--;
            return;
        }
        // move the pointers
        prev = current;
        current = current->next;
    }
}

String store_input(FILE *file) {
    String temp = make_empty_string();
    char buffer[BUFFER_SIZE];
    while (fgets(buffer, BUFFER_SIZE, file) != NULL) {
        append(&temp, buffer);
    }
    return temp;
}

String process_input(int argc, char *argv[]){
        // first we will check if we have std in vs file input 
    // and then we will put it into memoru
    //if we have no args then we will read from stdin
    String temp;
    if (argc == 1){
        temp = store_input(stdin);
    }
    else {
        temp = make_empty_string();
        for (int i = 1; i<argc; i++){
            FILE *file = fopen(argv[i], "r");
            if (file == NULL){
                DIE("Could not open file %s", argv[i]);
            }
            String temp2 = store_input(file);
            append(&temp, temp2.text);
            destroy_string(&temp2);
            fclose(file);
        }
    }
    return temp;
}

void remove_comments(String* input, String* output){
    enum State {PLAIN, COMMENT, ESCAPE} 
    state = PLAIN;
    size_t i = 0;
    char temp[2];  // Buffer to hold a single character
    temp[1] = '\0';  // Null-terminate the string
    while (i < input->length){
        switch (state){
            case PLAIN:
                if (input->text[i] == '\\'){
                    state = ESCAPE;
                }
                else if (input->text[i] == '%'){
                    state = COMMENT;
                } 
                else {
                    temp[0] = input->text[i];
                    append(output, temp);
                }
                // continue reading
                break;
                
            case ESCAPE:
                // re add the escaped character
                append(output, "\\");
                temp[0] = input->text[i];
                append(output, temp);
                state = PLAIN;
                break;

            case COMMENT:
                // skip characters untill newline or end of file
                if (input->text[i] == '\n'){
                    // step
                    i++;
                    // skip spaces and tabs
                    while (input->text[i] == ' ' || input->text[i] == '\t'){
                        i++;
                    }
                    state = PLAIN;
                    continue;
                }
        }
        i++;
    }
}

void runtime(MacroList *list, String *input, String *output) {
    enum State { PLAIN, ESCAPE, NEWLINE, MACRO } 
    state = PLAIN;
    // i is the index of the input string
    size_t i = 0;
    // j is the index of the output string
    size_t j = 0;
    char temp[2];  // Buffer to hold a single character
    temp[1] = '\0';  // Null-terminate the string
    // Iterate over each character in the input string
    String middle;
    String rest;
    while (i < input->length) {
        switch (state) {
            case PLAIN:
                if (input->text[i] == '\\') {
                    state = ESCAPE;  // Switch to ESCAPE state when encountering backslash
                } else {
                    // Regular character; append to output
                    temp[0] = input->text[i];
                    append(output, temp);
                }
                break;

            case ESCAPE:
                temp[0] = input->text[i];

                if (input->text[i] == '\\' || input->text[i] == '#' || input->text[i] == '{' || input->text[i] == '}' || input->text[i] == '%') {
                    append(output, temp);
                    state = PLAIN;  
                } else if (!isalnum(temp[0])){
                    append(output, "\\");
                    state = PLAIN;
                    continue;
                } else if (input->text[i] == '\n') {
                    state = NEWLINE;  
                } else {
                    // Assume the character starts a macro
                    
                    state = MACRO;
                    continue;  
                }
                break;

            case NEWLINE:
                if (input->text[i] != '\n') {
                    state = PLAIN;
                    continue;  
                }
                break;

            case MACRO:
                // i is where macro starts
                // j is where the macro ends
                middle = make_empty_string();
                j = process_macro(list, input, &middle, i);
                if(j == -1){
                
                    append(output, input->text);
                                        return;

                }
                // the processed part is start to i
                rest = substring(input, j + 1, input->length);
                append(&middle, rest.text);
                runtime(list, &middle, output);
                // replace input with temp
                // kill strings
                destroy_string(&middle);
                destroy_string(&rest);
    
                // expand the macro into the input
                state = PLAIN;  
                return;  
        }

        // Move to the next character
        i++;
    }
}

size_t find_close_brace(String *input, size_t i) {
    int value = 1; // Initial brace level
    size_t index = i;
    
    while (value != 0) {
        index++;
        
        // Check if we are out of bounds
        if (index >= input->length) {
            DIE("Could not find closing brace", 0);
        }
        
        // Check for escape sequence
        if (input->text[index] == '\\' && index + 1 < input->length) {
            // Skip the next character if it's an escape sequence
            index++;
        }
        // Check for opening brace
        else if (input->text[index] == '{') {
            value++;
        }
        // Check for closing brace
        else if (input->text[index] == '}') {
            value--;
        }
    }
    
    return index;
}

size_t expand_custom(MacroList *list, String *input, String *output, size_t index, Macro *temp){

            size_t open_brace = index;
            size_t close_brace = find_close_brace(input, open_brace);
            String arg = substring(input, open_brace + 1, close_brace);
            // need to not use make_String
            String temp_string = make_string(temp->value);
            String replaced = make_empty_string();
            replace_hash(&temp_string, &replaced, &arg);
            // call state macyhine on replaced
            append(output, replaced.text);
            destroy_string(&arg); 
            destroy_string(&replaced);
            destroy_string(&temp_string);

            // Find and return the index of the closing brace of the macro
            return close_brace;
}

size_t expand_cond(MacroList *list, String *input, String *output, size_t index){
    size_t open_brace1 = index;
    // check that the next character is a {
    if (input->text[open_brace1] != '{'){
        DIE("Expected {", open_brace1);
    }
    size_t close_brace1 = find_close_brace(input, open_brace1);
    // find the second opening brace
    size_t open_brace2 = close_brace1 + 1;
    // check that the next character is a {
    if (input->text[open_brace2] != '{'){
        DIE("Expected {", open_brace2);
    }
    size_t close_brace2 = find_close_brace(input, open_brace2);
    // find the third opening brace
    size_t open_brace3 = close_brace2 + 1;
    // check that it is a {
    if (input->text[open_brace3] != '{'){
        DIE("Expected {", open_brace3);
    }
    size_t close_brace3 = find_close_brace(input, open_brace3);

    String arg1 = substring(input, open_brace1 + 1, close_brace1);
    String arg2 = substring(input, open_brace2 + 1, close_brace2);
    String arg3 = substring(input, open_brace3 + 1, close_brace3);
    // cond logic
    // if arg1 is in the list then we will append arg2 to the output
    // else we will append arg3 to the output
    Macro *temp = list_find(list, arg1.text);
    if (temp != NULL){
        append(output, arg2.text);
    }
    else {
        append(output, arg3.text);
    }
    destroy_string(&arg1);
    destroy_string(&arg2);
    destroy_string(&arg3);


    return close_brace3; 
}

size_t expand_if(MacroList *list, String *input, String *output, size_t index){
    size_t open_brace1 = index;
    // check that the next character is a {
    if (input->text[open_brace1] != '{'){
        DIE("Expected {", open_brace1);
    }
    size_t close_brace1 = find_close_brace(input, open_brace1);
    // find the second opening brace
    size_t open_brace2 = close_brace1 + 1;
    // check that the next character is a {
    if (input->text[open_brace2] != '{'){
        DIE("Expected {", open_brace2);
    }
    size_t close_brace2 = find_close_brace(input, open_brace2);
    // find the third opening brace
    size_t open_brace3 = close_brace2 + 1;
    // check that it is a {
    if (input->text[open_brace3] != '{'){
        DIE("Expected {", open_brace3);
    }
    size_t close_brace3 = find_close_brace(input, open_brace3);

    String arg1 = substring(input, open_brace1 + 1, close_brace1);
    String arg2 = substring(input, open_brace2 + 1, close_brace2);
    String arg3 = substring(input, open_brace3 + 1, close_brace3);
    // cond logic
    // if arg 1 is empty string then we will append arg2 to the output
    // else we will append arg3 to the output
    if (arg1.length == 0){
        append(output, arg3.text);
    }
    else {
        append(output, arg2.text);
    }

    destroy_string(&arg1);
    destroy_string(&arg2);
    destroy_string(&arg3);


    return close_brace3; 
}

size_t expand_inc(MacroList *list, String *input, String *output, size_t index){
            // injects contents of file into output
            // find open brace and close brace
            size_t open_brace = index;
            size_t close_brace = find_close_brace(input, open_brace);
            // find the file name
            String file_name = substring(input, open_brace + 1, close_brace);
            FILE *file = fopen(file_name.text, "r");
            if (file == NULL){
                DIE("Could not open file %s", file_name.text);
            }
            String file_contents = store_input(file);
            append(output, file_contents.text);
            destroy_string(&file_contents);
            destroy_string(&file_name);
            fclose(file);
            return close_brace;
}
//The point of this macro is to delay expanding the before argument until the after argument has been expanded. The output of this macro expansion is simply BEFORE immediately followed by the expanded AFTER. Note that this changes the recursive evaluation rule, i.e. you should eagerly expand all macros in the AFTER string before touching BEFORE. This means that any new macros defined in AFTER should be in scope for the BEFORE. You may not use additional processes/threads to accomplish these actions. Here’s an example program:
size_t expand_ea(MacroList *list, String *input, String *output, size_t index){
    size_t open_brace = index;
    size_t close_brace = find_close_brace(input, open_brace);
    // find the before and after strings
    String before = substring(input, open_brace + 1, close_brace);
    // find the after string
    size_t open_brace2 = close_brace + 1;
    // check that the next character is a {
    if (input->text[open_brace2] != '{'){
        DIE("Expected {", open_brace2);
    }
    size_t close_brace2 = find_close_brace(input, open_brace2);
    String after = substring(input, open_brace2 + 1, close_brace2);
    // expand the after string
    String temp = make_empty_string();
    runtime(list, &after, &temp);
    // append the before and after strings to the output
    append(output, before.text);
    append(output, temp.text);
    destroy_string(&before);
    destroy_string(&after);
    destroy_string(&temp);
    return close_brace2;
}

int process_macro(MacroList *list, String *input, String *output, size_t i) {
    enum Macro_State { DEF, UNDEF, IFDEF, IF, INC, EA, CUS };  // Define macro states
    Macro *temp;
    // Locate where the macro name ends (find the opening brace '{')
    size_t index = i;
    while (input->text[index] != '{' && input->text[index] != '\0') {
        index++;
    }
    // Check for end of string to avoid out-of-bounds access


    // Extract the macro type name between i and index
    Macro *check;
    if (input->text[index] == '\0') {
        String test = substring(input, i, index-1);
        print_string(&test);
        check = list_find(list, test.text);
        if (check != NULL){
            DIE("Macro not found", i);
        }else{
            return -1;
        }



    }
    String macro_type = substring(input, i, index);


    // Map the macro type string to a Macro_State enum value
    enum Macro_State state;
    if (strcmp(macro_type.text, "def") == 0) {
        state = DEF;
    } else if (strcmp(macro_type.text, "undef") == 0) {
        state = UNDEF;
    } else if (strcmp(macro_type.text, "ifdef") == 0) {
        state = IFDEF;
    } else if (strcmp(macro_type.text, "if") == 0) {
        state = IF;
    } else if (strcmp(macro_type.text, "include") == 0) {
        state = INC;
    } else if (strcmp(macro_type.text, "expandafter") == 0) {
        state = EA;
    } else {
        state = CUS;  // Assume any unrecognized macro is a custom macro
    }

    // Switch statement based on the mapped Macro_State
    switch (state) {
        case DEF:
            destroy_string(&macro_type);
            return add_def(list, input, index);  // Handles 'def' macro addition

        case UNDEF:
            destroy_string(&macro_type);
            return remove_def(list, input, index);  // Handles 'undef' macro removal

        case IFDEF:
            destroy_string(&macro_type);
            // should have 3 pairs of brackets
            // find the first closing brace
            return expand_cond(list, input, output, index); 

        case IF:
            destroy_string(&macro_type);
            return expand_if(list, input, output, index);
        case INC:
            destroy_string(&macro_type);
            return expand_inc(list, input, output, index);  

        case EA:
            destroy_string(&macro_type);
            return expand_ea(list, input, output, index);  


        case CUS:
            temp = list_find(list, macro_type.text);
            if (temp == NULL) {
                DIE("Macro not found", i);
            }
            destroy_string(&macro_type);
            return expand_custom(list, input, output, index, temp);  
        default:
            destroy_string(&macro_type);
            DIE("Unhandled macro state", i);
    }
    return index;
}

size_t add_def(MacroList *list, String *input, size_t index){
    size_t open_brace1 = index;
    // check that the next character is a {
    if (input->text[open_brace1] != '{'){
        DIE("Expected {", open_brace1);
    }
    size_t close_brace1 = find_close_brace(input, open_brace1);
    size_t open_brace2 = close_brace1 + 1;
    // check that the next character is a {
    if (input->text[open_brace2] != '{'){
        DIE("Expected {", open_brace2);
    }
    size_t close_brace2 = find_close_brace(input, open_brace2);
    // find the macro name
    String macro_name = asubstring(input, index + 1, close_brace1);
    // find the macro value
    String macro_value = substring(input, open_brace2 + 1, close_brace2);
    // check that name is alphanumeric
    // check if macro is already in lsit
    if (list_find(list, macro_name.text) != NULL){
        return index;
    }
    // add macro
    Macro *macro = create_macro(macro_name.text, macro_value.text);
    list_add(list, macro);
    return close_brace2;
}

size_t remove_def(MacroList *list, String *input, size_t index){
        size_t open_brace1 = index;
        size_t close_brace1 = find_close_brace(input, open_brace1);
        // find the macro name
        String macro_name = substring(input, index + 1, close_brace1);
        // print the macro name
        // remove the macro
        list_remove(list, macro_name.text);
        destroy_string(&macro_name);
        return close_brace1;
}

int main(int argc, char *argv[]) {
    String input = process_input(argc, argv);
    String output = make_empty_string();
    String comments_removed = make_empty_string();
    remove_comments(&input, &comments_removed);
    MacroList *list = list_create();
    runtime(list, &comments_removed, &output);
    print_string(&output);    
    destroy_string(&output);
    destroy_string(&input);
    destroy_string(&comments_removed);
    list_destroy(list);
    // want to test replace_hash
    // String input = make_string("Hello #world");
    // String output = make_empty_string();
    // String arg = make_string("world");
    // replace_hash(&input, &output, &arg);
    // print_string(&output);
    return 0;
}

// Linked List Fuctions for Macros from 223
#include "proj1.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
// STRING FUNCTIONS
#define INITIAL_CAPACITY 16 
#define BUFFER_SIZE 16

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
    strcat(str->text, other);
    str->length += other_length;
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

void replace_hash(String *input, String *output, String *arg){
    size_t i = 0;
    while (i < input->length){
        if (input->text[i] == '#'){
            // append the arg
            append(output, arg->text);  

        }
        else {
            char temp[2];
            temp[0] = input->text[i];
            temp[1] = '\0';
            append(output, temp);
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
    size_t i = 0;
    char temp[2];  // Buffer to hold a single character
    temp[1] = '\0';  // Null-terminate the string

    // Iterate over each character in the input string
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
                if (input->text[i] == '\\' || input->text[i] == '#' || input->text[i] == '{' || input->text[i] == '}') {
                    temp[0] = input->text[i];
                    append(output, temp);
                    state = PLAIN;  
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
                i = process_macro(list, input, output, i);
                state = PLAIN;  
                break;  
        }

        // Move to the next character
        i++;
    }
}

size_t find_close_brace(String *input, size_t i){
    int value = 1;
    size_t index = i;
    while (value != 0){
        index++;
        // if we are out of bounds
        if (index >= input->length){
            DIE("Could not find closing brace", 0);
        }
        if (input->text[index] == '{'){
            value++;
        }
        else if (input->text[index] == '}'){
            value--;
        }

    }

    return index;
}

size_t process_macro(MacroList *list, String *input, String *output, size_t i) {
    enum Macro_State { DEF, UNDEF, COND, INC, EA, CUS };  // Define macro states

    // Locate where the macro name ends (find the opening brace '{')
    size_t index = i;
    while (input->text[index] != '{' && input->text[index] != '\0') {
        index++;
    }
    // Check for end of string to avoid out-of-bounds access
    if (input->text[index] == '\0') {
        DIE("Unexpected end of input while looking for '{'", index);
    }

    // Extract the macro type name between i and index
    String macro_type = substring(input, i, index);

    // Map the macro type string to a Macro_State enum value
    enum Macro_State state;
    if (strcmp(macro_type.text, "def") == 0) {
        state = DEF;
    } else if (strcmp(macro_type.text, "undef") == 0) {
        state = UNDEF;
    } else if (strcmp(macro_type.text, "cond") == 0) {
        state = COND;
    } else if (strcmp(macro_type.text, "inc") == 0) {
        state = INC;
    } else if (strcmp(macro_type.text, "ea") == 0) {
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

        case COND:
            destroy_string(&macro_type);
            return find_close_brace(input, index);  // Skips 'cond' section

        case INC:
            destroy_string(&macro_type);
            return find_close_brace(input, index);  // Handles 'inc'

        case EA:
            destroy_string(&macro_type);
            return find_close_brace(input, index);  // Handles 'ea'

        case CUS:

            // Print macro type for debugging purposes
            printf("Macro type: %s\n", macro_type.text);
            list_print(list);

            // Handling a custom macro: look it up in the macro list
            Macro *temp = list_find(list, macro_type.text);
            if (temp == NULL) {
                DIE("Macro not found", i);
            }
            destroy_string(&macro_type);


            // Append the macro value to the output and continue processing
            // replace hash
            size_t open_brace = index;
            size_t close_brace = find_close_brace(input, open_brace);
            String arg = substring(input, open_brace + 1, close_brace);
            printf("Arg: %s\n", arg.text);
            // need to not use make_String
            String temp_string = make_string(temp->value);
            String replaced = make_empty_string();
            replace_hash(&temp_string, &replaced, &arg);
            append(output, replaced.text);
            destroy_string(&arg);
            destroy_string(&macro_type);
            destroy_string(&replaced);
            destroy_string(&temp_string);

            // Find and return the index of the closing brace of the macro
            return find_close_brace(input, index);

        default:
            // Handle unexpected states, if necessary
            destroy_string(&macro_type);
            DIE("Unhandled macro state", i);
    }

    // Should never reach here; add fallback if necessary
    return index;
}



size_t add_def(MacroList *list, String *input, size_t index){
    size_t open_brace1 = index;
        size_t close_brace1 = find_close_brace(input, open_brace1);
        size_t open_brace2 = close_brace1 + 1;
        size_t close_brace2 = find_close_brace(input, open_brace2);
        // find the macro name
        String macro_name = substring(input, index + 1, close_brace1);
        // find the macro value
        String macro_value = substring(input, open_brace2 + 1, close_brace2);
        // print the macro name and value
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

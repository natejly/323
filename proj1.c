// Linked List Fuctions for Macros from 223
#include "proj1.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
// STRING FUNCTIONS
#define INITIAL_CAPACITY 16 
#define BUFFER_SIZE 2

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

String make_string(char *str){
    String string;
    string.length = strlen(str);
    size_t size = string.length*sizeof(char);
    string.text = (char *)malloc(size);
    if (string.text == NULL){
        DIE("Memory allocation failed", size);
    }
    string.capacity = size + 1;
    strcpy(string.text, str);
    return string;
}

void destroy_string(String *str){
    free(str->text);
    str->text = NULL;
    str->length = 0;
    str->capacity = 0;
}

void append_to_string(String *str, char *other) {
    size_t other_length = strlen(other);
    
    // Ensure there's enough capacity
    while (str->length + other_length + 1 > str->capacity) { // +1 for null terminator
        printf("Doubling the capacity of the string\n");
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
        append_to_string(&substr, temp);
    }

    return substr;
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
        printf("%s %s\n", current->name, current->value);
        current = current->next;
    }
}

Macro *list_find(MacroList *list, char *name){
    Macro *current = list->head;
    while (current != NULL){
        if (strcmp(current->name, name) == 0){
            printf("Found the macro %s\n", name);
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
        append_to_string(&temp, buffer);
    }
    return temp;
}

String process_input(int argc, char *argv[]){
        // first we will check if we have std in vs file input 
    // and then we will put it into memoru
    //if we have no args then we will read from stdin
    String temp = make_empty_string();
    if (argc == 1){
        temp = store_input(stdin);
    }
    else {
        for (int i = 1; i<argc; i++){
            FILE *file = fopen(argv[i], "r");
            if (file == NULL){
                DIE("Could not open file %s", argv[i]);
            }
            String temp2 = store_input(file);
            append_to_string(&temp, temp2.text);
            destroy_string(&temp2);
            fclose(file);
        }
    }
    return temp;
}

void run_state_machine(MacroList *list, String *input){
    enum State state = PLAIN;
    size_t i = 0;
    while (i < input->length){
        switch (state){
            case PLAIN:
                if (input->text[i] == '\\'){
                    state = MACRO;
                }
                break;
            case MACRO:
            printf("Found a macro\n");
            process_macro(list, input, i);
            state = PLAIN;
                break;
            case COMMENT:
                break;
            case ESCAPE:
                break;
            case NEWLINE:
                break;
        }
        i++;
    }
}
size_t find_close_brace(String *input, size_t i){
    int value = 1;
    size_t index = i;
    while (value != 0){
        index++;
        printf("on character %c\n", input->text[index]);
        if (input->text[index] == '{'){
            value++;
        }
        else if (input->text[index] == '}'){
            value--;
        }

    }

    return index;
}

void process_macro(MacroList *list, String *input, size_t i){
    // find the macro name which is between the \ and the next {
    size_t index = i;
    while (input->text[index] != '{'){
        index++;
    }
    // print i and index
    String macro_type = substring(input, i, index);
    // if we have a def macro 
    if (strcmp(macro_type.text, "def") == 0){
        printf("Found a def macro\n");
        // index is at open brace
        size_t open_brace1 = index;
        size_t close_brace1 = find_close_brace(input, open_brace1);

        size_t open_brace2 = close_brace1 + 1;
        size_t close_brace2 = find_close_brace(input, open_brace2);
        // find the macro name
        String macro_name = substring(input, index + 1, close_brace1);
        // find the macro value
        String macro_value = substring(input, open_brace2 + 1, close_brace2);

        // print the macro name and value
        print_string(&macro_name);
        print_string(&macro_value);
        // add macro
        Macro *macro = create_macro(macro_name.text, macro_value.text);
        list_add(list, macro);
        // open brace is at close brace + 1
        // size_t open_brace2 = close_brace1 + 1;
        // size_t close_brace2 = find_close_brace(&input, open_brace2);
        // find the macro name


    // create a string for the macro name
    
}
}
int main(int argc, char *argv[]) {

    String input = process_input(argc, argv);
    String output = make_empty_string();
    MacroList *list = list_create();
    // test subsrting

    run_state_machine(list, &input);
    return 0;
}
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

void delete_macro(MacroList *list, char *name){
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

int main(int argc, char *argv[]) {
    // first we will check if we have std in vs file input 
    // and then we will put it into memoru
    //if we have no args then we will read from stdin
    String input = make_empty_string();
    if (argc == 1){
        input = store_input(stdin);
    }
    // else we open all the files and append them to the string
    else {
        for (int i = 1; i<argc; i++){
            FILE *file = fopen(argv[i], "r");
            if (file == NULL){
                DIE("Could not open file %s", argv[i]);
            }
            String temp = store_input(file);
            append_to_string(&input, temp.text);
            destroy_string(&temp);
            fclose(file);
        }
    }
    MacroList *list = list_create();
    Macro *macro = create_macro("NAME", "VALUE");
    list_add(list, macro);
    Macro *macro2 = create_macro("NAME2", "VALUE2");
    list_add(list, macro2);

    list_print(list);
    Macro *temp = list_find(list, "NAME");
    if (temp != NULL){
        printf("has value %s\n", temp->value);
    }
    print_string(&input);
    list_destroy(list);
    return 0;
}
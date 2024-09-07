// proj1.h                                          Stan Eisenstat (09/17/15)
//
// System header files and macros for proj1

#define _GNU_SOURCE
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

// Write message to stderr using format FORMAT
#define WARN(format,...) fprintf (stderr, "proj1: " format "\n", __VA_ARGS__)

// Write message to stderr using format FORMAT and exit.
#define DIE(format,...)  WARN(format,__VA_ARGS__), exit (EXIT_FAILURE)

// Double the size of an allocated block PTR with NMEMB members and update
// NMEMB accordingly.  (NMEMB is only the size in bytes if PTR is a char *.)
#define DOUBLE(ptr,nmemb) realloc (ptr, (nmemb *= 2) * sizeof(*ptr))


typedef struct {
    size_t length;
    size_t capacity;
    char *text;
} String;

typedef struct {
    char *name;
    char *value;
    bool active;
    struct Macro *next;
} Macro;
// linked list to store the macros
typedef struct {
    Macro *head;
    size_t size;
    size_t capacity;
} MacroList;

enum State {PLAIN, MACRO, COMMENT, ESCAPE, NEWLINE};
// READING FUNCTIONS
String store_input(FILE *file);
String process_input(int argc, char *argv[]);
// STRING FUNCTIONS
String make_empty_string();
String make_string(char *str);
void destroy_string(String *str);
String duplicate_string(String *str);
void append_to_string(String *str, char *other);
void prepend_string(String *str, char *other);
void print_string(String *str);
size_t length_string(String*str);
void reverse_string(String *str);   
bool compare_string(String *str1, String *str2);
String substring(String *str, size_t start_index, size_t end_index);

// MACRO LIST FUNCTIONS
MacroList *list_create();
void list_destroy(MacroList *list);
Macro *create_macro(char *name, char *value);
void macro_destroy(Macro *macro);
void list_add(MacroList *list, Macro *macro);
void list_print(MacroList *list);
void deactivate_macro(Macro *macro);
void list_remove(MacroList *list, char *name);
Macro *list_find(MacroList *list, char *name);

// STATE MACHINE FUNCTIONS
void run_state_machine(MacroList *list, String *input);
void process_macro(MacroList *list, String *input, size_t i);
size_t find_close_brace(String *input, size_t i);


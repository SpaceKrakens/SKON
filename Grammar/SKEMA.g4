/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

grammar SKEMA;

skema
    : meta* (entry SEPARATOR)*
    ;

// FIXME!! Do proper handling for this
meta
    : METADELIMIT KEY DEFINE '1.0' METADELIMIT
    ;

reference
    : REF KEY
    ;

entry
    : (REQ | OPT) KEY DEFINE (type_def | reference)
    | DEF KEY DEFINE type_def
    ;

// Any simple value, ie terminals
simple_type_def
    : STRING
    | INTEGER 
    | DOUBLE 
    | BOOLEAN 
    | DATETIME
    ;

// Any complex value, ie values containing values
complex_type_def
    : map
    | array
    ;

map
    : OPEN_MAP (entry SEPARATOR)* CLOSE_MAP
    ;

array
    : OPEN_ARRAY type_def? CLOSE_ARRAY
    ;

// Any value
type_def
   : simple_type_def
   | complex_type_def
   ;

REF: '#';

DEF: 'def';
REQ: 'req';
OPT: 'opt';

METADELIMIT
    : '~'
    ;

// Open and closing brackets for maps
OPEN_MAP: '{';
CLOSE_MAP: '}';

// Open and closing brackets for arrays
OPEN_ARRAY: '[';
CLOSE_ARRAY: ']';

// Array and map separator
SEPARATOR: ',';

// Key-value separator
DEFINE: ':';

STRING: 'string';

DOUBLE: 'double';

INTEGER: 'int';

BOOLEAN: 'bool';

DATETIME: 'dateTime';

KEY
    : [a-zA-Z]CHAR*
    ;

// Any character
fragment CHAR
    : [a-zA-Z0-9_]
    ;

// Single line comments
COMMENT
    : '//' ~( '\r' | '\n' )* -> skip
    ;

// Multiline comments
ML_COMMENT
  :  '/*' .*? '*/' -> skip
  ;

// Any whitespace
WS
   : [ \t\n\r] + -> skip
   ;
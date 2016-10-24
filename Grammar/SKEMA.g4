/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

grammar SKEMA;

skema
    : meta* (entry SEPARATOR)*
    ;

meta
    : METADELIMIT KEY DEFINE simple_value METADELIMIT
    ;

// Any simple value, ie terminals
simple_value
    : (STRING_VAL | DATETIME_VAL | INTEGER_VAL | FLOAT_VAL | TRUE | FALSE)
    ;

entry
    : OPT? 
    (KEY DEFINE (type_def | REF)
    | DEF KEY DEFINE type_def)
    ;

// Any simple value, ie terminals
simple_type_def
    : ANY
    | STRING
    | INTEGER 
    | FLOAT 
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
    : OPEN_ARRAY (type_def | REF) CLOSE_ARRAY
    ;

// Any value
type_def
   : simple_type_def
   | complex_type_def
   ;

// True and false is here to get mached before KEY
TRUE: 'true';
FALSE: 'false';

REF: '#'[a-zA-Z]CHAR*;

DEF: 'def';
REQ: 'req';
OPT: 'optional';

METADELIMIT
    : '~'
    ;

// Any string contained in '"' with support for escaping
STRING_VAL
   : '"' (ESC | ~ ["\\])* '"'
   ;

// The different escape characters
fragment ESC
   : '\\' (["\\/bfnrt] | UNICODE)
   ;

// The unicode escape
fragment UNICODE
   : 'u' HEX HEX HEX HEX
   ;

// Any hex number
fragment HEX
   : [0-9a-fA-F]
   ;

// Any FLOAT number
FLOAT_VAL
   : '-'? INT '.' [0-9] + EXP? | '-'? INT EXP | '-'? INT
   ;

// Any Integer value
INTEGER_VAL
    : '-'? INT
    ;

// A non negative Integer with no leading zeros
fragment INT
   : '0' | INTNOZERO
   ;

// A non negative Integer (excluding zero) with no leading zeros
fragment INTNOZERO
   : [1-9] [0-9]*
   ;

// FLOAT exponent part
fragment EXP
   : [Ee] [+\-]? INT
   ;

// A '@' followed by a unix timestamp
DATETIME_VAL
    : '@' (INTNOZERO 
    | YEAR '-' MONTH '-' DAY 
    | HOUR ':' MINUTE ':' SECOND ZULU 
    | HOUR ':' MINUTE ':' SECOND '.' DIGIT* ZULU
    | HOUR ':' MINUTE ':' SECOND ('+'|'-') HOUR ':' MINUTE
    | HOUR ':' MINUTE ':' SECOND '.' DIGIT* ('+'|'-') HOUR ':' MINUTE
    | YEAR '-' MONTH '-' DAY 'T' HOUR ':' MINUTE ':' SECOND ZULU 
    | YEAR '-' MONTH '-' DAY 'T' HOUR ':' MINUTE ':' SECOND '.' DIGIT* ZULU
    | YEAR '-' MONTH '-' DAY 'T' HOUR ':' MINUTE ':' SECOND ('+'|'-') HOUR ':' MINUTE
    | YEAR '-' MONTH '-' DAY 'T' HOUR ':' MINUTE ':' SECOND '.' DIGIT* ('+'|'-') HOUR ':' MINUTE)
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

ANY: 'Any';

STRING: 'String';

FLOAT: 'Float';

INTEGER: 'Integer';

BOOLEAN: 'Boolean';

DATETIME: 'DateTime';

KEY
    : [a-zA-Z]CHAR*
    ;

// Any character
fragment CHAR
    : [a-zA-Z0-9_]
    ;

fragment YEAR
    : DIGIT DIGIT DIGIT DIGIT
    ;

fragment MONTH
    : DIGIT DIGIT
    ;

fragment DAY
    : DIGIT DIGIT
    ;

fragment HOUR
    : DIGIT DIGIT
    ;

fragment MINUTE
    : DIGIT DIGIT
    ;

fragment SECOND
    : DIGIT DIGIT
    ;

fragment ZULU
   : [Zz]
   ;

// A single Integer digit
fragment DIGIT
   : [0-9]
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
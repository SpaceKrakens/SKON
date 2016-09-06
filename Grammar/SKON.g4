grammar SKON;

// The root of a file is already a map so no need for the brackets
skon
   : open_map
   ;

// A map without the surrounding '{' '}'
open_map
    : pair (SEPARATOR pair)* (SEPARATOR)?
    ;

// A map that expects any number of key-value pairs separated by commas
map
   : OPEN_MAP open_map CLOSE_MAP
   | OPEN_MAP CLOSE_MAP
   ;

// A pair that expects a key, a ':' and a value.
pair
   : KEY DEFINE value
   ;

// A array without the surrounding '[' ']'
open_array
    :   value (SEPARATOR value)* (SEPARATOR)?
    ;

// An array that expects any number of values separated by commas
array
   : OPEN_ARRAY open_array CLOSE_ARRAY
   | OPEN_ARRAY CLOSE_ARRAY
   ;

// Any simple value, ie terminals
simple_value
    : (STRING | DATETIME | INTEGER | FLOAT | TRUE | FALSE)
    ;

// Any complex value, ie values containing values
complex_value
    : map
    | array
    ;


// Any value
value
   : simple_value
   | complex_value
   ;

// A '@' followed by a unix timestamp
DATETIME
    : '@' INTNOZERO 
    | YEAR '-' MONTH '-' DAY 
    | HOUR ':' MINUTE ':' SECOND ZULU 
    | HOUR ':' MINUTE ':' SECOND '.' DIGIT* ZULU
    | HOUR ':' MINUTE ':' SECOND ('+'|'-') HOUR ':' MINUTE
    | HOUR ':' MINUTE ':' SECOND '.' DIGIT* ('+'|'-') HOUR ':' MINUTE
    | YEAR '-' MONTH '-' DAY 'T' HOUR ':' MINUTE ':' SECOND ZULU 
    | YEAR '-' MONTH '-' DAY 'T' HOUR ':' MINUTE ':' SECOND '.' DIGIT* ZULU
    | YEAR '-' MONTH '-' DAY 'T' HOUR ':' MINUTE ':' SECOND ('+'|'-') HOUR ':' MINUTE
    | YEAR '-' MONTH '-' DAY 'T' HOUR ':' MINUTE ':' SECOND '.' DIGIT* ('+'|'-') HOUR ':' MINUTE
    ;

// True and false is before to get mached before KEY
TRUE: 'true';
FALSE: 'false';

// Any number of characters

KEY
    : [a-zA-Z]CHAR+
    ;

// Any character
fragment CHAR
    : [a-zA-Z0-9_]
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

// Any string contained in '"' with support for escaping
STRING
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

// Any Float number
FLOAT
   : '-'? INT '.' [0-9] + EXP? | '-'? INT EXP | '-'? INT
   ;

// Any Integer value
INTEGER
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

// A single Integer digit
fragment DIGIT
   : [0-9]
   ;

// Float exponent part
fragment EXP
   : [Ee] [+\-]? INT
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

# SKON

This is the specification for language version 1 of SKON.

SKON or Space Kraken Object Notation is a data serialization language designed to be easy to understand and write. 
It works well for everythng where JSON is normally used to and where XML is normally misused.

SKON is meant to store data. It's not a markup language nor is it a overly complex subset of a bigger language. 
It's a simple concise easily read and written language to store data in.

## Encoding

SKON is written in `UTF-8` and that is the only encoding a parser needs to support.

## Grammar

If the words in this section does not make sense, you dont have to worry about this section.

SKON is designed as a context free language. This means that it's possible to parse SKON really effectivly using an `LL(1)` parser.
The official grammar is defined as a ANTLR4 combined grammar, though a `ALL(*)` parser as ANTLR4 uses is not necessary to parse SKON any `LL(1)` parser should work.

## Data types

In SKON there are eight data types, five "Simple" data types and "Complex" data types.

The following is a list of all of the different data types and the some notes regarding them.

### Simple

- #### String
- #### Integer
- #### Double
- #### Boolean
- #### DateTime

### Complex

- #### Array
- #### Map

## Syntax

### String

String are double quoted. Unicode characters and other control character can be escaped with a `\`.
The escapable contraoll characters are:

- b - Backspace
- n - New line
- f - Form feed
- r - Carrige return
- t - Tab
- " - Double quote
- \ - Backslash

#### Examples
- `"This is a normal string"`
- `"This is an escaped string \n \"Quote inside of string\""`

Unicode escapes are written with a `\u` followed by four hexadecimal numbers.

#### Example

- `"Unicode character: \u36A0"`

### Integer

Integers are written as a normal integer number with no spaces.

#### Exampes

- `1234`
- `10`
- `-2147483648`

### Double

Doubles can be written in 

#### Boolean
#### DateTime
#### Array
#### Map



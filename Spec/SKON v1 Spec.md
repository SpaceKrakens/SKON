# SKON

This is the specification for language version 1 of SKON.

SKON or Space Kraken Object Notation is a data serialization language designed to be easy to understand and write. 
It works well for everythng where JSON is normally used to and where XML is normally misused.

SKON is meant to store data. It's not a markup language nor is it a overly complex subset of a bigger language. 
It's a simple concise easily read and written language to store data in.

## Table of contents

- [Encoding](#Encoding) 
- [Grammar](#Grammar) 
- [Data Types](#DataTypes) 
  - [Simple Data Types](#Simple)
  - [Complex Data Types](#Complex)
- [Syntax](#Syntax)
  - [String](#String)
  - [Integer](#Integer)
  - [Decimal](#Decimal)
  - [Boolean](#Boolean)
  - [DateTime](#DateTime)
  - [Array](#Array)
  - [Map](#Map)

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

- String
- Integer
- Decimal
- Boolean
- DateTime

### Complex

- Array
- Map

## Syntax

### String

String are double quoted. Unicode characters and other control character can be escaped with a `\`.
The escapable control characters are:

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

Integer values **should** use a 32-bit integer.

Integers are written as a normal integer number with no spaces

#### Exampes

- `1234`
- `10`
- `-2147483648`

But they can also be represented in Hexadecimal using the following prefix `0x`.

#### Examples

- `0xFFFF`
- `0xA`
- `0x7FFFFFFF`

### Decimal

Decimal values **should** be 64-bit floating point.

Decimal values can be written as two integers separated with a dot.

#### Examples

- `0.12`
- `0.00000000001`
- `1000.10001`

They can also we written using E notation using either an upper case or lower case `Ee`

#### Exampes

- `314E-2`
- `1.234e1000`
- `0.1E1`

### Boolean

Booleans in SKON are written as either `true` or `false` only lower case.

#### Exampes

- `true`
- `false`


##### NOT VALID:

- `TRUE`
- `False`

### DateTime

DateTimes **should** be able to represent any date or time. And not be limited to only Unix-time.



### Array
### Map



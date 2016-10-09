# SKON

This is the specification for language version 1 of SKON.

SKON, short for *Space Kraken Object Notation* is a data serialization language designed to be easy to understand and write. 
It works well for everything where JSON is normally used to and where XML is normally misused.

SKON is meant to store data. It's not a markup language nor is it a overly complex superset of a bigger language. 
It is a simple, concise, easily read and written language to store data in.

## Table of contents

- [Terminology](#terminology)
- [Encoding](#encoding) 
- [Grammar](#grammar) 
- [Data Types](#dataTypes) 
  - [Simple Data Types](#simple)
  - [Complex Data Types](#complex)
- [Syntax](#syntax)
  - [String](#string-1)
  - [Integer](#integer-1)
  - [Decimal](#decimal-1)
  - [Boolean](#boolean-1)
  - [DateTime](#dateTime-1)
  - [Array](#array-1)
  - [Map](#map-1)

## Terminology

This section contains definitions for a few words that will be used in the document.

- **could** is used when a parser could optionally support the directions, but in a general sense should be considered not supported.

- **should** is used when there could be reasons for a parser to not follow the directions, this is a very strong recommendation and should be assumed to be supported in a general sense. If the parser does not follow these directives it should advertise this clearly!

- **needs** is used when the parser is required to follow the directives to conform to this standard.

## Encoding

SKON is written in `UTF-8` and that is the only encoding a parser **needs** to support. A parser **could** support other encodings but should not be expected to.

## Grammar

If the words in this section do not make sense to you, you dont have to worry about this section.

SKON is designed as a context free language. This means that it's possible to parse SKON effectivly using an `LL(1)` parser.
The official grammar is defined as a ANTLR4 combined grammar, though an `ALL(*)` parser as ANTLR4 uses is not necessary to parse SKON, any `LL(1)` parser should work.

## Data types

In SKON there are eight data types, five "Simple" data types and two "Complex" data types.

The following is a list of all of the different data types and the some notes regarding them.

### Simple

- #### String

  The length of a string **should** not be limited.

- #### Integer

  Integer values **should** be 64-bit.

- #### Decimal

  Decimal values **should** be 64-bit floating point.

- #### Boolean
- #### DateTime

  DateTimes **should** be able to represent any date or time and not be limited to only Unix-time.
  
  DateTimes that only specify time of day **should** assume "today" as the date.
  


### Complex

- #### Array
  
  The number of elements in an array **should** not be limited in any way, though it is recommended to keep that number reasonable in respects to memory usage, file size and parsing times. 

  Arrays **should** also not be limited to just one data type. If limiting the data in an array is needed, it is recommended to validate the SKON with a [SKEMA](#) definition, as SKEMA allows for limiting of data types in an array.

- #### Map

  Like with arrays the number of key-value pairs **should** not be limited in any way, but when writing SKON it is recommended to keep the number of elements reasonable.

## Syntax

Every value in SKON **should** end with a comma, even if it is the last element in an array or a map. This is to keep the grammar context-free.

This will be reflected in the syntax examples below.

### String
---

String values are double quoted. Unicode characters and other control character can be escaped with a `\`.
The escapable control characters are:

- b - Backspace
- n - New line
- f - Form feed
- r - Carrige return
- t - Tab
- " - Double quote
- \ - Backslash

#### Examples
- `"This is a normal string",`
- `"This is an escaped string \n \"Quote inside of string\"",`

Unicode escapes are written with a `\u` followed by four hexadecimal numbers.

#### Example

- `"Unicode character: \u36A0",`

### Integer
---

Integers are written as a normal integer number with no spaces

#### Exampes

- `1234,`
- `10,`
- `-2147483648,`

But they can also be represented in Hexadecimal using the following prefix `0x`.

#### Examples

- `0xFFFF,`
- `0xA,`
- `0x7FFFFFFF,`

### Decimal
---

Decimal values can be written as two integers separated with a dot.

#### Examples

- `0.12,`
- `0.00000000001,`
- `1000.10001,`

They can also we written using scientific notation using either an upper case or lower case `Ee`

#### Examples

- `314E-2,`
- `1.234e1000,`
- `0.1E1,`

### Boolean
---

Booleans in SKON are written as either `true` or `false` in only lower case.

#### Examples

- `true,`
- `false,`


##### NOT VALID:

- `TRUE,`
- `False,`

### DateTime
---

There are numerous ways to write date and time in SKON, most of which are based upon [RFC 3339/ISO 8601](https://tools.ietf.org/html/rfc3339#section-5.6). Additionally to this standard, SKON supports UNIX Timestamps.

All DateTimes are prefixed with a `@`.

A unix timestamp is written as any signed 64-bit number.

That means that `@-9223372036854775808,` is the smallest unix timestamp and `@9223372036854775807,` is the biggest possible timestamp.

Other numbers like `@-9223372036854775810,` or `@9223372036854775809,` are not valid!

The other DateTime formats **should** not be limited to Unix time only and can represent any date supported by  

### Array
---

Arrays are written as a list of values all followed by a comma surrounded by two `[` `]` brackets.

#### Examples

- `[ "String", "array", ],`
- `[ 123, 456, ],`

### Map
---

Maps are a written as a collection of key-value pairs, all followed by a comma and surrounded by two `{` `}` braces. Keys are written as any letter `A-Za-z` followed by any number of the following characters `A-Za-z0-9_` ending with a `:`.

#### Examples

- `Key:`
- `This_Is_A_Key:`

#### The following examples are invalid!

- `1234:`
- `::`
- `./spec/SKON v1 Spec.md:`
- `S p a c e s: `



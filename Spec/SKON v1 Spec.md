# SKON

This is the specification for language version 1 of SKON.

SKON or Space Kraken Object Notation is a data serialization language designed to be easy to understand and write. 
It works well for everythng where JSON is normally used to and where XML is normally misused.

SKON is meant to store data. It's not a markup language nor is it a overly complex subset of a bigger language. 
It's a simple concise easily read and written language to store data in.

## Table of contents
---

- [Terminology](#terminology)
- [Encoding](#encoding) 
- [Grammar](#grammar) 
- [Data Types](#dataTypes) 
  - [Simple Data Types](#simple)
  - [Complex Data Types](#complex)
- [Syntax](#syntax)
  - [String](#string)
  - [Integer](#integer)
  - [Decimal](#decimal)
  - [Boolean](#boolean)
  - [DateTime](#dateTime)
  - [Array](#array)
  - [Map](#map)

## Terminology
---

This section contains definitions for a few words that will be used in the document.

- **could** is used when a parser could optionally support the directions, but in a general sense should considered not supported.

- **should** is used when there could be reasons for a parser to not follow the directions, this is a very strong recomendataion and should be assumed are supported in a general sense. If the parser does not follow these directives it should advertice this clearly!

- **needs** is useed when the parser is required to follow directions to conform to this standard.

## Encoding
---

SKON is written in `UTF-8` and that is the only encoding a parser **needs** to support.

## Grammar
---

If the words in this section does not make sense, you dont have to worry about this section.

SKON is designed as a context free language. This means that it's possible to parse SKON really effectivly using an `LL(1)` parser.
The official grammar is defined as a ANTLR4 combined grammar, though a `ALL(*)` parser as ANTLR4 uses is not necessary to parse SKON any `LL(1)` parser should work.

## Data types
---

In SKON there are eight data types, five "Simple" data types and "Complex" data types.

The following is a list of all of the different data types and the some notes regarding them.

### Simple

- #### String

  The length of a string **should** not be limited.

- #### Integer

  Integer values **should** use a 32-bit integer.

- #### Decimal

  Decimal values **should** be 64-bit floating point.

- #### Boolean
- #### DateTime

  DateTimes **should** be able to represent any date or time. And not be limited to only Unix-time.
  
  DateTimes that only specify time of day **should** assume "today" as the date.
  
  


### Complex

- Array
  
  The number of elements in an arrays **should** not be limited in any way, though a it's recomended to keep that number resonable in respects to memory usage, file size and parsing times. 

  Arrays **should** also not be limited to just one data type. If limiting the data in an array is needed it's recomended to validate the SKON with a [SKEMA](#) definition, as SKEMA allows for limiting of data types in an array.

- Map

  Like with arrays the number of key-value pairs **should** not be limited in any way, but when writing SKON it's recomended to keep the number of elements reasonable.

## Syntax
---

Every value in SKON **should** end with a comma. Even if it's the last element in an array or a map. This will be reflected in the syntax examples below.

### String
---

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

They can also we written using E notation using either an upper case or lower case `Ee`

#### Examples

- `314E-2,`
- `1.234e1000,`
- `0.1E1,`

### Boolean
---

Booleans in SKON are written as either `true` or `false` only lower case.

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

A unix timestamp is written as any unsigned 64-bit number.

That means that `@0,` is the smallest unix timestamp and `@18446744073709551616,` is the biggest possible timestamp.

Other numbers like `@-123,` or `@18446744073709551617,` are not valid!

The other DateTime formats **should** not be limited to Unix time only and can represent any date supported by  

### Array
---

Arrays are written as a list of values all followed by a comma surrounded by two `[` `]` parenthesies.

#### Examples

- `[ "String", "array", ],`
- `[ 123, 456, ],`

### Map
---

Maps are a written as key-value pairs. Keys are written as any letter `A-Za-z` followed by any number of the following letters `A-Za-z0-9_` ending with a `:`.

#### Examples

- `Key:`
- `This_Is_A_Key:`

#### The following examples are invalid!

- `1234:`
- `::`
- `./spec/SKON v1 Spec.md:`
- `S p a c e s: `



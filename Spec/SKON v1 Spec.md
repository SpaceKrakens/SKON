# SKON

This is the specification for language version 1 of SKON.

SKON, short for *Space Kraken Object Notation* is a data serialization language designed to be easy to understand and write. 
It works well for everything where JSON is normally used to and where XML is normally misused.

SKON is meant to store data. It's not a markup language nor is it a clunky subset of a bigger language. Neither is it an overly complex superset of that subset. 
It is a simple, concise, easily read and written language to store data in.

## Table of contents

- [Terminology](#terminology)
- [Encoding](#encoding) 
- [Grammar](#grammar) 
- [SKEMA](#skema)
- [Data Types](#data-types) 
  - [Simple Data Types](#simple)
  - [Complex Data Types](#complex)
- [Syntax](#syntax)
  - [Comments](#comments)
  - [Metadata](#metadata)
  - [Null](#null)
  - [String](#string-1)
  - [Integer](#integer-1)
  - [Float](#float-1)
  - [Boolean](#boolean-1)
  - [DateTime](#datetime-1)
  - [Array](#array-1)
  - [Map](#map-1)
- [File Format](#file-format)

## Terminology

This section contains definitions for a few words that will be used in the document.

- **could** is used when a parser could optionally support the directions, but in a general sense should be considered not supported.

- **should** is used when there could be reasons for a parser to not follow the specification, **should** is a strong recommendation and should be assumed to be supported in a general sense. If a parser does not follow these directives it should advertise this clearly!

- **needs** is used when the parser is required to follow the directives to conform to the SKON specification.

## Encoding

SKON is written in `UTF-8` and that is the only encoding a parser **needs** to support. A parser **could** support other encodings but should not be expected to.

## Grammar

This section is only important for people interested in making a parser for SKON.

SKON is designed as a context free language. This means that it's possible to parse SKON effectivly using an `LL(1)` parser.
The official grammar is defined as a ANTLR4 combined grammar, though an `ALL(*)` parser as ANTLR4 uses is not necessary to parse SKON, any `LL(1)` parser should work.

The official grammar can be found [here](../Grammar/SKON.g4).

## SKEMA

SKON is paired with it's own schema language SKEMA which can be read more about [here](./SKEMA%20v1%20Spec.md).

A parser **should** support SKEMA validation.

## Data types

In SKON there are eight data types, five "Simple" data types and two "Complex" data types.

The following is a list of all of the different data types and the some notes regarding them.

### Simple

- #### String

  The length of a string **should** not be limited.

- #### Integer

  Integer values **should** be 64-bit.

- #### Float

  Float values **should** be 64-bit floating point.

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

  If there are multiple key-value pairs with the same key the earlier values are overwritten.

## Syntax

Every value in SKON **should** end with a comma, even if it is the last element in an array or a map. This is to keep the grammar context-free.
This will be reflected in the syntax examples below.

Every SKON file **should** be considered an implicit map without the surrounding `{` `}`.

### Comments
---

SKON supports two types of comments. Single line comments using `//` and multi line comments using `/* comment */` syntax.

Single line `//` comments end at a newline, while multi-line `/* ... */` comments end at the first `*/`. Nested comments are therefore not supported.

#### Examples

- `// Single line comment`
- `/* Multi-line comment on one line */`

Multi-line example.

```
/*
  Actual 
  multi-line
  comment.
*/
```

### Metadata
---

Metadata in SKON provide the parser and user with various information about the document.
All metadata should be at the top of a SKON file.

Metadata entries are surrounded by `~` chracters on both sides and contain a key-value pair.

There are two metadata directives a parser **needs** to support. 
These are as follows:

- `Version` which is followed by an integer. This is the SKON language version.
- `DocumentVersion` which is followed by any datatype. This is used in applictaion to filter versions of a file.

A `Version` metadata directive is required at the top of every file.

If the parser supports SKEMA it **should** support the `SKEMA` directive which is followed by a string that locates the SKEMA file.

A parser **could** support custom metadata, but to keep compatability it **should** not force these to be present.

#### Example

This is an example of a valid metadata header for a SKON file.

```c
~Version: 1~
~DocumentVersion: "1.1"~
~SKEMA: "./DocumentSKEMA.skema"~

// SKON data...
```

### Null
---

A null value in SKON is simply written as `null` all lower case. 

#### Example

- `null`

##### NOT VALID

- `NULL`
- `Null`

### String
---

String values are double quoted. Unicode characters and other control characters can be escaped with a `\`.
The escapable control characters are:

- `b` - Backspace
- `n` - New line
- `f` - Form feed
- `r` - Carrige return
- `t` - Tab
- `"` - Double quote
- `\` - Backslash

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

But they can also be represented in Hexadecimal using the prefix `0x`.

#### Examples

- `0xFFFF,`
- `0xA,`
- `0x7FFFFFFF,`

### Float
---

Float values can be written as two integers separated by a dot.

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

All DateTimes are prefixed with an `@` character.

A unix timestamp is written as any signed 64-bit integer.

That means that `@-9223372036854775808,` is the smallest unix timestamp and `@9223372036854775807,` is the biggest possible timestamp.

Other numbers like `@-9223372036854775810,` or `@9223372036854775809,` are not valid!

The other DateTime formats **should** not be limited to Unix time only and can represent any date supported by the syntax.

A DateTime can be represented using the following format `yyyy-MM-dd` where `yyyy` is the year, `MM` is the month and `dd` is the day. Written as integers.

#### Examples

- `@2016-10-09,`
- `@1136-11-15,`

DateTimes can also be represented as a time of day using the following syntax, `HH:mm:ss` or `HH:mm:ss.sfrac` followed by a UTC time zone offset written as either `Z` for no offset or `+/-HH:mm` for the appropriate UTC offset.

In this format `HH` is hours, `mm` is minutes and `ss` is seconds. 
Additionally `sfrac` is a fraction of a second expressed with any precision. 
A parser **should** be able to parse any number of `sfrac` digits, though it is only expected to have 3 digit `sfrac` (milisecond) precision but a parser **could** have greater precision.

#### Examples

- `@12:00:00Z,`
- `@16:30:20.345-03:30,`
- `@12:34:56.789Z,`
- `@00:00:00.000+10:15,`

Date and Time can be written together written as any date and any time separated with a `T`.

#### Examples

- `@2310-12-01T13:37:01.002+09:00,`
- `@2310-12-01T13:37:01.02Z,`
- `@2310-12-01T13:37:01Z,`

### Array
---

Arrays are written as a list of values all followed by a comma surrounded by two `[` `]` brackets.

#### Examples

- `[ "String", "array", ],`
- `[ 123, 456, ],`
- `[ "Mixed", 1.23, "Array", true, ],`

### Map
---

Maps are a written as a collection of key-value pairs, all followed by a comma and surrounded by two `{` `}` braces.

Keys are written as any letter `A-Za-z_` followed by any number of the following characters `A-Za-z0-9_` ending with a `:`.

#### Examples

- `Key:`
- `This_Is_A_Key:`
- `_AnotherKey:`

#### The following examples are invalid!

- `1234:`
- `::`
- `./spec/SKON v1 Spec.md:`
- `S p a c e s: `

The values can be any data type and are written after the `:` of the key.

#### Example

```c
{
  KeyToString: "String value",
  KeyToInt: 1,
  KeyToFloat: 1.2,
  KeyToBool: true,
  KeyToDateTime: @2016-10-09,
  KeyToArray: [ "String", 1, 1.2, true, @2016-10-09, ],
  KeyToMap:
  {
    KeyToString: "String inside nested map",
  },
},
```

## File Format

The filename extension for SKON files is `.skon`.

In SKON, a file is implicitly considered to be a map, that means that every value in a SKON file must be a key-value pair.

To store the data in the previous example as a valid SKON file you could either wrap everything in a surrounding map.

`KeyToMap: { ... }`

Or preferably write every element as a key-value pair without the surrounding map.

```c
~Version: 1~

KeyToString: "String value",
KeyToInt: 1,
KeyToFloat: 1.2,
KeyToBool: true,
KeyToDateTime: @2016-10-09,
KeyToArray: [ "String", 1, 1.2, true, @2016-10-09, ],
KeyToMap:
{
  KeyToString: "String inside nested map",
},
```

# SKEMA

SKEMA (sensational spelling for schema) is the schema language for [SKON](./SKON%20v1%20Spec.md). 

SKEMA aims to be the best schema language to back SKON up.
Its focus should be to complement SKON in the best way possible while still retaining most of SKONs simplicity.

It's only meant to describe a SKON file and nothing else.

## Table of contents

- [Terminology](#terminology)
- [Encoding](#encoding) 
- [Grammar](#grammar)
- [Syntax](#syntax)
  - [Metadata](#metadata)
  - [Type](#type)
  - [Array](#array)
  - [Map](#map)
  - [Optional](#optional)
  - [Definitions](#definitions)
  - [References](#references)
- [Reference solving](#reference-solving)
- [File Format](#file-format)

## Terminology

This section contains definitions for a few words that will be used in the document.

- **could** is used when a parser could optionally support the directions, but in a general sense should be considered not supported.

- **should** is used when there could be reasons for a parser to not follow the specification, **should** is a strong recommendation and should be assumed to be supported in a general sense. If a parser does not follow these directives it should advertise this clearly!

- **needs** is used when the parser is required to follow the directives to conform to the SKEMA specification.

## Encoding

SKEMA is written in `UTF-8` and that is the only encoding a parser **needs** to support. A parser **could** support other encodings but is not be expected to.

## Grammar

This section is only important for people interested in making a parser for SKEMA.

SKEMA is designed as a context free language. This means that it's possible to parse SKON effectivly using an `LL(1)` parser.
The official grammar is defined as a ANTLR4 combined grammar, though an `ALL(*)` parser as ANTLR4 uses is not necessary to parse SKEMA, any `LL(1)` parser should work.

The official grammar can be found [here](../Grammar/SKEMA.g4).

## Syntax

The syntax rules that apply to SKON also applies to SKEMA.
Every value **needs** an ending comma and a file **should** be a implicit map.

### Metadata
---

SKEMA uses the same metadata format as SKON, seen [here](./SKON%20v1%20Spec.md#metadata).

This means that SKEMA requires parsing of both SKEMA objects aswell as SKON data.

All metadata **needs** to be at the top of a SKEMA file.

Metadata entries are surrounded by `~` chracters on both sides and contain a key-value pair.

There are two metadata directives that are always mandatory.
Those are as follows:

- `Version` which is followed by an integer. This is the SKEMA language version.
- `DocumentVersion` which is followed by a string. This is used in applications to filter versions of a file.

A parser **could** support custom metadata, but to keep compatability it **should** not force these to be present.

#### Example

This is an example of a valid metadata header for a SKEMA file.

```c
~Version: 1~
~DocumentVersion: "1.1"~

// SKON data...
```

### Type
---

This is the main functionality of SKEMA. These are used to represent the simple data types in SKON.

The valid types are as follows:

- `Any`:
  Matches any SKON data type.
- `String`:
  Matches the String data type.
- `Integer`:
  Matches the Integer data type.
- `Float`:
  Matches the Float data type.
- `Boolean`:
  Matches the boolean data type.
- `DateTime`:
  Matches the DateTime data type.

It's worth noting that because Type is a data type it should be followed by a comma.

#### Examples:

- `String,`
- `DateTime,`
- `Any,`
- `Integer,`

### Array
---

An array is a complex type in SKEMA and describes a SKON array specified to only contain one data type.

This data type is not limited to the simple type [Type](#type) but can also be another array or [Map](#map).

An array is written as a [Type](#type) enclosed in `[ ... ]` brackets.

#### Examples:

- `[ String ],`
- `[ [ Integer ] ],`
- `[ { Key: Any, } ],`

### Map
---

A map is a complex type in SKEMA that describes a SKON map, what keys and type of data those keys should have.

A map is written as Key-Value pairs where the key represents the expected SKON key and the value is a data type.

The data type is not restricted to [Type](#type) and can contain other Maps and [Arrays](#arrays) too.

#### Examples

- `{ Key: Any, },`
- `{ AnotherKey: String, KeyToInt: Integer, },`

### Optional
---

An element of a Map can be defined to be optional by writing 'optional' before the key.

#### Example

```scala
// This element is optional
optional Key: String,
// while this element is required
AnotherKey: Integer,
```

### Definitions
---

A definition is used to store and reuse common data structures in multiple places.

To define a data structure you just need to write `define` before a key in a Map.

The definition is not considered a part of the SKEMA and should be stored separate for reference solving when the SKEMA has been parsed.
This is illustrated in the example below: the definition of `MapDef` would not contain a key to `AnotherDef`. 
Additionally defitions are always in file scope so the `AnotherDef` definition would be usable anywhere in the file.

If there are multiple definitions for the same name the last definition from top to bottom is used.

Any data type can be defined.

#### Examples

- `define StringDef: String,`
- `define ArrayDef: [ Integer ],`

```scala
define MapDef:
{
  define AnotherDef: [ Integer ],
  Key: Float,
},
```

### References
---

References are used to refer to and use definitions.

A reference is written as a `#` followed by the name of the defined data structure.

#### Example

```scala
define Person:
{
  FirstName: String,
  LastName: String,
  optional Nickname: String,
},

People: [ #Person ],
```

## Reference solving

A parser **should** support definitions and references.

The references **should** be solved after the whole document has been parsed,
 by first making sure there are no [strongly connected components](https://en.wikipedia.org/wiki/Strongly_connected_component) in the definition graph and then substituting all references with their matching definition.

If there are any strongly connected components the SKEMA has recursing definitions and cannot be resolved!

When defining a strongly connected component `optional` elements should not be considered edges, this allows for semi-recursive SKEMAs to be written like this:

```scala
define Node: 
{
  Value: Any,
  optional Nodes: [ #Node ],
},

Tree: #Node,
```

## File format

The filename extension for SKEMA is `.skema`.

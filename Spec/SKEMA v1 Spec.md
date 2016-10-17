# SKEMA

SKEMA (sensational spelling for schema) is the schema language for [SKON](./SKON-v1-Spec.md). 

It's meant to be a fully featured schema language for SKON while still conforming to the fundamental ideas behind SKON, simple, concise, easily read and written language.

It's only meant to describe a SKON file and nothing else.

## Table of contents

- [Terminology](#terminology)
- [Encoding](#encoding) 
- [Grammar](#grammar) 
- [Data Types](#dataTypes)
- [Syntax](#syntax)

## Terminology

This section contains definitions for a few words that will be used in the document.

- **could** is used when a parser could optionally support the directions, but in a general sense should be considered not supported.

- **should** is used when there could be reasons for a parser to not follow the specification, **should** is a strong recommendation and should be assumed to be supported in a general sense. If a parser does not follow these directives it should advertise this clearly!

- **needs** is used when the parser is required to follow the directives to conform to the SKEMA specification.

## Encoding

SKEMA is written in `UTF-8` and that is the only encoding a parser **needs** to support. A parser **could** support other encodings but should not be expected to.

## Grammar

This section is only important for people interested in making a parser for SKEMA.

SKEMA is designed as a context free language. This means that it's possible to parse SKON effectivly using an `LL(1)` parser.
The official grammar is defined as a ANTLR4 combined grammar, though an `ALL(*)` parser as ANTLR4 uses is not necessary to parse SKEMA, any `LL(1)` parser should work.

The official grammar can be found [here](../Grammar/SKEMA.g4).

## Syntax



### Metadata
---

SKEMA uses the same metadata format as SKON, seen [here](./SKON%20v1%20Spec.md#metadata).

This means that SKEMA requires parsing of both SKEMA objects aswell as SKON data. 
The abillity to parse SKON objects is not only used for metadata in SKEMA, it's also used when parsing [specifiers]().

All metadata should be at the top of a SKEMA file.

Metadata entries are surrounded by `~` chracters on both sides and contain a key-value pair.

There are two metadata directives a parser **needs** to support. 
These are as follows:

- `Version` which is followed by an integer. This is the SKEMA language version.
- `DocumentVersion` which is followed by any datatype. This is used in applictaion to filter versions of a file.

A `Version` metadata directive is required at the top of every file.

A parser **could** support custom metadata, but to keep compatability it **should** not force these to be present.

#### Example

This is an example of a valid metadata header for a SKEMA file.

```c
~Version: 1~
~DocumentVersion: "1.1"~

// SKON data...
```
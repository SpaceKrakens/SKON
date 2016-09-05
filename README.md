# SKON
Space Kraken Object Notation

Is a language originally created to accommodate the data format language need for [Project Porcupine](https://github.com/TeamPorcupine/ProjectPorcupine).

Its main focus is besting all other object notation languages. No more need for 90% filler in xml or the unreadable `"`s in Json.

It's also notable that it has a schema. So you don't have to just blindly trust the user. :octopus:

## Example

The following is an example showing the syntax of the language:

```
//SKON supports comments!

// This is a map, it can contain every type of data type.
Map: {

    // This is a key value pair. The type is inferred from the syntax of the value (This is a string)
    KeyValuePair: "Value",

    DifferentTypes: 1.1,

    // This is a nested map.
    NestedMap: {
        WhateverValue: 0.0,
        AnotherValue: "This is a value"
    },

    // This is an array, type is inferred from the first element
    TestArray: [
        "Test",
        "asdf"
    ]
},

// This is an empty map
OtherMap: {
    /*
    This language
    has support
    for multiline
    comments! :D
    */
}
```

## Schema

The language also supports schemas. Here is an example of a schema for the above SKON:

```
// Schemas supports comments!

// This specifies that a map called "RootMap" needs to exist in the file
required RootMap: {
    
    // This specifies that a KeyValue pair called "KeyValuePair" needs to exist and be of type string
    required KeyValuePair: string,

    // This specifies that a KeyValue pair called "DifferentTypes" of type float could be defined.
    optional DifferentTypes: float,

    // An empty schema map means that anything is allowed
    required NestedMap: { },

    // This means that an array of strings called "TestArray" needs to be defined
    required TestArray: [string]

},

// A optional map of anything
optional OtherMap: { }
```
## Language specifications

### Types

The language has a few built in types data types that allows for complex data to be represented.

The built in types are: 

* String
* Integer
* Float
* Boolean
* Datetime
* Array
* Map

### Syntax

In SKON all simple data is represented in plain text with no additional syntax (except for strings which are surrounded with double quotes).

Here are a few examples:

* `0` is a Integer.
* `"example"` is a String.
* `0.2` is a Float.
* `true` is a Boolean.

There are two data types that are considered complex:

* Arrays
* Maps

#### Arrays

Arrays are written as data surrounded by square parenthesises with every entry separated by a comma.

The data type of an array in inferred by the first entry's type. Even arrays of arrays or maps are possible, should the need for complex arrays arise.

```
[
    "This",
    "is",
    "an",
    "array",
    "of",
    "strings"
]
```

#### Maps

A map is written as any number of key value pairs separated by a comma surrounded in curly braces.

A key value pair is written as such:

`key: value`

Where the key is plain text and the value is any datatype.

So a map would then look like this:

```
{
    key1: value1,
    key2: value2
}
```

Every file In SKON is a map, so all elements in root has to be a key value pair.

This is what a file containing a string and map would look like:

```
Name: "SomeName",

Map: {

    SomeKey: "SomeValue"

}
```

#### Datetime

There are numerous ways to write date and time in SKON, most of which are based upon [RFC 3339/ISO 8601](https://tools.ietf.org/html/rfc3339#section-5.6). Additionally to this standard, SKON supports UNIX Timestamps.

```
DateTimes: 
[
    @1,                                 // These two values are valid UNIX Timestamps.
    @1473113744,
    
    2310-12-01,                         // Just the date in the YYYY-MM-DD format.
    
    2310-12-01T13:37:01Z,               // Date and additionally time in the HH:MM:SSZ format.
                                        // Z stands for Zulu and means no difference from UTC.
                                        // Date and time are always separated by a T (for time).
    
    2310-12-01T13:37:01.02Z,            // Date and additionally time in the HH:MM:SS.SECFRACZ format.
                                        // SECFRAC is a fraction of a second. Technically SKON gives
                                        // you no limit but we advise to stay reasonable.
    
    2310-12-01T13:37:01+09:00,          // To specify a different offset than UTC+0, substitute Z with
                                        // either +HH:MM or -HH:MM.
    
    2310-12-01T13:37:01.002+09:00,      // This obviously also works with fractions of seconds.
    
    13:37:01Z,                          // You can also write times alone by obmitting the date
    13:37:01.02Z,                       // part and the date/time separator T.
    13:37:01+09:00,                     // All four different formats for times are supported.
    13:37:01.002+09:00,
],
```

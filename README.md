# SKON
Space Kraken Object Notation - https://github.com/SpaceKrakens/SKON

Is a language originally created to accommodate the data format language need for [Project Porcupine](https://github.com/TeamPorcupine/ProjectPorcupine).

Its main focus is besting all other object notation languages. No more need for 90% filler in xml or the unreadable `"`s in Json.

It's also notable that it has a schema. So you don't have to just blindly trust the user. :octopus:

## Example

The following is an example showing the syntax of the language:

```c
//SKON supports comments!
/* and multiline ones too! :D */

~Version: 1~ // This is the SKON version header.

// Every SKON file is considered a map so everything is stored in key-value pairs.

// This is a value in the root map. The key is "RootKey" and it stores a string value "RootValue".
RootKey: "RootValue",

// This is a map inside the root map, it stores data in key-value pairs.
MapKey: {

    StringKey: "StringValue", // N.B.! In SKON every key value ends with a comma!! Even if it's the last one!!

    // SKON has support for different data types!
    IntKey: 1,
    DoubleKey: 1.1,
    BoolKey: true,
    DateTimeKey: @2016-10-05, //N.B. You can read more about DateTimes in SKON below!

    // In addition to maps SKON also has arrays!
    StringArrayKey: [ "This", "is", "a", "string", "array!", ], // N.B. Note the comma after the last string!

    // And of course nested maps in maps work, as expected!
    NestedMap:
    {
        ANestedValueKey: "This is a nested value",
    },
},
```

## SKEMA

The schema language for SKON is called SKEMA. The following is an example of a SKEMA file and a maching SKON file.

```scala
~Version: 1~

// SKEMA also supports comments!

// Defines a structure "Color" containing a string "Name" and int "Color"
def Color:
{
    Name: string,
    Color: int,
},

// Defines that an array called Colors needs to exits with greater than zero elements
// and that the all the elements most conform to the Color definition.
Colors: [ #Color ] (greater [0]),
```

A quick SKON file that is valid for this SKEMA could look like this:

```c
~Version: 1~
~SKEMA: "./Colors.skema"~

Colors:
[
    { Name: "Red", Color: 0xFF0000, },
    { Name: "Green", Color: 0x00FF00, },
    { Name: "Blue", Color: 0x0000FF, },
],
```

## Language specifications

### Types

The language has a eight built in data types that allows data to be easily represented.

The built in types are devided into two categories, Simple types and Complex types.

The following is a list of the eight types in their respective category.

#### Simple types:

* String
* Integer
* Double
* Boolean
* Datetime

#### Complex types:
* Array
* Map

### Syntax

In SKON most simple data is represented in plain text with no additional syntax.

The exceptions to this is Strings, witch are quoted and DateTimes wich start with an `@`.

Here are a few examples:

* `0` is an Integer.
* `"example"` is a String.
* `0.2` is a Double.
* `true` is a Boolean.
* `@2016-01-01` is a DateTime



The two complex types just enclose data with either braces or brackets.

#### Arrays

Arrays are written as data surrounded by brackets with every entry separated by a comma.

An array can contain any data type if not otherwise stated in a SKEMA.

```
[
    "This",
    "is",
    "an",
    "array",
    "of",
    "strings",
],
```

#### Maps

A map is written as any number of key value pairs followed by a comma surrounded in curly braces.

A key value pair is written as such:

`key: value`

Where the key is plain text and the value is any data type.

So a map would then look like this:

```
{
    Key1: value1,
    Key2: value2,
},
```

Every file In SKON is a map, so all elements in root has to be a key value pair.

This is what a file containing a string and map would look like:

```
Name: "SomeName",

Map: {

    SomeKey: "SomeValue",
},
```

### Datetimes

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

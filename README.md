# SKON
Space Kraken Object Notation

Is a language originally created to accomidate the data format language need for [Project Porcupine](https://github.com/TeamPorcupine/ProjectPorcupine).

It's main focus is besting all other object notation languages. No more need for 90% filler in xml or the unreadable `"`s in Json.

It's also notable that it has a schema. So you don't have to just blindly trust the user. :smile:

#Example

The following is an example showing the syntax of the language

```
//This is a map, it can contain every type of data type.
RootMap: {

    //This is a key value pair. The type is inferred from the syntax of the value (This is a string)
    KeyValuePair: "Value" 

    DifferentTypes: 1.1 //Comment example

    //This is a nestled map.
    NestledMap: {
        WhateverValue: 0.0,
        AnotherValue: "This is a value"
    }

    //This is an array, type is inferred from the first element
    TestArray: [
        "Test",
        "asdf"
    ]
}

//This is an empty map
OtherMap: {
    /*
    This language
    has support
    for multiline
    comments! :D
    */
}
```

##Schema

The language also supports schemas. Here is an example of a schema for the above SKON:

```
//Schemas supports comments!

//This specifies that a map called "RootMap" needs to exist in the file
required RootMap: {
    
    //This specifies that a KeyValue pair called "KeyValuePair" needs to exist and be of type string
    required KeyValuePair: string

    //This specifies that a KeyValue pair called "DifferentTypes" of type float could be defined.
    optional DifferentTypes: float

    //An empty schema map means that anything is allowed
    required NestledMap: { }

    //This means that an array of strings called "TestArray" needs to be defined
    required TestArray: [string]

}

//A optional map of anything
optional OtherMap: { }
```

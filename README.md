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
required RootMap: {
    
    required KeyValuePair: string

    optional DifferentTypes: float

    //An empty schema map means that anything is allowed
    required NestledMap: { }

    required TestArray: [string]

}

optional OtherMap: { }
```

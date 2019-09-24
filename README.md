Lisp MOTD Server
================

This package depends on the runtime provided in the [aws-lambda-lisp-runtime][runtime] repository.

[runtime]: https://github.com/nklein/aws-lambda-lisp-runtime

Supported Methods
-----------------

All methods take JSON input and produce JSON output.

### GetMessages

The `GetMessages` function takes the following input:
    {
      "category": <string>,
      "since": <number>
    }

The method returns all items in the given `category` which have been modified since the unix timestamp given in `since`.

The returned data is an array of items of the form:
    {
      "GUID": <string>,
      "Category": <string>,
      "CreatedAt": <number>,
      "UpdateAt": <number>,
      "ExpiresAt": <number>,
      "Translations": {
         <langCode>: <string>,
         <langCode>: <string>,
         ...
      },
      "Tags": {
         <string>,
         <string>,
         ...
      }
    }

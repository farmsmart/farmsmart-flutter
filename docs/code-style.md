# Code Style guide

We will be following these rules in order to have a consistent code base with the same style.

### **Architecture**

The architecture approach we took in this project is to use **Redux** as the main architecture to follow to separate all the app layers.

## Enum

When we have a variable that can take different states, we will use an *Enum* over integers

Here's an example, of using constants vs Enum values for defining complexity:

```
const easy = 0;
const medium = 1;
const advanced = 2;
```
Instead of using that different integers to define these states, we should use:
```
enum Complexity { 
    easy, 
    medium, 
    advanced 
}
```
## Using Trailing commas

Flutter code often involves building fairly deep tree-shaped data structures, for example in a build method. To get good automatic formatting, we recommend you adopt the optional trailing commas. The guideline for adding a trailing comma is simple: Always add a trailing comma at the end of a parameter list in functions, methods, and constructors where you care about keeping the formatting you crafted. This helps the automatic formatter to insert an appropriate amount of line breaks for Flutter-style code.

[Trailing commas reference](https://flutter.dev/docs/development/tools/formatting#using-trailing-commas)

## Code format

Before pushing and merging changes made in the code, we should run before the auto format, that can be run executing ***dartfmt*** (*dartfmt* can be found right-clicking in the code window and then select ***Reformat Code with dartfmt***)

## Naming


## Quotes
In Dart / Flutter, we would use single quote `'` instead of double quote `"`

## Comments

- We should avoid:
  - Leaving commented code that would not be needed anymore
  - Leave comments that are not giving too much value
- We should clean the TODO's FIXME's comments as quick as we can
- Methods and classes should be self explanatory and they should don't need comments
- If we need to add a comment, this one should be brief

## Constants

## Type inferance

## Strings

## Widgets

## Resources

Here are some resources that helped to define the code style for this project:
- [Effective Dart](https://dart.dev/guides/language/effective-dart/style)
- [Style Guide for Flutter](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo)

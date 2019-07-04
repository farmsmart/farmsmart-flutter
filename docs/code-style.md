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

## No global scope constants

We should avoid having global scope constants, all the constants should stay in the scope of the Widget that are being used.

## Using Trailing commas

Flutter code often involves building fairly deep tree-shaped data structures, for example in a build method. To get good automatic formatting, we recommend you adopt the optional trailing commas. The guideline for adding a trailing comma is simple: Always add a trailing comma at the end of a parameter list in functions, methods, and constructors where you care about keeping the formatting you crafted. This helps the automatic formatter to insert an appropriate amount of line breaks for Flutter-style code.

[Trailing commas reference](https://flutter.dev/docs/development/tools/formatting#using-trailing-commas)

## Code format

Before pushing and merging changes made in the code, we should run before the auto format, that can be run executing ***dartfmt*** (*dartfmt* can be found right-clicking in the code window and then select ***Reformat Code with dartfmt***)

## Quotes

In Dart / Flutter, we would use single quote `'` instead of double quote `"`

## Comments

- We should avoid:
  - Leaving commented code that would not be needed anymore
  - Leave comments that are not giving too much value
- We should clean the TODO's FIXME's comments as quick as we can
- Methods and classes should be self explanatory and they shouldn't need comments
- If we need to add a comment, this one should be brief

## Constants

We should group inside a class all the constants that referes to a same concept.

We should avoid:
```
const documentTitle = ''
const documentDescription = ''
const documentLink = ''
```
We should do:
```
class DocumentConstants {
    const title = ''
    const description = ''
    const link = ''
}
```
## Strings

The same that we said with Constants applies with Strings.

In order to keep our resources clean and organized, we would need to have the Strings in the scope of where they would be used.

Let's see an example, if we have a global scope Strings file, like:

```
class Strings {
    String homeTab = ''
    String profileTab = ''
    String newsTab = ''
    String moreTab = ''

    String myProfileTitle = ''
    String myProfileName = ''
    String myProfileDescription = ''
    String myProfileDate = ''
    String myProfileSkills = ''
}
```
We should refactor that an have private classes inside the different Widgets where we would use these Strings.

Bottom Bar Widget:
```
class _Strings {
  static const String home = '';
  static const String profile = '';
  static const String news = '';
  static const String more = '';
}
```

My Profile Widget:
```
class _Strings {
  static const String title = '';
  static const String name = '';
  static const String description = '';
  static const String date = '';
  static const String skills = '';
}
```

This would help in code when we access to this specific strings get a clear context of where we are going, and if there's a change, where we should apply the changes.

## Type system and inferance

We encourage to check the [Type System](https://dart.dev/guides/language/sound-dart) in Dart to get a better overview of **Do** and **Don't Do** in Dart.

## Widgets

When building a Widget in Flutter, we should use [Trailing commas](https://flutter.dev/docs/development/tools/formatting#using-trailing-commas), as said in the specified point.

Another practices we should follow:
- We should extract in methods the Widgets instead of embedding them one inside another in a hierarchical view.
- Smaller Widgets will help us to reuse them in different parts of the code.
- A Widget would have the resources that it needs, and this one would be the only who can access to the resources it is using (constants, colors, strings, ...).

## Assets / Images separation

Inside the assets folder, we should separate the different resources by folders that identifies the place where this is being used.

## Literals & magic numbers

We would not have hardcoded literals or numbers in our code, that adds complexity when we try to change any of them, or if we want tu reuse them. we should place them in the correct Strings or Constants file or in the top of the current class if they are only used there.

```
class XYZ {

    void example() {
        runMethod1('current position');
        for(int i=0; i<3; i++) {
            runMethod1('current position $i');
        }
    }

    void runMethod1(String text) {
        print(text);
    }

}
```

```
class XYZ {

    void example() {
        const currentPosition = 'current position';
        const numberOfPositions = 3;
        runMethod1(currentPosition);
        for(int i=0; i<numberOfPositions; i++) {
            runMethod1('$currentPosition $i');
        }
    }

    void runMethod1(String text) {
        print(text);
    }

}
```
## Resources

Here are some resources that helped to define the code style for this project:
- [Effective Dart](https://dart.dev/guides/language/effective-dart/style)
- [Style Guide for Flutter](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo)
- [Type System](https://dart.dev/guides/language/sound-dart)

# Pull Request Template

*When we create a new Pull Request (PR) in develop we should follow the next template:*


[FARM-XXX - Please use Spring JIRA ticket and not subtasks]

#### 📲 What

A description of the change.

#### 🤔 Why
		
Why it's needed, background context.
		
#### 🛠 How
		
More in-depth discussion of the change or implementation.

#### 👀 See
		
Screenshots / external resources
		 
#### ✅ Acceptance criteria

- [ ] Design Review for UI with BA completed. 
- [ ] Manually tested and verified on Android device/emulator (min. Lollipop 5.1)
- [ ] Showcase video / automation test
- [ ] Passing all tests
- [ ] Rebased/merged with latest changes from development and re-tested
- [ ] Removed unsed comments. TODOs must have JIRA for future work.
- [ ] Snap shot test for new widgets
- [ ] Unit test if in subtask Jira ticket
  

#### Coding Standards Checklist
- [ ] unit tests 80% coverage on testable code (functions, methods, class)
- [ ] (Architecture) Using BLOC following:
  - **Model:** [model, repo] -> **BLOC:** [ViewModelProvider, Transformer] -> **View:** [viewModel, widget]
- [ ] ui elements defined under lib/ui. 
- [ ] Strings ready for localisation
- [ ] Assets (images/icons path) defined in lib/utils/assets.dart
- [ ] No global scope strings, dimens, styles or colors
- [ ] Using style injection for Widgets

Recommended Style Guide: https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo

#### 🕵️‍♂️ How to test

Notes for QA

#### Reviewers

@farmsmart/amido @farmsmart/wamf


# Pull Request Release Candidate Template:

*When we create a new Pull Request (PR) for a Release Candidate we should follow the next template:*

# Farmsmart Release
```
Version: M.N
Is the release production ready?
```

# What's in this release?

### New features

```
List newly added functionality
```
### Quality of life improvements
```
Describe improvements that may not have UI components.
```

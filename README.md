# Farmsmart [![CircleCI](https://circleci.com/gh/farmsmart/farmsmart-flutter.svg?style=svg)](https://circleci.com/gh/farmsmart/farmsmart-flutter)

This isn't your typical farming app. FarmSmart is for anyone who wants to grow more with less, built with and for its community.

Tailored recommendations on what to grow. Built in chat. The best techniques in farming - available for free.

# Website

https://www.farmsmart.co/

# Google Play Internal Test Track

To download a developer copy from the Play Store click the link below to join the program.
https://play.google.com/apps/internaltest/4698261731148956175/join?hl=en-GB

If the link does not work please send a request to @farmsmart/amido

## Developers

1. Install the [Flutter SDK](https://flutter.dev/docs/get-started/install)
2. Run `flutter packages get` from the project root
2. Create empty `key.jks` file somewhere on your system
3. Create `key.properties` file in the `/android` directory, update the storeFile path to point to the key in previous step

```
storePassword="storePwd"
keyPassword="keyPwd"
keyAlias="keyAliasName"
storeFile="path-to-key/key.jks"
```
4. Download `google-services.json` file from Firebase to the `/android/app` directory
5. Add `development` flavour to your run configuration
  - **IntelliJ/Android Studio:** Run > Edit configurations... > Build Flavour
  - **VSCode:** add the following in `launch.json`
  ```
    "configurations": [
    {
      "name": "Flutter",
      "request": "launch",
      "type": "dart",
      "args": [
        "--flavor",
        "development"
      ]
    }
  ]
  ```
6. Setup and run an [emulator](https://developer.android.com/studio/run/emulator) or connect a real device
7. Run the application!
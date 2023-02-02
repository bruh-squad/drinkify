# Alkoholicy W Okolicy

A mobile app that will help you find a party in your area.

## Before you install
This repository does NOT contain **.dart_tool**.
If you don't have this folder, make sure to run the command below while being in the app's directory.
```
flutter create .
```
Now delete **test** folder since this repository does not contain one.
Leaving this folder undeleted will cause errors.

## Installation
Make sure you have have enabled USB debugging in developer options and your device is being detected.
If so run the commands below.
```
flutter build apk --release
flutter install
```

# Drinkify

Drinkify is a mobile app that helps you plan parties and discover new ones in your area. 

## Before you install
This repository does NOT contain **.dart_tool**.
If you don't have this folder, make sure to run the command below while being in the app's directory.
```
flutter create .
```
Now delete **test** folder since this repository does not contain one.
Leaving this folder undeleted will cause errors.

To make maps work properly you need to set up a **.env** file.
Example:
```
OPENROUTESERVICE_APIKEY = "Your API key to openrouteservice.org"
ONESIGNAL_APIKEY = "Your API key to onesignal.com"
```

Without those API keys app won't be able to:
> draw a path to selected location\
> send push notifications.

## Installation
Make sure you have have enabled USB debugging in developer options and your device is being detected.
If so run the commands below.
```
flutter build apk --release
flutter install
```

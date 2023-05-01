# Aitebar

A new Flutter project.

Run below command before running your project
```
flutter pub run build_runner watch build --delete-conflicting-outputs
```

If the above throw any exception then run below command

```
flutter clean; flutter pub get;
```

```
flutter pub run build_runner watch build --delete-conflicting-outputs
```

Run below command to run your project

###  Mobile App
```
flutter run -t lib/mobile_main.dart --web-renderer html
```
### Admin App
```
flutter run -t lib/web_main.dart --web-renderer html
```
### Deploy Admin portal to firebase after Installing [Firebase CLI](https://firebase.google.com/docs/cli?authuser=0&hl=en#install_the_firebase_cli)
```
flutter build web -t lib/web_main.dart --web-renderer html && firebase deploy --only hosting
```
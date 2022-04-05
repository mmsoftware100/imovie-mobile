# Datshin Mobile App
How to setup Datshin Mobile App?

### Change Package Name
- Open Datshin Flutter Project in Android Studio.
- in terminal type ```flutter run```, the Datshin mobile app will run on your phone.
- change_app_package_name , to change app package name, type ```flutter pub run change_app_package_name:main com.new.package.name```
- flutter_launcher_icons, to change app icon, replace ```assets/images/logo.png``` with your app icon and  type ```flutter pub run flutter_launcher_icons:main```
- to change app name
  - [Android] edit these file ```android/app/src/main/AndroidManifest.xml```
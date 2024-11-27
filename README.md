# forms_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

## Change applicationId

Usa un paquete para automatizar el proceso:
https://pub.dev/packages/change_app_package_name

Tambien es importante que el nombre tanto del proyetco como applicationId no contenga guion medio (-) porque genera error en firebase

## Firebase

Crear un projecto en Firebase

Instalar Firebase CLI si no esta instalado en sistema operativo mediante archivo binario o npm (recomendado) "npm install -g firebase-tools" y probar loguearse desde la linea de comandos.
https://firebase.google.com/docs/cli?hl=es-419#sign-in-test-cli

https://firebase.flutter.dev/docs/overview
Instalar firebase_core ( flutter pub add firebase_core ). Before any Firebase services can be used, you must first install the firebase_core plugin, which is responsible for connecting your application to Firebase

Instalar flutterfire_cli ( dart pub global activate flutterfire_cli ) y agregar variable de entorno en el path del sistema C:\Users\tunombredeusuario\AppData\Local\Pub\Cache\bin

Ejecutar el comando dart pub global run flutterfire_cli:flutterfire configure para generar firebase_options.dart

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

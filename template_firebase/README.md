# template_firebase

## Dependencies

```sh
flutter pub add dev:build_runner

flutter pub add flutter_riverpod
flutter pub add riverpod_annotation
flutter pub add dev:riverpod_generator
flutter pub add dev:custom_lint dev:riverpod_lint

flutter pub add freezed_annotation
flutter pub add dev:freezed
flutter pub add json_annotation
flutter pub add dev:json_serializable
```

## Firebase

```
curl -sL https://firebase.tools | bash
firebase login
dart pub global activate flutterfire_cli
flutterfire configure
```

- See https://console.firebase.google.com/
- Firestore Database -> Create database
- Firestore Database -> Rules -> Start in test mode
- Start a collection with a document > tasks
- https://console.cloud.google.com/auth/overview/create
- https://console.cloud.google.com/auth/clients/create
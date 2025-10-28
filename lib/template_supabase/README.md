# template_supabase

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

flutter pub add supabase_flutter
```

## Supabase

TODO

## Authentication

TODO

```sh
flutter pub add google_sign_in
```

Access <https://console.cloud.google.com/>, choose a project, and create a new OAuth 2.0 client ID. Choose Web application, and add `http://localhost:7357` as an authorized JavaScript origin (replace `7357` by the port your application runs on). Copy the client ID.

Edit `web/index.html`, adding the following tag inside `<head>`:

```html
<meta name="google-signin-client_id" content="YOUR_CLIENT_ID.apps.googleusercontent.com">
```

(Replace `YOUR_CLIENT_ID` by the client ID you copied).

More information: https://pub.dev/packages/google_sign_in_web
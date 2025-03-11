# Code generator for Flutter projects

This repository contains two generators:

- Flutter + Firebase projects
- Flutter + Serverpod projects (deprecated)

## Flutter + Firebase

First, activate the generator:

```sh
dart pub global activate --source git https://github.com/rodrigorgs/fsgen
```

Then, create a new Flutter project:

```sh
flutter create myapp
```

Enter your project's folder and run the `firegen_init` command:

```sh
cd myapp
dart pub global run fsgen:firegen_init
```

It will add dependencies and add/replace some files.

**Follow the instructions** to configure your project with Firebase.

Then, create a scaffold, e.g.:

```sh
dart pub global run fsgen:firegen_scaffold book
```

It will create model, widgets, controllers, and repositories for the Book entity, under `lib/book`.

Finally, configure Google Sign In. Access <https://console.cloud.google.com/>, choose a project, and create a new OAuth 2.0 client ID. Choose Web application, and add `http://localhost:7357` as an authorized JavaScript origin (replace `7357` by the port your application runs on). Copy the client ID.

Edit `web/index.html`, adding the following tag inside `<head>`:

```html
<meta name="google-signin-client_id" content="YOUR_CLIENT_ID.apps.googleusercontent.com">
```

(Replace `YOUR_CLIENT_ID` by the client ID you copied).

More information about Google Sign In: https://pub.dev/packages/google_sign_in_web
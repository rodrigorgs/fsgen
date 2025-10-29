# Code generator for Flutter projects

This repository contains the following generators:

- Flutter + Supabase projects
- Flutter + Firebase projects
- Flutter + Serverpod projects (deprecated)

## Flutter + Supabase

First, activate the generator:

```sh
dart pub global activate --source git https://github.com/rodrigorgs/fsgen
```

Then, create a new Flutter project:

```sh
flutter create myapp
```

Enter your project's folder and run the `supagen_init` command:

```sh
cd myapp
dart pub global run fsgen:supagen_init
```

It will add dependencies and add/replace some files.

Create the file `supabase_options.dart` in the `lib` folder, with the following contents:


```dart
const Map<Symbol, dynamic> supabaseOptions = {
  #url: 'REPLACE WITH YOUR SUPABASE URL',
  #anonKey: 'REPLACE WITH YOUR SUPABASE ANON KEY',
};
```

You can get the URL and anon key from your Supabase project settings.


Create a scaffold, e.g.:

```sh
dart pub global run fsgen:supagen_scaffold task
```

In the file `lib/main.dart`, replace the placeholder widget with your generated list page, e.g.:

```dart
return TaskListPage();
```

Also remember to add the proper imports.

Run the code generator:

```sh
dart run build_runner build
```

Finally, run your app:

```sh
flutter run -d chrome --web-port 7357
```

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

**Follow the instructions** in the command output to configure your project with Firebase.

Then, create a scaffold, e.g.:

```sh
dart pub global run fsgen:firegen_scaffold book
```

It will create model, widgets, controllers, and repositories for the Book entity, under `lib/book`.

Finally, configure Google Sign In. Access <https://console.cloud.google.com/>, choose your project (or create a new one), and create a new OAuth 2.0 client ID. Choose Web application, and add `http://localhost:7357` as an authorized JavaScript origin (replace `7357` by the port your application runs on). Copy the client ID.

Also, enable People API in the Google Cloud Console.

Edit `web/index.html`, adding the following tag inside `<head>`:

```html
<meta name="google-signin-client_id" content="YOUR_CLIENT_ID.apps.googleusercontent.com">
```

(Replace `YOUR_CLIENT_ID` by the client ID you copied).

More information about Google Sign In: https://pub.dev/packages/google_sign_in_web

Run the `dart run build_runner build` command if you hadnt't run `build_runner watch` before.

Finally, run your app:

```sh
flutter run -d chrome --web-port 7357
```

You may change `lib/main.dart` to show `BookListPage` instead of `MainPage`.
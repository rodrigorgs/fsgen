# Code generator for Flutter projects

This repository contains two generators:

- Flutter + Firebase projects
- Flutter + Serverpod projects (deprecated)

## Flutter + Firebase

To use the generator, first create your Flutter project, e.g.:

```sh
flutter create myapp
```

Enter your project's folder and run the init command:

```sh
cd myapp
dart run firegen_init
```

It will add dependencies and add/replace some files. Follow the instructions to configure your project with Firebase.

Then, create a scaffold, e.g.:

```sh
dart run firegen_scaffold book
```

It will create model, widgets, controllers, and repositories for the Book entity, under `lib/book`.


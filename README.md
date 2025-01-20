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

It will add dependencies and add/replace some files. Follow the instructions to configure your project with Firebase.

Then, create a scaffold, e.g.:

```sh
dart pub global run fsgen:firegen_scaffold book
```

It will create model, widgets, controllers, and repositories for the Book entity, under `lib/book`.


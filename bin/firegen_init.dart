import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:fsgen/transformer.dart';

void main(List<String> arguments) {
  final projectDirectory = Directory.current;
  final projectName = p.basename(projectDirectory.path);
  final scriptDirectory = Directory(
      Platform.script.path.substring(0, Platform.script.path.lastIndexOf('/')));
  final templateDirectory =
      Directory('${scriptDirectory.parent.path}/template_firebase');

  print('script directory: ${scriptDirectory.path}');
  print('template directory: ${templateDirectory.path}');
  final transfomer = Transformer(
      projectDirectory: projectDirectory,
      templateDirectory: templateDirectory,
      modelName: 'NNN');

  ///////////////

  transfomer.copyRebranded(File('${templateDirectory.path}/lib/main.dart'));
  transfomer.copyRebranded(
      File('${templateDirectory.path}/lib/firestore_provider.dart'));
  transfomer.copyRebranded(File('${templateDirectory.path}/.gitignore'));
  transfomer
      .copyRebranded(File('${templateDirectory.path}/.vscode/settings.json'));

  /////

  Directory.current = projectDirectory;

  exec(
      'flutter',
      [
        'pub',
        'add',
        'flutter_riverpod',
        'riverpod_annotation',
        'dev:build_runner',
        'dev:riverpod_generator',
        'dev:custom_lint',
        'dev:riverpod_lint',
        'dev:bdd_widget_test',
        'freezed_annotation',
        'dev:freezed',
        'json_annotation',
        'dev:json_serializable',
        'firebase_core',
        'cloud_firestore',
      ],
      message: 'Adding flutter dependencies...');

  print('Done.');
  print('Remember to configure Firebase:');
  print('');
  print('  curl -sL https://firebase.tools | bash');
  print('  firebase login');
  print('  dart pub global activate flutterfire_cli');
  print('  flutterfire configure');
  print('');
  print('Also, keep the build_runner on while developing:');
  print('');
  print('  dart run build_runner watch');
  print('');
}

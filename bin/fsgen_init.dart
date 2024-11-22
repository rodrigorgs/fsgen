import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:fsgen/transformer.dart';

void main(List<String> arguments) {
  final projectDirectory = Directory.current;
  final projectName = p.basename(projectDirectory.path);
  final scriptDirectory = Directory(
      Platform.script.path.substring(0, Platform.script.path.lastIndexOf('/')));
  final templateDirectory =
      Directory('${scriptDirectory.parent.path}/template');

  print('script directory: ${scriptDirectory.path}');
  print('template directory: ${templateDirectory.path}');
  final transfomer = Transformer(
      projectDirectory: projectDirectory,
      templateDirectory: templateDirectory,
      modelName: 'NNN');

  ///////////////

  transfomer.copyRebranded(File(
      '${templateDirectory.path}/template_flutter/lib/client_provider.dart'));
  transfomer
      .copyRebranded(File('${templateDirectory.path}/start-processes.sh'));
  transfomer
      .copyRebranded(File('${templateDirectory.path}/.vscode/settings.json'));
  transfomer.copyRebranded(
      File('${templateDirectory.path}/template_flutter/.gitignore'));

  // chmod +x start-processes.sh

  /////

  Directory.current = projectDirectory;
  Directory.current = '${projectName}_server';
  exec('serverpod', ['generate'], message: 'Generating Serverpod code...');
  Directory.current = projectDirectory;
  Directory.current = '${projectName}_flutter';
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
        'dev:bdd_widget_test'
      ],
      message: 'Adding flutter dependencies...');

  exec('dart', ['run', 'build_runner', 'build'],
      message: 'Generating Riverpod code...');
}

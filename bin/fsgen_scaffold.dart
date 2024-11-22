import 'dart:io';
import 'package:fsgen/transformer.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';

final globs = [
  'template_flutter/lib/task/*.dart',
  'template_server/lib/src/models/task.spy.yaml',
  'template_server/lib/src/endpoints/task_endpoint.dart',
];

String rebrand(String str, String projectName, String modelName) {
  final modelNameCapitalized =
      modelName[0].toUpperCase() + modelName.substring(1);
  return str
      .replaceAll('template', projectName)
      .replaceAll('task', modelName)
      .replaceAll('Task', modelNameCapitalized);
}

class Generator {
  final Transformer transfomer;

  Generator({required this.transfomer});

  void generate() {
    // print('Generating $modelName scaffold for $projectName');

    for (final glob in globs) {
      // get all files matching the glob
      final path = '${transfomer.templateDirectory.absolute.path}/$glob';
      for (final templateFile in Glob(path).listSync()) {
        transfomer.copyRebranded(templateFile as File);
      }
    }
  }
}

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Please provide a modelName.');
    return;
  }

  final modelName = arguments[0].toLowerCase();
  final projectDirectory = Directory.current;
  final scriptDirectory = Directory(
      Platform.script.path.substring(0, Platform.script.path.lastIndexOf('/')));
  final templateDirectory =
      Directory('${scriptDirectory.parent.path}/template');

  final t = Transformer(
      projectDirectory: projectDirectory,
      templateDirectory: templateDirectory,
      modelName: modelName);
  final gen = Generator(transfomer: t);

  gen.generate();

  print('Done.');
  print('Now edit the file:');
  print('');
  print('  ${t.projectName}_server/lib/src/models/${t.modelName}.spy.yaml');
  print('');
  print('Then run the following commands:');
  print('');
  print('  cd ${t.projectName}_server');
  print('  serverpod generate');
  print('  serverpod create-migration');
  print('  dart bin/main.dart --role maintenance --apply-migrations');
  print('');
  print('After that, you need to restart the server.');
}

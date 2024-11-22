import 'dart:io';
import 'package:path/path.dart' as p;

void exec(String command, List<String> arguments, {String? message}) {
  if (message != null) {
    print(message);
  }
  final result = Process.runSync(command, arguments);
  if (result.exitCode != 0) {
    print('Failed to execute $command: ${result.stderr}');
    exit(1);
  } else {
    print('Success.');
  }
}

class Transformer {
  final Directory projectDirectory;
  final Directory templateDirectory;
  final String modelName;

  Transformer({
    required this.projectDirectory,
    required this.templateDirectory,
    required this.modelName,
  });

  String get projectName => projectDirectory.path.split('/').last;
  String get modelNameCapitalized =>
      modelName[0].toUpperCase() + modelName.substring(1);

  String rebrand(String str) {
    return str
        .replaceAll('template', projectName)
        .replaceAll('task', modelName)
        .replaceAll('Task', modelNameCapitalized);
  }

  String repath(FileSystemEntity file) {
    return file.absolute.path
        .replaceAll(
            templateDirectory.absolute.path, projectDirectory.absolute.path)
        .replaceAll('template', projectName)
        .replaceAll('task', modelName);
  }

  void createDirectoryForFile(String outputPath) {
    final outputDirectory = Directory(p.dirname(outputPath));
    if (!outputDirectory.existsSync()) {
      outputDirectory.createSync(recursive: true);
    }
  }

  void copyRebranded(File templateFile) {
    print(templateFile.absolute.path);
    final templateContent = File(templateFile.path).readAsStringSync();
    final outputPath = repath(templateFile);
    createDirectoryForFile(outputPath);
    File(outputPath).writeAsStringSync(rebrand(templateContent));
  }
}

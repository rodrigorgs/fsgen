import 'dart:io';
import 'dart:isolate';
import 'package:fsgen/transformer.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';

final globs = [
  'lib/task/*.dart',
];

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

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('Please provide a modelName.');
    return;
  }

  final modelName = arguments[0].toLowerCase();
  final projectDirectory = Directory.current;
  final scriptDirectory = Directory(
      Platform.script.path.substring(0, Platform.script.path.lastIndexOf('/')));

  final packageUri = Uri.parse('package:fsgen/template_firebase');
  final uri = await Isolate.resolvePackageUri(packageUri);
  final templateDirectory = Directory.fromUri(uri!);

  // final templateDirectory =
  //     Directory('${scriptDirectory.parent.path}/template_firebase');

  print('Project directory: $projectDirectory');
  print('Template directory: $templateDirectory');
  print('Script directory: $scriptDirectory');

  final t = Transformer(
      projectDirectory: projectDirectory,
      templateDirectory: templateDirectory,
      modelName: modelName);
  final gen = Generator(transfomer: t);

  gen.generate();

  print('Done.');
}

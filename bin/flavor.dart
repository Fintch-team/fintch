import 'dart:io';

void main(List<String> args) {
  final flavor = args.first;
  final file = File('flavors/$flavor.dart');
  if (!file.existsSync()) {
    throw Exception('$flavor not found');
  }

  String content = file.readAsStringSync();
  content = '''// don't edit this file by hand
// use :
//      flutter pub run bin/flavor localhost
// or :
//      flutter pub run bin/flavor production
''' +
      content;

  final output = File('lib/flavor.dart');
  output.writeAsStringSync(content, flush: true);
}

import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:args/args.dart';
import 'package:image/image.dart';

String imagesPath = '../assets/images/';
String sourcePath = imagesPath + '3.0x/';
bool isValid;

void main(List<String> arguments) {
  final parser = ArgParser();
  var results = parser.parse(arguments);
  results.rest.forEach((arg) => (arg.endsWith('.png') || arg.endsWith('.jpg'))
      ? isValid = true
      : isValid = false);
  if (isValid) {
    List<String> paths = results.rest;
    paths.forEach((element) => resize(
        decodeImage(new File(sourcePath + element).readAsBytesSync()),
        element));
  } else {
    stderr.writeln('Only JPEG og PNG files are supported.');
    exit(2);
  }
  stdout.writeln('Success!');
}

void resize(Image image, String name) {
  int baseWidth = image.width ~/ 3;
  Image base = copyResize(image, baseWidth);
  Image half = copyResize(image, baseWidth * 2);

  saveImage(base, '', name);
  saveImage(half, '2.0x/', name);
}

void saveImage(Image image, String res, String name) async {
  String path = p.join(imagesPath, res);
  bool exists = await Directory(path).exists();
  if (!exists) {
    await Directory(path).create();
  }
  File(p.join(path, name))
    ..writeAsBytesSync(
        name.endsWith('.png') ? encodePng(image) : encodeJpg(image));
}

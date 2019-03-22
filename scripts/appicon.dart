import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:args/args.dart';
import 'package:image/image.dart';

/// To use this hacky script, place the source high-res
/// image in [./assets/images/3.0x] and run the script
/// from the [scripts] folder.

String imagesPath = '../assets/images/';
String sourcePath = imagesPath + '3.0x/';
String androidResPath = '../android/app/src/main/res/';
String iosResPath = '../ios/Runner/Assets.xcassets/AppIcon.appiconset/';
String androidIcon = 'ic_launcher.png';

bool isValid;

void main(List<String> arguments) {
  final parser = new ArgParser();
  var results = parser.parse(arguments);
  results.rest.forEach((arg) => (arg.endsWith('.png') || arg.endsWith('.jpg'))
      ? isValid = true
      : isValid = false);
  if (isValid) {
    List<String> paths = results.rest;
    paths.forEach((element) => resize(
        decodeImage(new File(sourcePath + element).readAsBytesSync())));
  } else {
    stderr.writeln('Only PNG files are supported.');
    exit(2);
  }
  stdout.write('Success!');
}

void resize(Image image) {
  Image xxxhdpi = copyResize(image, 192);
  Image xxhdpi = copyResize(image, 144);
  Image xhdpi = copyResize(image, 96);
  Image hdpi = copyResize(image, 72);
  Image mdpi = copyResize(image, 48);

  // Save Android assets
  saveImage(xxxhdpi, p.join(androidResPath, 'mipmap-xxxhdpi/'), androidIcon);
  saveImage(xxhdpi, p.join(androidResPath, 'mipmap-xxhdpi/'), androidIcon);
  saveImage(xhdpi, p.join(androidResPath, 'mipmap-xhdpi/'), androidIcon);
  saveImage(hdpi, p.join(androidResPath, 'mipmap-hdpi/'), androidIcon);
  saveImage(mdpi, p.join(androidResPath, 'mipmap-mdpi/'), androidIcon);

  Image ios1024 = copyResize(image, 1024);
  Image ios180 = copyResize(image, 180);
  Image ios167 = copyResize(image, 167);
  Image ios152 = copyResize(image, 152);
  Image ios120 = copyResize(image, 120);
  Image ios87 = copyResize(image, 87);
  Image ios80 = copyResize(image, 80);
  Image ios76 = copyResize(image, 76);
  Image ios60 = copyResize(image, 60);
  Image ios58 = copyResize(image, 58);
  Image ios40 = copyResize(image, 40);
  Image ios29 = copyResize(image, 29);
  Image ios20 = copyResize(image, 20);

  // Save iOS assets
  saveImage(ios1024, iosResPath, 'Icon-App-1024x1024@1x.png');
  saveImage(ios180, iosResPath, 'Icon-App-60x60@3x.png');
  saveImage(ios167, iosResPath, 'Icon-App-83.5x83.5@2x.png');
  saveImage(ios152, iosResPath, 'Icon-App-76x76@2x.png');
  saveImage(ios120, iosResPath, 'Icon-App-60x60@2x.png');
  saveImage(ios120, iosResPath, 'Icon-App-40x40@3x.png');
  saveImage(ios87, iosResPath, 'Icon-App-29x29@3x.png');
  saveImage(ios80, iosResPath, 'Icon-App-40x40@2x.png');
  saveImage(ios76, iosResPath, 'Icon-App-76x76@1x.png');
  saveImage(ios60, iosResPath, 'Icon-App-20x20@3x.png');
  saveImage(ios58, iosResPath, 'Icon-App-29x29@2x.png');
  saveImage(ios40, iosResPath, 'Icon-App-20x20@2x.png');
  saveImage(ios40, iosResPath, 'Icon-App-40x40@1x.png');
  saveImage(ios29, iosResPath, 'Icon-App-29x29@1x.png');
  saveImage(ios20, iosResPath, 'Icon-App-20x20@1x.png');
  saveImage(ios180, iosResPath, 'Icon-App-60x60@3x.png');




  

}

void saveImage(Image image, String location, String name) async {
  bool exists = await Directory(location).exists();
  if (!exists) {
    await new Directory(location).create();
  }
  new File(p.join(location, name))
    ..writeAsBytesSync(
        name.endsWith('.png') ? encodePng(image) : encodeJpg(image));
}

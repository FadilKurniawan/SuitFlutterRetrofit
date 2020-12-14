import 'package:flutter/material.dart';

class Resources {
  static SMColors color = SMColors();
  static SMImages images = SMImages();
}

class SMColors {
  final colorPrimary = Colors.red;
  final colorAccent = Colors.deepOrangeAccent;
}

class SMImages {
  AssetImage imagePlaceHolder =
      AssetImage('lib/resources/images/img_placeholder.png');
}

class SMImageStrings {
  static const palceholder = "lib/resources/images/img_placeholder.png";
}

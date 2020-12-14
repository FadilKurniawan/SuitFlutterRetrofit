import 'dart:io';

import 'package:flutter/services.dart';

import 'file_manager.dart' as FM;

/// Load asset file.
Future<File> loadAsset(String name, String sourceDir) async {
  try {
    final bytes = await rootBundle.load("$sourceDir/$name");
    String tempDir = await FM.tempDir;
    String tempPath = "$tempDir/$name";
    final tempFile = await FM.writeByteToFile(bytes, tempPath);
    return tempFile;
  } on FileSystemException catch (e) {
    return Future.error("${e.message}. ${e.osError?.message ?? ''}");
  } catch (e) {
    return Future.error(e.toString());
  }
}

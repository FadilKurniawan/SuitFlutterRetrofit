import 'dart:io';

import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// Temporary directory. Can be removed by system anytime.
Future<String> get tempDir async => (await getTemporaryDirectory()).path;

/// Document directory.
///
/// Uses iOS `NSDocumentDirectory` and Android `getDataDirectory`.
Future<String> get documentDir async =>
    (await getApplicationDocumentsDirectory()).path;

/// This directory is persisted and not exposed to user.
///
/// Uses iOS `NSApplicationSupportDirectory` and Android `getFilesDir`.
Future<String> get hiddenPersistedDir async =>
    (await getApplicationSupportDirectory()).path;

/// Create or replace file and write bytes into it.
Future<File> writeByteToFile(ByteData data, String path) {
  final buffer = data.buffer;
  return File(path)
      .writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}

/// Download file and save into specified destination path.
///
/// Suggested [destination]: `tempDir`, `documentDir`, `hiddenPersistedDir`
Future<File> download(String url,
    {@required String destination, void Function(double) onProgress}) async {
  assert(destination != null);
  final uri = Uri.parse(url);
  String fileName = uri?.pathSegments?.last ??
      "download_temp_${DateTime.now().millisecondsSinceEpoch}";
  final savePath = "$destination/$fileName";
  final service = Dio();
  try {
    final response = await service.download(
      url,
      savePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          double fraction = received / total;
          onProgress?.call(fraction);
        } else {
          onProgress?.call(-1);
        }
      },
    );
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final tempFile = File(savePath);
      return tempFile;
    }
    return Future.error("Download failed. ${response.statusCode}");
  } on DioError catch (e) {
    return Future.error("Download failed. ${e.message}");
  } catch (e) {
    return Future.error("Download failed. ${e.toString()}");
  }
}

/// Delete file or directory at path.
Future<void> delete(String path) async {
  File file = File(path);
  if (await file.exists()) {
    try {
      await file.delete();
      return Future.value();
    } catch (e) {
      return Future.error("Delete failed. ${e.toString()}");
    }
  } else {
    return Future.error("Delete failed. File not found");
  }
}

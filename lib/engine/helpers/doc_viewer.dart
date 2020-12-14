import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart' as UL;
import 'file_manager.dart' as FM;

/// Launch web view reader for viewing remote file.
Future<bool> launchWebReader(String url) async {
  assert(url != null);
  if (await UL.canLaunch(url)) {
    try {
      return await UL.launch(url);
    } on PlatformException catch (e) {
      return Future.error(e.message);
    } catch (e) {
      return Future.error(e.toString());
    }
  } else {
    return Future.error('No app to open');
  }
}

/// Launch [open_file] reader for viewing local file.
Future<void> launchOpenFile(String path) async {
  assert(path != null);
  final result = await OpenFile.open(path);
  if (result.type == ResultType.done) {
    return Future.value();
  }
  if (result.type == ResultType.noAppToOpen) {
    return Future.error("No app to open");
  }
  if (result.type == ResultType.fileNotFound) {
    return Future.error("File not found");
  }
  if (result.type == ResultType.permissionDenied) {
    return Future.error("Permission denied");
  }
  return Future.error(result.message);
}

/// Should launch [open_file] reader for viewing local file.
Future<void> shouldLaunchOpenFile(String path) async {
  if (path == null) return;
  return launchOpenFile(path);
}

/// Launch default viewer.
///
/// [url]: can be local or remote path.
/// [useCache]: use cached file if any. else always download.
Future<void> view(BuildContext context, String url,
    {bool useCache = true}) async {
  assert(url != null);
  try {
    if (url.startsWith('http')) {
      if (useCache) {
        final uri = Uri.parse(url);
        final fileName = uri?.pathSegments?.last;
        final cacheFile = await getCachedFile(fileName);
        if (cacheFile != null) {
          return shouldLaunchOpenFile(cacheFile.path);
        }
      }
      final downloadedFile = await _download(context, url);
      return shouldLaunchOpenFile(downloadedFile?.path);
    }
    return shouldLaunchOpenFile(url);
  } catch (e) {
    return Future.error(e);
  }
}

Future<File> _download(BuildContext context, String url) async {
  assert(url != null);
  final progress = _createProgressDialog(context);
  await progress.show();
  try {
    final file = await FM.download(
      url,
      destination: await cacheDir,
      onProgress: (fraction) {
        final percent = (fraction == -1 ? 0.999 : fraction) * 100;
        progress.update(message: "Downloading ${percent.floor()}%");
      },
    );
    await progress.hide();
    return file;
  } catch (e) {
    await progress.hide();
    return Future.error(e);
  }
}

// HELPER

ProgressDialog _createProgressDialog(BuildContext context) {
  final progress = ProgressDialog(
    context,
    type: ProgressDialogType.Normal,
    isDismissible: false,
  );
  progress.style(
    progress: 0,
    maxProgress: 100,
    progressWidget: Padding(
      padding: EdgeInsets.all(10),
      child: CircularProgressIndicator(),
    ),
    message: "Downloading 0%",
    messageTextStyle: TextStyle(fontSize: 14),
    elevation: 4,
  );
  return progress;
}

// CACHE

Future<String> get cacheDir async => await FM.tempDir;

/// Get cached file if any.
Future<File> getCachedFile(String fileName) async {
  assert(fileName != null);
  final cachePath = (await cacheDir) + "/$fileName";
  File file = File(cachePath);
  if (await file.exists()) {
    return file;
  }
  return null;
}

import 'package:flutter/material.dart';

import 'package:jasamarga_nde_flutter/engine/helpers/asset_manager.dart' as AM;
import 'package:jasamarga_nde_flutter/engine/helpers/file_manager.dart' as FM;
import 'package:jasamarga_nde_flutter/engine/helpers/doc_viewer.dart' as Doc;
import 'package:jasamarga_nde_flutter/modules/base_view/drawer/sm_drawer.dart';

const _samples = [
  'sample3.pdf',
  'sample3.docx',
  'https://www.w3.org/2013/04/odw/odw13_submission_52.pdf',
  'https://filesamples.com/samples/document/docx/sample1.docx',
];

class SampleDocPage extends StatefulWidget {
  SampleDocPage({Key key}) : super(key: key);

  @override
  _SampleDocPageState createState() => _SampleDocPageState();
}

class _SampleDocPageState extends State<SampleDocPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String selectedSample;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Sample Doc'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            tooltip: "Clear cache",
            onPressed: () {
              _clearCache();
            },
          )
        ],
      ),
      drawer: SMDrawer.buildDrawer(context),
      body: ListView(
        children: [
          for (var item in _samples)
            ListTile(
              title: Text(item),
              onTap: () => _viewDoc(item),
              trailing: Icon(Icons.remove_red_eye),
            )
        ],
      ),
    );
  }

  // UTILITY

  _showError(dynamic error) {
    final snackBar = SnackBar(content: Text(error.toString()));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future<void> _clearCache() async {
    for (var item in _samples) {
      if (item.startsWith("http")) {
        final uri = Uri.parse(item);
        final fileName = uri?.pathSegments?.last;
        final url = await Doc.cacheDir + "/$fileName";
        FM.delete(url).catchError((e) {});
      }
    }
  }

  Future<String> _getSamplePath(String url) async {
    if (url.startsWith("http")) {
      return url;
    }
    final name = url;
    final sourceDir = "lib/resources/sample";
    try {
      final file = await AM.loadAsset(name, sourceDir);
      return file.path;
    } catch (e) {
      return Future.error(e);
    }
  }

  _viewDoc(String name) async {
    try {
      final url = await _getSamplePath(name);
      await Doc.view(context, url, useCache: true);
    } catch (e) {
      _showError(e);
    }
  }
}

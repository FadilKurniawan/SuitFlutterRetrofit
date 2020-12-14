import 'package:flutter/material.dart';
import 'package:jasamarga_nde_flutter/modules/sample_doc/sample_doc_page.dart';
import 'package:jasamarga_nde_flutter/modules/sample_places/places_page.dart';
import 'package:jasamarga_nde_flutter/modules/sample_places_tab/place_tab.dart';

class ContentViewList {
  static List<Widget> getViews(BuildContext context) {
    final viewList = [
      PlacesPage.getPage(context),
      PlacesTab.getPage(context),
      SampleDocPage(),
    ];
    return viewList;
  }

  static List<String> getContentTitles() {
    final titles = [
      PlacesPage.title,
      PlacesTab.title,
      'Sample Doc',
    ];
    return titles;
  }

  static List<Icon> getContentIcons() {
    final icons = [
      Icon(Icons.home),
      Icon(Icons.dashboard),
      Icon(Icons.snippet_folder),
    ];
    return icons;
  }
}

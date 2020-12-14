import 'package:flutter/material.dart';
import 'package:jasamarga_nde_flutter/modules/base_view/drawer/sm_drawer.dart';

class PlacesTab extends StatefulWidget {
  static final title = "Categories";

  PlacesTab({Key key}) : super(key: key);

  @override
  _PlacesTabState createState() => _PlacesTabState();

  static Widget getPage(BuildContext context) {
    return PlacesTab();
  }

  static void show(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return PlacesTab.getPage(context);
        },
        fullscreenDialog: true,
      ),
    );
  }
}

class _PlacesTabState extends State<PlacesTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              SizedBox(
                height: 44,
                child: Center(
                  child: Text("Bandung"),
                ),
              ),
              SizedBox(
                height: 44,
                child: Center(
                  child: Text("Jakarta"),
                ),
              ),
              SizedBox(
                height: 44,
                child: Center(
                  child: Text("Surabaya"),
                ),
              ),
            ],
          ),
          title: Text("Categories"),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Text("Bandung"),
            ),
            Center(
              child: Text("Jakarta"),
            ),
            Center(
              child: Text("Surabaya"),
            ),
          ],
        ),
        drawer: SMDrawer.buildDrawer(context),
      ),
    );
  }
}

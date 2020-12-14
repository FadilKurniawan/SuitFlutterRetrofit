import 'package:flutter/material.dart';
import 'package:jasamarga_nde_flutter/resources/resources.dart';
import '../content_view_list.dart';
import 'cubit/drawer_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SMDrawer {
  static Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: _buildDrawerItems(context),
          ),
          Expanded(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Version"),
            ),
          )
        ],
      ),
    );
  }

  static ListView _buildDrawerItems(BuildContext context) {
    final _drawerHeader = InkWell(
      onTap: () {
        Navigator.pop(context);
        context.read<DrawerCubit>().showProfilePage();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink(
            height: 250,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(SMImageStrings.palceholder),
                  fit: BoxFit.cover),
            ),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            direction: Axis.vertical,
            children: [
              CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor, radius: 55),
              Text("Name", style: Theme.of(context).textTheme.headline3),
              Text("email", style: Theme.of(context).textTheme.headline4)
            ],
          )
        ],
      ),
    );

    List<Widget> items = [_drawerHeader];

    for (var i = 0; i < ContentViewList.getContentTitles().length; i++) {
      var icon = Icon(Icons.home);
      if (i < ContentViewList.getContentIcons().length) {
        icon = ContentViewList.getContentIcons()[i];
      }

      /// Manual List Build
      items.add(InkWell(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 16,
                children: [icon, Text(ContentViewList.getContentTitles()[i])],
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.pop(context);
          context.read<DrawerCubit>().changePage(i);
        },
      ));
    }

    return ListView(
      padding: EdgeInsets.zero,
      children: items,
    );
  }
}

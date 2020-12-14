import 'package:flutter/material.dart';
import 'package:jasamarga_nde_flutter/modules/base_view/content_view_list.dart';

class SMBottomNavBar {
  static int _currentIndex = 0;
  static Color _activeColor = Colors.black38;

  static BottomAppBar bottomAppBar(
      {@required Color activeColor,
      @required int currentIndex,
      @required ValueChanged<int> onTap}) {
        
    _currentIndex = currentIndex;
    _activeColor = activeColor;
    final _titleList = ContentViewList.getContentTitles();
    List<Widget> _itemsButton = [
      _buildItemNav(
          iconData: Icons.home,
          label: _titleList[0],
          activeColor: _activeColor,
          index: 0,
          onTap: onTap),
      _buildItemNav(
          iconData: Icons.dashboard,
          label: _titleList[1],
          activeColor: _activeColor,
          index: 1,
          onTap: onTap),
      _buildEmptyItemNav(),
      _buildItemNav(
          iconData: Icons.favorite,
          label: _titleList[2],
          activeColor: _activeColor,
          index: 2,
          onTap: onTap),
      _buildItemNav(
          iconData: Icons.person,
          label: _titleList[3],
          activeColor: _activeColor,
          index: 3,
          onTap: onTap),
    ];

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _itemsButton,
      ),
    );
  }

  static Widget _buildItemNav(
      {@required IconData iconData,
      @required String label,
      @required Color activeColor,
      @required int index,
      @required ValueChanged<int> onTap}) {
    return Expanded(
      child: SizedBox(
        height: 60,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              _currentIndex = index;
              onTap(_currentIndex);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(iconData,
                    color: (_currentIndex == index
                        ? _activeColor
                        : Colors.black38)),
                Text(label, style: TextStyle(color: (_currentIndex == index
                        ? _activeColor
                        : Colors.black38)))
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildEmptyItemNav() {
    return Expanded(
      child: SizedBox(
        // height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(null),
              Text('', style: TextStyle(color: Colors.black38))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:jasamarga_nde_flutter/modules/base_view/drawer/main_drawer.dart';
import 'package:jasamarga_nde_flutter/resources/resources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SMFAB {
  static Widget fab(BuildContext context, bool state) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: state
          ? FloatingActionButton(
              key: UniqueKey(),
              onPressed: () {
                context.read<FabCubit>().switchButton();
              },
              child: Icon(Icons.add),
              backgroundColor: Resources.color.colorPrimary,
            )
          : FloatingActionButton(
              key: UniqueKey(),
              onPressed: () {
                context.read<FabCubit>().switchButton();
              },
              child: Icon(Icons.close),
              backgroundColor: Colors.grey,
            ),
    );
  }

  static FloatingActionBubble floatingActionBubble(
    BuildContext context,
    TickerProvider vsync,
  ) {
    AnimationController _animationController = AnimationController(
      vsync: vsync,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    Animation<double> _animation =
        Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    return FloatingActionBubble(
      // Menu items
      items: <Bubble>[
        // Floating action menu item
        Bubble(
          title: "Settings",
          iconColor: Colors.white,
          bubbleColor: Colors.blue,
          icon: Icons.settings,
          titleStyle: TextStyle(fontSize: 16, color: Colors.white),
          onPress: () {
            _animationController.reverse();
          },
        ),
        // Floating action menu item
        Bubble(
          title: "Profile",
          iconColor: Colors.white,
          bubbleColor: Colors.blue,
          icon: Icons.people,
          titleStyle: TextStyle(fontSize: 16, color: Colors.white),
          onPress: () {
            _animationController.reverse();
          },
        ),
        //Floating action menu item
        Bubble(
          title: "Home",
          iconColor: Colors.white,
          bubbleColor: Colors.blue,
          icon: Icons.home,
          titleStyle: TextStyle(fontSize: 16, color: Colors.white),
          onPress: () {
            _animationController.reverse();
          },
        ),
      ],

      // animation controller
      animation: _animation,

      // On pressed change animation state
      onPress: _animationController.isCompleted
          ? _animationController.reverse
          : _animationController.forward,

      // Floating Action button Icon color
      iconColor: Colors.blue,
      animatedIconData: AnimatedIcons.add_event,
      backGroundColor: Theme.of(context).primaryColor,
    );
  }

  static SpeedDial speedDial(BuildContext context, bool state) {
    return SpeedDial(
      onOpen: () {
        context.read<FabCubit>().switchButton();
      },
      onClose: () {
        context.read<FabCubit>().switchButton();
      },
      child: AnimatedSwitcher(
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        duration: Duration(milliseconds: 350),
        child: state
            ? Icon(Icons.close, key: UniqueKey())
            : Icon(Icons.add, key: UniqueKey()),
      ),
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      backgroundColor: state ? Colors.white : Resources.color.colorPrimary,
      foregroundColor: state ? Colors.black : Colors.white,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.mail, color: Colors.black54),
          onTap: () => print('FIRST CHILD'),
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          backgroundColor: Colors.white,
          label: "Lorem Ipsum",
        ),
        SpeedDialChild(
            child: Icon(Icons.mail, color: Colors.black54),
            backgroundColor: Colors.white,
            onTap: () => print('SECOND CHILD'),
            labelStyle: TextStyle(fontWeight: FontWeight.w500),
            label: "Lorem Ipsum diaasda asdad"),
        SpeedDialChild(
            child: Icon(Icons.mail, color: Colors.black54),
            backgroundColor: Colors.white,
            onTap: () => print('THIRD CHILD'),
            label: "Lorem Ipsum diaasda asdad"),
      ],
    );
  }
}

// import 'package:flutter/material.dart';

// class FadeMaterialPageRoute<T> extends MaterialPageRoute<T> {
//   FadeMaterialPageRoute({ WidgetBuilder builder, RouteSettings settings })
//       : super(builder: builder, settings: settings);

//   @override
//   Widget buildTransitions(BuildContext context,
//       Animation<double> animation,
//       Animation<double> secondaryAnimation,
//       Widget child) {
//     if (settings.isInitialRoute)
//       return child;
//     // Fades between routes. (If you don't want any animation,
//     // just return child.)
//     return new FadeTransition(opacity: animation, child: child);
//   }
// }

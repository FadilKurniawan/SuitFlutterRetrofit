import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'engine/blocs/auth_bloc/auth_bloc.dart';
import 'engine/blocs/auth_bloc/auth_events.dart';
import 'engine/blocs/auth_bloc/auth_states.dart';
import 'engine/initial_app.dart';
import 'engine/theme.dart';
import 'modules/base_view/drawer/main_drawer.dart';
import 'modules/login/login_page.dart';
import 'widgets/smwidgets/circular_indicator.dart';

void main() {
  InitialApp.hiveInitial();
  runApp(App.getClass());
}

class App extends StatelessWidget {
  static BlocProvider getClass() {
    return BlocProvider<AuthBloc>(
      create: (context) {
        return AuthBloc(AuthInitState())..add(AuthAppStartedEvent());
      },
      child: App(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, AuthState state) =>
            _buildMaterialApp(context, state));
  }

  MaterialApp _buildMaterialApp(BuildContext context, AuthState state) {
    return MaterialApp(
      title: 'SMFlutter',
      theme: SMTheme.buildThemeData(),
      home: AnimatedSwitcher(
        duration: Duration(milliseconds: 400),
        child: _buildPage(context, state),
      ),
    );
  }

  Widget _buildPage(BuildContext context, AuthState state) {
    if (state is AuthAuthenticatedState) {
      // Mainview
      return MainDrawer.getPage(context);
    } else if (state is AuthUnauthenticatedState) {
      // Loginview
      return LoginPage.getPage(context);
    } else {
      // Authenticating
      return smFullCircularIndicator();
    }
  }
}

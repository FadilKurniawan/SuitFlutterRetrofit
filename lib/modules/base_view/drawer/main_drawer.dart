import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jasamarga_nde_flutter/engine/blocs/auth_bloc/auth_bloc.dart';
import 'package:jasamarga_nde_flutter/engine/blocs/auth_bloc/auth_states.dart';
import 'package:jasamarga_nde_flutter/modules/base_view/content_view_list.dart';
import 'package:jasamarga_nde_flutter/modules/base_view/drawer/cubit/drawer_cubit.dart';
import 'package:jasamarga_nde_flutter/modules/base_view/drawer/sm_drawer.dart';
import 'package:jasamarga_nde_flutter/modules/base_view/sm_fab.dart';
import 'package:jasamarga_nde_flutter/modules/userprofile/profile_page.dart';

class MainDrawer extends StatefulWidget {
  final BuildContext _mainContexAuth;

  MainDrawer(this._mainContexAuth, {Key key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState(this._mainContexAuth);

  static void show(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) {
              return MainDrawer.getPage(context);
            },
            fullscreenDialog: true));
  }

  static MultiBlocProvider getPage(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(AuthInitState()),
        ),
        BlocProvider<DrawerCubit>(
          create: (context) => DrawerCubit(),
        ),
        BlocProvider<FabCubit>(
          create: (context) => FabCubit(false),
        ),
      ],
      child: MainDrawer(context),
    );
  }
}

class _MainDrawerState extends State<MainDrawer> with TickerProviderStateMixin {
  final _mainContexAuth;

  _MainDrawerState(this._mainContexAuth);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Home")),
      body: BlocConsumer<DrawerCubit, DrawerCubitState>(
        listener: (context, state) {
          if (state is DrawerCubitShowProfileState) ProfilePage.show(context);
        },
        buildWhen: (context, state) {
          if (state is DrawerCubitChangePageState) return true;
          return false;
        },
        builder: (context, state) {
          return ContentViewList.getViews(_mainContexAuth)[state.page ?? 0];
        },
      ),
      drawer: SMDrawer.buildDrawer(context),
      // floatingActionButton: SMFAB.floatingActionBubble(context, this),
      floatingActionButton: BlocBuilder<FabCubit, bool>(
        builder: (context, state) {
          return SMFAB.speedDial(context, state);
        },
      ),
    );
  }
}

class FabCubit extends Cubit<bool> {
  FabCubit(bool state) : super(state);

  void switchButton() {
    emit(!state);
  }
}

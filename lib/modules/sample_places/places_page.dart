import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:jasamarga_nde_flutter/engine/cubits/cubit_refresher_state.dart';
import 'package:jasamarga_nde_flutter/modules/sample_places/cubit/places_cubit.dart';
import 'package:jasamarga_nde_flutter/modules/sample_places/places_widget.dart';
import 'package:jasamarga_nde_flutter/widgets/smwidgets/sm_flushbar_helper.dart';
import 'package:jasamarga_nde_flutter/widgets/smwidgets/sm_shimmer.dart';

class PlacesPage extends StatefulWidget {
  static final title = "Places";

  @override
  _PlacesPageState createState() => _PlacesPageState();

  static BlocProvider getPage(BuildContext context) {
    return BlocProvider<PlacesCubit>(
      create: (context) => PlacesCubit(),
      child: PlacesPage(),
    );
  }

  static void show(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return PlacesPage.getPage(context);
        },
        fullscreenDialog: true,
      ),
    );
  }
}

class _PlacesPageState extends State<PlacesPage> {
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlacesCubit, PlacesState>(
      listener: (BuildContext context, state) {
        _mapServiceState(state);
      },
      builder: (BuildContext context, state) {
        final bottomPadding = MediaQuery.of(context).padding.bottom;
        return NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) =>
              [_buildSliverAppBar()],
          body: (state.status == RefresherSatus.initial || state.data == null)
              ? SMShimmer.buildShimmerList()
              : _buildList(bottomPadding),
        );
      },
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      title: Text("Explore Place"),
      floating: true,
      snap: true,
      flexibleSpace: null,
      expandedHeight: 44,
    );
  }

  /// BUILD LIST
  ///
  Widget _buildList(double bottomPadding) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: context.read<PlacesCubit>().state.hasNext ?? false,
        header: BezierCircleHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child:
            PlacesWidget.list(context.read<PlacesCubit>().state.data, context),
      ),
    );
  }

  void _onRefresh() async {
    context.read<PlacesCubit>().refreshList();
  }

  void _onLoading() async {
    context.read<PlacesCubit>().refreshNextList();
  }

  void _mapServiceState(PlacesState state) {
    if (state.status == RefresherSatus.success) {
      if (_refreshController.isRefresh) {
        _refreshController.refreshCompleted();
      }
      if (_refreshController.isLoading) {
        _refreshController.loadComplete();
      }
    } else if (state.status == RefresherSatus.failed) {
      if (_refreshController.isRefresh) {
        _refreshController.refreshFailed();
      }
      if (_refreshController.isLoading) {
        _refreshController.loadFailed();
      }
      SMFlushbarHelper.errorFlushbar(message: state.error)..show(context);
    }
  }
}

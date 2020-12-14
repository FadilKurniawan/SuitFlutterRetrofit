import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:jasamarga_nde_flutter/engine/cubits/cubit_refresher_state.dart';
import 'package:jasamarga_nde_flutter/modules/sample_place/cubit/place_cubit.dart';
import 'package:jasamarga_nde_flutter/widgets/smwidgets/sm_flushbar_helper.dart';

class PlacePage extends StatefulWidget {
  const PlacePage(this.id, {Key key}) : super(key: key);

  final int id;

  @override
  _PlacePageState createState() => _PlacePageState(id);

  static BlocProvider getPage(BuildContext context, int id) {
    return BlocProvider<PlaceCubit>(
      create: (context) => PlaceCubit(id),
      child: PlacePage(id),
    );
  }

  static void show(BuildContext context, int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return PlacePage.getPage(context, id);
        },
        fullscreenDialog: true,
      ),
    );
  }
}

class _PlacePageState extends State<PlacePage> {
  _PlacePageState(this.id);
  final _refreshController = RefreshController(initialRefresh: false);
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, //AppBar(title: Text("Detail")),
      body: BlocConsumer<PlaceCubit, PlaceState>(
        listener: (BuildContext context, state) {
          _mapPlaceState(state);
        },
        builder: (BuildContext context, state) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxScrolled) =>
                [_buildSliverAppBar()],
            body: _buildList(state),
          );
        },
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      title: Text("Place Detail"),
      floating: false,
      pinned: true,
      snap: false,
      flexibleSpace: Placeholder(),
      expandedHeight: MediaQuery.of(context).size.width / 1.7,
    );
  }

  Widget _buildList(PlaceState state) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      header: BezierCircleHeader(),
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          if (state.item != null) {
            switch (index) {
              case 0:
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state.item.name ?? "-",
                    style: TextStyle(fontSize: 24),
                  ),
                );
                break;
              case 1:
                return Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: Text(state.item.address ?? "-"),
                );
                break;
              default:
                return Text(" - ");
                break;
            }
          }
          return Text(" No Data ");
        },
      ),
    );
  }

  void _onRefresh() async {
    context.read<PlaceCubit>().refresh();
  }

  void _mapPlaceState(PlaceState state) {
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

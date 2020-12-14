import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:jasamarga_nde_flutter/engine/blocs/auth_bloc/auth_bloc.dart';
import 'package:jasamarga_nde_flutter/engine/blocs/image_picker_bloc.dart';
import 'package:jasamarga_nde_flutter/engine/blocs/auth_bloc/auth_events.dart';
import 'package:jasamarga_nde_flutter/engine/blocs/service_event_state/service_states.dart';
import 'package:jasamarga_nde_flutter/models/user.dart';
import 'package:jasamarga_nde_flutter/modules/userprofile/bloc/profile_bloc.dart';
import 'package:jasamarga_nde_flutter/resources/resources.dart';
import 'package:jasamarga_nde_flutter/widgets/smwidgets/sm_dialogs.dart';
import 'package:jasamarga_nde_flutter/widgets/smwidgets/sm_flushbar_helper.dart';
import 'package:jasamarga_nde_flutter/widgets/user_widget.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage(this._mainContext, {Key key}) : super(key: key);

  static final title = "Profile";
  final BuildContext _mainContext;

  @override
  _ProfilePageState createState() => _ProfilePageState(_mainContext);

  static void show(BuildContext context, {bool fullscreenDialog = true}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ProfilePage.getPage(context),
            fullscreenDialog: fullscreenDialog));
  }

  static StatelessWidget getPage(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<ImagePickerBloc>(
            create: (context) => ImagePickerBloc(InitialImagePickerState())),
        BlocProvider<ProfileBloc>(
          create: (context) =>
              ProfileBloc(ServiceInitState())..add(LoadCurrentUserEvent()),
        ),
      ],
      child: ProfilePage(context),
    );
  }
}

class _ProfilePageState extends State<ProfilePage> {
  _ProfilePageState(this._mainContext);

  BuildContext _mainContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocBuilder<ProfileBloc, ServiceState>(
          buildWhen: (previousState, currentState) {
            _mapServiceState(currentState, context);
            return true;
          },
          builder: (BuildContext context, ServiceState state) {
            User _user = User(name: "-");
            if (state is LoadedCurrentUserState) {
              if (state.user != null) {
                _user = state.user;
              }
            }
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxScrolled) =>
                  [_buildSliverAppBar()],
              body: UserWidget.profileList(
                user: _user,
                imageProfile: BlocBuilder<ImagePickerBloc, ImagePickerState>(
                    builder: (context, state) {
                  return _getImageFromState(state);
                }),
                onLogoutPressed: () {
                  SMDialog.showConfirmDialog(
                    context: context,
                    title: 'Logout',
                    content: 'Do you want to logout?',
                    cancelButton: FlatButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    continueButton: FlatButton(
                      child: Text('Logout'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.read<ProfileBloc>().add(LogoutUserEvent());
                      },
                    ),
                  );
                },
                onProfilePhotoPressed: () {
                  SMDialog.showModalBottomSheetImagePicker(
                    context: context,
                    onCameraTapped: () {
                      Navigator.pop(context);
                      context
                          .read<ImagePickerBloc>()
                          .add(CameraImagePickerEvent());
                    },
                    onGalleryTapped: () {
                      Navigator.pop(context);
                      context
                          .read<ImagePickerBloc>()
                          .add(GalleryImagePickerEvent());
                    },
                  );
                },
                onUpdatePressed: () {
                  // var pictureFile = context.read<ImagePickerBloc>().image;
                  // print("--> pictureUrl: ${pictureFile.path}");
                  // context.read<ProfileBloc>().add(UpdateUserEvent(pictureFile));
                },
              ),
            );
          },
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      title: Text("Profile"),
      floating: true,
      pinned: true,
      snap: false,
      flexibleSpace: null,
      expandedHeight: 44,
    );
  }

  void _mapServiceState(ServiceState currentState, BuildContext classContext) {
    if (currentState is ServiceLoadingState) {
      ProgressDialog(classContext).show();
    }
    if (currentState is LoadedCurrentUserState) {
      ProgressDialog(classContext).hide();
    }
    if (currentState is LoggedOutUserState) {
      ProgressDialog(classContext).hide();
      Navigator.pop(context);
      _mainContext.read<AuthBloc>().add(AuthLoggedOutEvent());
    }
    if (currentState is ServiceSuccessState) {
      ProgressDialog(classContext).hide();
    }
    if (currentState is ServiceFailureState) {
      ProgressDialog(classContext).hide();
      SMFlushbarHelper.errorFlushbar(message: currentState.error)
        ..show(classContext);
    }
  }

  Container _getImageFromState(ImagePickerState state) {
    ImageProvider image = Resources.images.imagePlaceHolder;
    if (state is GalleryImagePickerState || state is CameraImagePickerState) {
      final newState = state as PickerImagePickerState;
      if (newState.image != null) {
        image = FileImage(newState.image);
      }
    } else if (state is FailedImagePickerEvent) {
      print(state.error);
    }
    return Container(
      width: 120.0,
      height: 120.0,
      child: CircleAvatar(
        backgroundImage: image ?? Resources.images.imagePlaceHolder,
      ),
    );
  }
}

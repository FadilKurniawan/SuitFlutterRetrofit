import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:jasamarga_nde_flutter/engine/blocs/auth_bloc/auth_bloc.dart';
import 'package:jasamarga_nde_flutter/engine/blocs/auth_bloc/auth_events.dart';
import 'package:jasamarga_nde_flutter/modules/login/cubit/login_cubit.dart';
import 'package:jasamarga_nde_flutter/resources/resources.dart';
import 'package:jasamarga_nde_flutter/widgets/smwidgets/sm_flushbar_helper.dart';

import 'cubit/show_password_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();

  static void show(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) {
              return LoginPage.getPage(context);
            },
            fullscreenDialog: true));
  }

  static StatelessWidget getPage(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => ShowPasswordCubit()),
      ],
      child: LoginPage(),
    );
  }
}

class _LoginPageState extends State<LoginPage> {
  ProgressDialog _progressDialog;

  @override
  void initState() {
    super.initState();

    _progressDialog = ProgressDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (BuildContext context, state) {
          _mapLoginState(state);
        },
        child: _buildLoginForm(),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(
                image: Resources.images.imagePlaceHolder,
                fit: BoxFit.fitWidth,
                width: 210,
              ),
              SizedBox(height: 54),
              _textFieldEmail(),
              SizedBox(height: 16),
              _textFieldPassword(),
              SizedBox(height: 24),
              _buttonLogin(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      alignment: Alignment.center,
      height: 44,
      child: TextField(
        textAlignVertical: TextAlignVertical.bottom,
        onChanged: (text) {
          context.read<LoginCubit>().updateEmail(text);
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.mail_outline,
            color: Colors.blue[900],
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(
              const Radius.circular(90.0),
            ),
          ),
          filled: true,
          fillColor: Colors.blue[50],
          hintText: "Email",
        ),
      ),
    );
  }

  Widget _textFieldPassword() {
    return BlocBuilder<ShowPasswordCubit, bool>(
      builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          height: 44,
          child: TextField(
            textAlignVertical: TextAlignVertical.bottom,
            onChanged: (text) {
              context.read<LoginCubit>().updatePassword(text);
            },
            obscureText: !state,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Colors.blue[900],
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(90.0),
                  ),
                ),
                filled: true,
                fillColor: Colors.blue[50],
                suffixIcon: GestureDetector(
                  onTap: () =>
                      context.read<ShowPasswordCubit>().toggleShowPassword(),
                  child: _showPasswordIcon(state),
                ),
                hintText: "Password"),
          ),
        );
      },
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: 180,
      height: 50,
      child: RaisedButton(
          child: Text("Login"),
          textColor: Colors.white,
          color: Resources.color.colorPrimary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          onPressed: () {
            context.read<LoginCubit>().login();
          }),
    );
  }

  Icon _showPasswordIcon(bool isShown) {
    return Icon(isShown ? Icons.visibility : Icons.visibility_off,
        color: isShown ? Resources.color.colorPrimary : Colors.grey, size: 22);
  }

  _mapLoginState(LoginState state) {
    if (state is LogingIn) {
      _progressDialog.show();
    } else if (state is LoginSuccess) {
      _progressDialog.hide();
      context.read<AuthBloc>().add(AuthLoggedInEvent());
    } else if (state is LoginFailed) {
      _progressDialog.hide();
      SMFlushbarHelper.errorFlushbar(message: state.error)..show(context);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:jasamarga_nde_flutter/models/user.dart';

class UserWidget {
  static Widget profileList({
    @required User user,
    @required Widget imageProfile,
    @required Function onProfilePhotoPressed,
    @required Function onLogoutPressed,
    @required Function onUpdatePressed,
  }) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: 3,
      itemBuilder: (context, index) {
        switch (index) {
          case 1:
            return Column(children: <Widget>[
              SizedBox(height: 16),
              InkWell(
                onTap: onProfilePhotoPressed,
                child: imageProfile,
              ),
              SizedBox(height: 24),
              Text(user.name ?? '', style: TextStyle(fontSize: 18)),
              SizedBox(height: 24),
              // FlatButton.icon(
              //     icon: Icon(Icons.exit_to_app),
              //     label: Text('Update Profile'),
              //     onPressed: onUpdatePressed),
              FlatButton.icon(
                  icon: Icon(Icons.exit_to_app),
                  label: Text('Logout'),
                  onPressed: onLogoutPressed)
            ]);
            break;
          default:
            return Container();
            break;
        }
      },
    );
  }
}

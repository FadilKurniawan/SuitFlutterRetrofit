import 'package:flutter/material.dart';
import 'package:jasamarga_nde_flutter/resources/resources.dart';

class SMDialog {
  static showMessageDialog(
      {BuildContext context,
      String title,
      String content,
      String dismissText}) {
    Widget okButton = FlatButton(
      child: Text(dismissText),
      onPressed: () {},
    );
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showConfirmDialog(
      {@required BuildContext context,
      String title,
      @required String content,
      @required MaterialButton cancelButton,
      @required MaterialButton continueButton}) {
    AlertDialog alert = AlertDialog(
      title: Text(title ?? ''),
      content: Text(content),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future showModalBottomSheetImagePicker(
      {@required BuildContext context,
      @required Function onGalleryTapped,
      @required Function onCameraTapped}) {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      child: Center(
                        child: Text('Upload Photo'),
                      )),
                  ListTile(
                      leading: Icon(Icons.image),
                      title: Text('Gallery'),
                      onTap: onGalleryTapped),
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('Camera'),
                    onTap: onCameraTapped,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    child: SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: FlatButton(
                            color: Resources.color.colorPrimary,
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25))),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

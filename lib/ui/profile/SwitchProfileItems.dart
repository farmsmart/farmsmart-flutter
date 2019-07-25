import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class _Constants {
  static final String navCancelIcon = "assets/raw/nav_icon_cancel.png";
}

class SwitchProfileItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "This is the title",
        style: TextStyle(
          color: Color(0xff1a1b46),
          fontSize: 17,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
      ),
      leading: ClipOval(
          child: Stack(children: <Widget>[
        Image.asset("assets/raw/mock_profile_image.png",
            height: 48, width: 48, fit: BoxFit.cover),
      ])),
      trailing:
          Image.asset("assets/icons/radio_button_default.png", height: 24),
      contentPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 15),
    );
  }
}

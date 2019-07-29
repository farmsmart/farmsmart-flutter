import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class _Strings {
  static final String navCancelIcon = "assets/raw/nav_icon_cancel.png";
  static final String title = "This is the title";
}

class _Constants {
  static final double imageSize = 48;
  static final double iconSize = 24;
  static final EdgeInsets iconEdgePadding =
      EdgeInsets.symmetric(horizontal: 32, vertical: 15);
}

class SwitchProfileItemsViewModel {
  final String title;
  final String image;
  final String icon;

  SwitchProfileItemsViewModel({this.title, this.image, this.icon});
}





class SwitchProfileItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        Intl.message(_Strings.title),
        style: TextStyle(
          color: Color(0xff1a1b46),
          fontSize: 17,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
      ),
      leading: ClipOval(
        child: Stack(
          children: <Widget>[
            Image.asset(
              "assets/raw/mock_profile_image.png",
              height: _Constants.imageSize,
              width: _Constants.imageSize,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
      trailing: Image.asset(
        "assets/icons/radio_button_default.png",
        height: _Constants.iconSize,
      ),
      contentPadding: _Constants.iconEdgePadding,
    );
  }
}

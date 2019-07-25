import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/profile/SwitchProfileItems.dart';
import 'package:flutter/material.dart';

class _Constants {
  static final String navCancelIcon = "assets/raw/nav_icon_cancel.png";
  static final String roundedButtonIcon = "assets/icons/profit_add.png";
}

class SwitchProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildSimpleAppBar(context),
      body: _buildBody(),
      floatingActionButton: _buildFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 32, top: 10, bottom: 36),
            child: Text(
              "Switch Profile",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xff1a1b46),
                fontSize: 27,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context , index ) => SwitchProfileItems(),
              separatorBuilder: (context, index) => ListDivider.build(),
              itemCount: 2),
        ],
      ),
    );
  }

  _buildFloatingButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 24, left: 24, bottom: 24),
      child: RoundedButton(
          viewModel:
              RoundedButtonViewModel(title: "Switch Profile Button", onTap: () {}),
          style: RoundedButtonStyle.largeRoundedButtonStyle()),
    );
  }

  AppBar _buildSimpleAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: FlatButton(
        onPressed: () => Navigator.pop(context, false),
        padding: EdgeInsets.only(left: 25),
        child: Image.asset(
          _Constants.navCancelIcon,
          height: 20,
          width: 20,
        ),
      ),
      actions: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: RoundedButton(
                viewModel: RoundedButtonViewModel(
                    icon: _Constants.roundedButtonIcon, onTap: () {}),
                style: RoundedButtonStyle.defaultStyle()),
          ),
        ),
      ],
    );
  }
}

import 'package:farmsmart_flutter/ui/common/LargeRoundedButtonStyle.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:flutter/material.dart';
import 'listDivider.dart';

class CustomAction {
  String text;
  IconData icon;
  Function action;

  CustomAction(this.text, this.action, {this.icon});
}

class ActionSheetViewModel {
    List<CustomAction> actions;
    String buttonTitle;

    ActionSheetViewModel(this.actions, this.buttonTitle);
}

abstract class ActionSheetStyle {
  final Color cornerColor;
  final Color backgroundColor;
  final TextStyle titleTextStyle;

  final EdgeInsets lineEdge;
  final Radius borderRadius;

  ActionSheetStyle(this.cornerColor, this.backgroundColor, this.titleTextStyle, this.lineEdge, this.borderRadius);
}

class DefaultStyle implements ActionSheetStyle {
  static const Color titleColor = Color(0xFF1a1b46);

  final Color cornerColor = const Color(0xFF737373);
  final Color backgroundColor = const Color(0xFFffffff);
  final TextStyle titleTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: titleColor);

  final EdgeInsets lineEdge = const EdgeInsets.only(top: 8);
  final Radius borderRadius = const Radius.circular(40);

  const DefaultStyle();
}

enum ActionSheetType {
  simple, withIcon, selection
}

class ActionSheet {
  static Widget build(BuildContext context, {ActionSheetStyle actionStyle = const DefaultStyle()}) {

    CustomAction renameCrop = CustomAction("dfg", null);
    CustomAction deleteCrop = CustomAction("DeleteCrop", null);
    ActionSheetViewModel viewModel = ActionSheetViewModel([renameCrop, deleteCrop], "Cancel");

    return Container(
      color: actionStyle.cornerColor, // This line set the transparent background
      child: Container(
        padding: actionStyle.lineEdge,
          decoration: BoxDecoration(
              color: actionStyle.backgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: actionStyle.borderRadius,
                  topRight: actionStyle.borderRadius
              )
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              buildDropLine(),
              SizedBox(height: 32),
              buildActionCell(actionStyle),
              ListDivider.build(),
              RoundedButton.build(style: LargeRoundedButtonStyle() ,context: context, title: viewModel.buttonTitle)
            ],
          )
    ));
  }

  static Widget buildDropLine() {
    return Container(
      height: 5,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.5),
        color: Color(0xFFe0e1ee),
      ),
    );
  }

  static Widget buildActionCell(ActionSheetStyle actionStyle) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: InkWell(
        onTap: () => print("dsfsdfdsf"),
        child: Container(
          padding: EdgeInsets.only(left: 32, right: 32.0),
          alignment: Alignment.center,
          height: 70,
          child: Row(children: <Widget>[
            Icon(Icons.exit_to_app),
            SizedBox(width: 21.5),
            Text("Record a new Sale", style: actionStyle.titleTextStyle)
          ],
          ),
        ),
      ),
    );
  }
}


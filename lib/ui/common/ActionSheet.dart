import 'package:farmsmart_flutter/ui/common/ActionSheetLargeRoundedButtonStyle.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:flutter/material.dart';
import 'ListDivider.dart';

class ActionListItemViewModel {
  String title;
  String icon;
  String selectionIcon;
  bool isHighlighted;
  Function action;

  ActionListItemViewModel(this.title, this.action, this.isHighlighted, {this.icon, this.selectionIcon});
}

class ActionSheetViewModel {
    List<ActionListItemViewModel> actions;
    String buttonTitle;

    ActionSheetViewModel(this.actions, this.buttonTitle);
}

abstract class ActionSheetStyle {
  final Color cornersColor;
  final Color backgroundColor;
  final Color dropLineColor;
  final Color cardBackgroundColor;

  final TextStyle mainTextStyle;
  final TextStyle highlightTextStyle;

  final EdgeInsets cardEdge;
  final EdgeInsets dropLineEdge;

  final Radius borderRadius;
  final Radius dropLineRadius;

  final double dropLineHeight;
  final double cardHeight;
  final double iconLineSpace;
  final double cardElevation;
  final double bigIconHeight;
  final double smallIconHeight;

  final int maxLines;

  ActionSheetStyle(this.cornersColor, this.backgroundColor, this.dropLineColor,
      this.cardBackgroundColor, this.mainTextStyle, this.highlightTextStyle,
      this.cardEdge, this.dropLineEdge, this.borderRadius, this.dropLineRadius,
      this.dropLineHeight, this.cardHeight, this.iconLineSpace,
      this.cardElevation, this.bigIconHeight, this.smallIconHeight,
      this.maxLines);
}

class DefaultStyle implements ActionSheetStyle {
  static const Color titleColor = Color(0xFF1a1b46);
  static const Color highlightColor = Color(0xFFff6060);

  final Color cornersColor = const Color(0xFF737373);
  final Color backgroundColor = const Color(0xFFffffff);
  final Color dropLineColor = const Color(0xFFe0e1ee);
  final Color cardBackgroundColor = const Color(0x00000000);

  final TextStyle mainTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: titleColor);
  final TextStyle highlightTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: highlightColor);

  final EdgeInsets cardEdge = const EdgeInsets.only(left: 32, right: 32);
  final EdgeInsets dropLineEdge = const EdgeInsets.only(left: 160, right: 160, top: 8, bottom: 50);
  
  final Radius borderRadius = const Radius.circular(40);
  final Radius dropLineRadius = const Radius.circular(2.5);

  final double dropLineHeight = 5;
  final double cardHeight = 70;
  final double iconLineSpace = 21.5;
  final double cardElevation = 0;
  final double bigIconHeight = 24;
  final double smallIconHeight = 16.5;

  final int maxLines = 1;

  const DefaultStyle();
}

class ActionSheet {
  static Widget build(BuildContext context, {ActionSheetStyle style = const DefaultStyle()}) {

    // FIXME: This would be injected in the call function. Every screen which need an ActionSheet has to have this CustomActions defined in its view model
    ActionListItemViewModel recordSale = ActionListItemViewModel("Record a new Sale", null, false, icon: "assets/icons/detail_icon_cost.png");
    ActionListItemViewModel recordCost = ActionListItemViewModel("Record a new Cost", null, false, icon: "assets/icons/flag_kenya.png", selectionIcon: "assets/icons/radio_button_active.png");
    ActionListItemViewModel testing = ActionListItemViewModel("Record a test", null, true);
    ActionSheetViewModel viewModel = ActionSheetViewModel([recordSale, recordCost, testing], "Cancel");

    /* FIXME: To make the modal bottom sheet autoresizable (without limit) needs to modify native file bottom_sheet
        @override
        BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
          return BoxConstraints(
            minWidth: constraints.maxWidth,
            maxWidth: constraints.maxWidth,
            minHeight: 0.0,
            maxHeight: constraints.maxHeight,
          );
  }*/

    return Container(
      color: style.cornersColor, // This line set the transparent background
        child: Container(
          decoration: BoxDecoration(
              color: style.backgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: style.borderRadius,
                  topRight: style.borderRadius
              )
          ),
          child: HeaderAndFooterListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: viewModel.actions.length,
              itemBuilder: (BuildContext context, int index) =>
            buildActionCell(style, viewModel.actions[index], viewModel.actions.length, index),
            header: buildDropLine(style),
            footer: RoundedButton.build(style: ActionSheetLargeRoundedButtonStyle(), context: context, title: viewModel.buttonTitle)
          )
    ));
  }

  static Widget buildDropLine(ActionSheetStyle style) {
    return Container(
      height: style.dropLineHeight,
      margin: style.dropLineEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(style.dropLineRadius),
        color: style.dropLineColor,
      ),
    );
  }

  static Widget buildActionCell(ActionSheetStyle style, ActionListItemViewModel viewModel, int numberOfActions, int currentAction) {
    return Column(
      children: <Widget>[
        Card(
          elevation: style.cardElevation,
          color: style.cardBackgroundColor,
          child: InkWell(
            onTap: () => print(viewModel.title),
            child: Container(
              padding: style.cardEdge,
              alignment: Alignment.center,
              height: style.cardHeight,
              child: Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: _buildActionContent(style, viewModel),
              ),
            ),
          ),
        ),
        currentAction == numberOfActions-1 ?  Wrap() : ListDivider.build(),
      ],
    );
  }

  static List<Widget> _buildActionContent(ActionSheetStyle style, ActionListItemViewModel viewModel) {
    List<Widget> listBuilder = [];
    if (viewModel.icon != null && viewModel.selectionIcon == null) {
      listBuilder.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(viewModel.icon, height: style.smallIconHeight),
          SizedBox(width: style.iconLineSpace),
          Text(viewModel.title, style: viewModel.isHighlighted ? style.highlightTextStyle : style.mainTextStyle)
        ],
      ));

    } else if (viewModel.selectionIcon != null) {
      listBuilder.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(children: <Widget>[
            Image.asset(viewModel.icon, height: style.bigIconHeight),
            SizedBox(width: style.iconLineSpace),
            Text(viewModel.title, style: viewModel.isHighlighted ? style.highlightTextStyle : style.mainTextStyle),
          ]),
          Image.asset(viewModel.selectionIcon, height: style.bigIconHeight)
        ],
      ));

    } else {
      listBuilder.add(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(viewModel.title, style: viewModel.isHighlighted ? style.highlightTextStyle : style.mainTextStyle),
        ],
      ));
    }
    return listBuilder;
  }
}



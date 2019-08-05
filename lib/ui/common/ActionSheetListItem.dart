import 'package:flutter/material.dart';

enum ActionType { simple, withIcon, selectable }

class ActionSheetListItemViewModel {
  String title;
  String icon;
  ActionType type;
  String checkBoxIcon;
  bool isSelected;
  bool isDestructive;
  Function onTap;

  ActionSheetListItemViewModel(
      {this.title,
      this.icon,
      this.type,
      this.checkBoxIcon,
      this.isSelected: false,
      this.isDestructive : false,
      this.onTap});
}

class ActionSheetListItemStyle {
  final String defaultCheckBox;
  final String activeCheckBox;
  final Color actionItemBackgroundColor;

  final TextStyle actionTextStyle;
  final TextStyle destructiveTextStyle;

  final EdgeInsets actionItemEdgePadding;

  final double actionItemHeight;
  final double iconLineSpace;
  final double actionItemElevation;
  final double iconHeight;

  final int maxLines;

  ActionSheetListItemStyle(
      {this.defaultCheckBox,
      this.activeCheckBox,
      this.actionItemBackgroundColor,
      this.actionTextStyle,
      this.destructiveTextStyle,
      this.actionItemEdgePadding,
      this.actionItemHeight,
      this.iconLineSpace,
      this.actionItemElevation,
      this.iconHeight,
      this.maxLines});

  factory ActionSheetListItemStyle.defaultStyle() {
    return ActionSheetListItemStyle(
      defaultCheckBox: "assets/icons/radio_button_default.png",
      activeCheckBox: "assets/icons/radio_button_active.png",
      actionItemBackgroundColor: const Color(0x00000000),
      actionTextStyle: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.normal,
          color: Color(0xFF1a1b46)),
      destructiveTextStyle: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.normal,
          color: Color(0xFFff6060)),
      actionItemEdgePadding: const EdgeInsets.symmetric(horizontal: 32),
      actionItemHeight: 30,
      iconLineSpace: 21.5,
      actionItemElevation: 0,
      iconHeight: 20,
      maxLines: 1,
    );
  }

  //TODO: Refactor style with new code style template
  factory ActionSheetListItemStyle.selectableStyle() {
    return ActionSheetListItemStyle.defaultStyle().copyWith(iconHeight: 24);
  }

  ActionSheetListItemStyle copyWith(
      {String defaultCheckBox,
      String activeCheckbox,
      Color actionItemBackgroundColor,
      TextStyle actionTextStyle,
      TextStyle destructiveTextStyle,
      EdgeInsets actionItemEdgePadding,
      double actionItemHeight,
      double iconLineSpace,
      double actionItemElevation,
      double iconHeight,
      int maxLines}) {
    return ActionSheetListItemStyle(
        defaultCheckBox: defaultCheckBox ?? this.defaultCheckBox,
        activeCheckBox: activeCheckbox ?? this.activeCheckBox,
        actionItemBackgroundColor:
            actionItemBackgroundColor ?? this.actionItemBackgroundColor,
        actionTextStyle: actionTextStyle ?? this.actionTextStyle,
        destructiveTextStyle: destructiveTextStyle ?? this.destructiveTextStyle,
        actionItemEdgePadding:
            actionItemEdgePadding ?? this.actionItemEdgePadding,
        actionItemHeight: actionItemHeight ?? this.actionItemHeight,
        iconLineSpace: iconLineSpace ?? this.iconLineSpace,
        actionItemElevation: actionItemElevation ?? this.actionItemElevation,
        iconHeight: iconHeight ?? this.iconHeight,
        maxLines: maxLines ?? this.maxLines);
  }
}

class ActionSheetListItem extends StatelessWidget {
  final ActionSheetListItemViewModel _viewModel;
  static ActionSheetListItemStyle _style;

  const ActionSheetListItem({Key key, ActionSheetListItemViewModel viewModel})
      : this._viewModel = viewModel,
        super(key: key);

  Widget build(BuildContext context) {
    switch (_viewModel.type) {
      case ActionType.withIcon:
        _style = ActionSheetListItemStyle.defaultStyle();
        break;
      case ActionType.selectable:
        _style = ActionSheetListItemStyle.selectableStyle();
        break;
      default:
        _style = ActionSheetListItemStyle.defaultStyle();
    }

    return Card(
      elevation: _style.actionItemElevation,
      color: _style.actionItemBackgroundColor,
      child: Container(
        padding: _style.actionItemEdgePadding,
        alignment: Alignment.center,
        height: _style.actionItemHeight,
        child: Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _buildActionContent(_style, _viewModel)),
            ]),
      ),
    );
  }

  static List<Widget> _buildActionContent(
      ActionSheetListItemStyle style, ActionSheetListItemViewModel viewModel) {
    List<Widget> listBuilder = [];

    if (viewModel.icon != null) {
      listBuilder.add(Image.asset(viewModel.icon, height: style.iconHeight));
      listBuilder.add(SizedBox(width: style.iconLineSpace));
    }

    if (viewModel.title != null) {
      listBuilder.add(Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(viewModel.title,
                style: viewModel.isDestructive
                    ? style.destructiveTextStyle
                    : style.actionTextStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 1),
          ],
        ),
      ));
    }

    // TODO: add icons inside the style
    if (viewModel.checkBoxIcon != null) {
      var checkBoxIcon;
      viewModel.isSelected
          ? checkBoxIcon = style.activeCheckBox
          : checkBoxIcon = style.defaultCheckBox;

      listBuilder.add(SizedBox(width: style.iconLineSpace));
      listBuilder.add(Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[Image.asset(checkBoxIcon, height: style.iconHeight)],
      ));
    }
    return listBuilder;
  }
}

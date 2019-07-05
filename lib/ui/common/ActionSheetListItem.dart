import 'package:flutter/material.dart';

enum ActionType {
  simple,
  withIcon,
  selectable
}

class ActionSheetListItemViewModel {
  String title;
  String icon;
  ActionType type;
  String checkBoxIcon;
  bool isSelected;
  bool isDestructive;
  Function onTap;

  ActionSheetListItemViewModel({this.title, this.icon, this.type,
      this.checkBoxIcon, this.isSelected, this.isDestructive, this.onTap});
}

class ActionSheetListItemStyle {
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
      {this.actionItemBackgroundColor,
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
      actionItemHeight: 70,
      iconLineSpace: 21.5,
      actionItemElevation: 0,
      iconHeight: 20,
      maxLines: 1,
    );
  }

  factory ActionSheetListItemStyle.selectableStyle() {
    return ActionSheetListItemStyle.defaultStyle().copyWith(iconHeight: 24);
  }

  ActionSheetListItemStyle copyWith(
      {Color actionItemBackgroundColor,
      TextStyle actionTextStyle,
      TextStyle destructiveTextStyle,
      EdgeInsets actionItemEdgePadding,
      double actionItemHeight,
      double iconLineSpace,
      double actionItemElevation,
      double iconHeight,
      int maxLines}) {
    return ActionSheetListItemStyle(
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

class ActionSheetListItem extends StatefulWidget {
  final ActionSheetListItemViewModel _viewModel;

  const ActionSheetListItem({ActionSheetListItemViewModel viewModel}) : this._viewModel = viewModel;

  @override
  _ActionSheetListItemState createState() => _ActionSheetListItemState(_viewModel);
}


class _ActionSheetListItemState extends State<ActionSheetListItem> {
  final ActionSheetListItemViewModel _viewModel;
  ActionSheetListItemStyle _style;

  _ActionSheetListItemState(this._viewModel);

  @override
  void initState() {
    super.initState();
    setState(() {
      _viewModel.isSelected = !_viewModel.isSelected;
    });
  }

  Widget build(BuildContext context) {
    switch(_viewModel.type) {
      case ActionType.simple:
        _style = ActionSheetListItemStyle.defaultStyle();
        break;
      case ActionType.withIcon:
        _style = ActionSheetListItemStyle.defaultStyle();
        break;
      case ActionType.selectable:
        _style = ActionSheetListItemStyle.selectableStyle();
        break;
    }

    return Column(
      children: <Widget>[
        Card(
          elevation: _style.actionItemElevation,
          color: _style.actionItemBackgroundColor,
          child: InkWell(
            onTap: () => checkTap(),
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
          ),
        ),
      ],
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

    if (viewModel.checkBoxIcon != null) {
      var checkbox = "assets/icons/radio_button_default.png";
      viewModel.isSelected ? checkbox = "assets/icons/radio_button_active.png" : checkbox = "assets/icons/radio_button_default.png";

      listBuilder.add(SizedBox(width: style.iconLineSpace));
      listBuilder.add(Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Image.asset(checkbox, height: style.iconHeight)
        ],
      ));
    }
    return listBuilder;
  }

  void checkTap() {
    if (_viewModel.type == ActionType.selectable) {
      setState(() {
        _viewModel.isSelected = !_viewModel.isSelected;
        print("1");
      });
    } else {
      _viewModel.onTap;
    }
  }
}


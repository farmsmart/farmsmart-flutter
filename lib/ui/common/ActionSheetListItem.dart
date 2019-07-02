import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:flutter/material.dart';

class ActionSheetListItemViewModel {
  String title;
  String icon;
  String checkBoxIcon;
  bool isDestructive;
  Function action;

  ActionSheetListItemViewModel(this.title, this.action, this.isDestructive, {this.icon, this.checkBoxIcon});
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

  ActionSheetListItemStyle({this.actionItemBackgroundColor, this.actionTextStyle,
      this.destructiveTextStyle, this.actionItemEdgePadding,
      this.actionItemHeight, this.iconLineSpace, this.actionItemElevation,
      this.iconHeight, this.maxLines});

  factory ActionSheetListItemStyle.defaultStyle() {
    return ActionSheetListItemStyle(
      actionItemBackgroundColor: const Color(0x00000000),
      actionTextStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Color(0xFF1a1b46)),
      destructiveTextStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Color(0xFFff6060)),
      actionItemEdgePadding: const EdgeInsets.symmetric(horizontal: 32),
      actionItemHeight: 70,
      iconLineSpace: 21.5,
      actionItemElevation: 0,
      iconHeight: 16.5,
      maxLines: 1,
    );
  }

  factory ActionSheetListItemStyle.selectableStyle() {
    return ActionSheetListItemStyle.defaultStyle().copyWith(iconHeight: 24);
  }

  ActionSheetListItemStyle copyWith({Color actionItemBackgroundColor, TextStyle actionTextStyle,
    TextStyle destructiveTextStyle, EdgeInsets actionItemEdgePadding,
    double actionItemHeight, double iconLineSpace, double actionItemElevation,
    double iconHeight, int maxLines}) {

    return ActionSheetListItemStyle(
      actionItemBackgroundColor: actionItemBackgroundColor ?? this.actionItemBackgroundColor,
      actionTextStyle: actionTextStyle ?? this.actionTextStyle,
      destructiveTextStyle: destructiveTextStyle ?? this.destructiveTextStyle,
      actionItemEdgePadding: actionItemEdgePadding ?? this. actionItemEdgePadding,
        actionItemHeight: actionItemHeight ?? this.actionItemHeight,
        iconLineSpace: iconLineSpace ?? this.iconLineSpace,
        actionItemElevation: actionItemElevation ?? this.actionItemElevation,
        iconHeight: iconHeight ?? this.iconHeight,
        maxLines: maxLines ?? this.maxLines
    );
  }
}


class ActionSheetListItem extends StatelessWidget {
  final ActionSheetListItemViewModel _viewModel;
  final ActionSheetListItemStyle _style;
  final int _numberOfItems;
  final int _currentItem;

  const ActionSheetListItem({Key key, ActionSheetListItemViewModel viewModel, ActionSheetListItemStyle style, int numberOfActions, int currentAction}) : this._viewModel = viewModel, this._style = style, this._numberOfItems = numberOfActions, this._currentItem = currentAction, super(key: key);

  static Widget _build(ActionSheetListItemStyle style, ActionSheetListItemViewModel viewModel, int numberOfActions, int currentAction) {
    return Column(
      children: <Widget>[
        Card(
          elevation: style.actionItemElevation,
          color: style.actionItemBackgroundColor,
          child: InkWell(
            onTap: () => viewModel.action,
            child: Container(
              padding: style.actionItemEdgePadding,
              alignment: Alignment.center,
              height: style.actionItemHeight,
              child: Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: _buildActionContent(style, viewModel)
                    ),
                  ]),
            ),
          ),
        ),
        currentAction == numberOfActions - 1 ? Wrap() : ListDivider.build(), // FIXME: temporal solution for divider
      ],
    );
  }

  static List<Widget> _buildActionContent(ActionSheetListItemStyle style, ActionSheetListItemViewModel viewModel) {
    List<Widget> listBuilder = [];

    if (viewModel.icon != null) {
      listBuilder.add(Image.asset(viewModel.icon, height: style.iconHeight));
      listBuilder.add(SizedBox(width: style.iconLineSpace));

    } if (viewModel.title != null) {
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

    } if (viewModel.checkBoxIcon != null) {
      listBuilder.add(SizedBox(width: style.iconLineSpace));
      listBuilder.add(Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Image.asset(viewModel.checkBoxIcon, height: style.iconHeight)
        ],
      ));
    }
    return listBuilder;
  }


  @override
  Widget build(BuildContext context) {
    return _build(_style, _viewModel, _numberOfItems, _currentItem);
  }

}
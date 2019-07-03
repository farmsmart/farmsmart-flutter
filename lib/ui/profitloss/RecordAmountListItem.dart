import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:flutter/material.dart';

enum CellType {
  pickDate,
  pickCrop,
  addText
}

class RecordAmountListItemViewModel {
  String icon;
  String title;
  String detail;
  String arrow;
  CellType cellType;

  RecordAmountListItemViewModel(this.icon, this.title, {this.detail, this.arrow});
}

class RecordAmountListItemStyle {
  final Color actionItemBackgroundColor;

  final TextStyle titleTextStyle;
  final TextStyle pendingTitleTextStyle;
  final TextStyle detailTextStyle;
  final TextStyle pendingDetailTextStyle;

  final EdgeInsets actionItemEdgePadding;

  final double actionItemHeight;
  final double iconLineSpace;
  final double actionItemElevation;
  final double iconHeight;

  final int maxLines;

  RecordAmountListItemStyle({this.actionItemBackgroundColor, this.titleTextStyle,
      this.pendingTitleTextStyle, this.detailTextStyle,
      this.pendingDetailTextStyle, this.actionItemEdgePadding,
      this.actionItemHeight, this.iconLineSpace, this.actionItemElevation,
      this.iconHeight, this.maxLines});

  factory RecordAmountListItemStyle.defaultStyle() {
    return RecordAmountListItemStyle(
      actionItemBackgroundColor: const Color(0x00000000),
      titleTextStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Color(0xFF1a1b46)),
      pendingTitleTextStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Color(0xFF767690)),
      detailTextStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Color(0x4c767690)),
      pendingDetailTextStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Color(0xFF767690)),
      actionItemEdgePadding: const EdgeInsets.symmetric(horizontal: 32),
      actionItemHeight: 70,
      iconLineSpace: 22,
      actionItemElevation: 0,
      iconHeight: 20,
      maxLines: 1,
    );
  }

  factory RecordAmountListItemStyle.fillStype() {
    return RecordAmountListItemStyle.defaultStyle().copyWith(
      actionItemHeight: 168,
    );
  }


  RecordAmountListItemStyle copyWith({Color actionItemBackgroundColor, TextStyle titleTextStyle,
    TextStyle pendingTitleTextStyle, TextStyle detailTextStyle,
    TextStyle pendingDetailTextStyle, EdgeInsets actionItemEdgePadding,
    double actionItemHeight, double iconLineSpace, double actionItemElevation,
    double iconHeight, int maxLines}) {

    return RecordAmountListItemStyle(
        actionItemBackgroundColor: actionItemBackgroundColor ?? this.actionItemBackgroundColor,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        pendingTitleTextStyle: pendingTitleTextStyle ?? this.pendingTitleTextStyle,
        detailTextStyle: detailTextStyle ?? this.detailTextStyle,
        pendingDetailTextStyle: pendingDetailTextStyle ?? this.pendingDetailTextStyle,
        actionItemEdgePadding: actionItemEdgePadding ?? this.actionItemEdgePadding,
        actionItemHeight: actionItemHeight ?? this.actionItemHeight,
        iconLineSpace: iconLineSpace ?? this.iconLineSpace,
        actionItemElevation: actionItemElevation ?? this.actionItemElevation,
        iconHeight: iconHeight ?? this.iconHeight,
        maxLines: maxLines ?? this.maxLines
    );
  }
}


class RecordAmountListItem extends StatelessWidget {
  final RecordAmountListItemViewModel _viewModel;
  final RecordAmountListItemStyle _style;
  final int _numberOfItems;
  final int _currentItem;

  const RecordAmountListItem({Key key, RecordAmountListItemViewModel viewModel, RecordAmountListItemStyle style, int numberOfActions, int currentAction}) : this._viewModel = viewModel, this._style = style, this._numberOfItems = numberOfActions, this._currentItem = currentAction, super(key: key);

  static Widget _build(RecordAmountListItemStyle style, RecordAmountListItemViewModel viewModel, int numberOfActions, int currentAction) {
    return Column(
      children: <Widget>[
        Card(
          elevation: style.actionItemElevation,
          color: style.actionItemBackgroundColor,
          child: InkWell(
            onTap: () => print("hud"),
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

  static List<Widget> _buildActionContent(RecordAmountListItemStyle style, RecordAmountListItemViewModel viewModel) {
    List<Widget> listBuilder = [];

    if (viewModel.icon != null) {
        listBuilder.add(Image.asset(viewModel.icon, height: style.iconHeight));
        listBuilder.add(SizedBox(width: style.iconLineSpace));

    } if (viewModel.title != null) {
      if (viewModel.detail == null) {
        listBuilder.add(Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                  decoration: InputDecoration.collapsed(hintText: viewModel.title, hintStyle: style.pendingTitleTextStyle),
                  style: style.titleTextStyle,
                  //overflow: TextOverflow.ellipsis,
                  maxLines: 5),
            ],
          ),
        ));
      } else {
        listBuilder.add(Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(viewModel.title,
                  style: style.titleTextStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
            ],
          ),
        ));
      }
    } if (viewModel.detail != null) {
      listBuilder.add(Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
                decoration: InputDecoration.collapsed(hintText: viewModel.detail),
                style: style.detailTextStyle,
                //overflow: TextOverflow.ellipsis,
                maxLines: 1),
          ],
        ),
      ));
    } if (viewModel.arrow != null) {
      listBuilder.add(SizedBox(width: style.iconLineSpace));
      listBuilder.add(Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Image.asset(viewModel.arrow, height: 13)
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
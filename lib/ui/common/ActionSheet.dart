import 'package:farmsmart_flutter/ui/common/ActionSheetLargeRoundedButtonStyle.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheetListItem.dart';
import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/mockData/MockActionSheetViewModel.dart';
import 'package:flutter/material.dart';

class ActionSheetViewModel {
  List<ActionSheetListItemViewModel> actions;
  String cancelButtonTitle;
  String confirmButtonTitle;

  ActionSheetViewModel(this.actions, this.cancelButtonTitle,
  {this.confirmButtonTitle});
}

class ActionSheetStyle {
  final Color backgroundColor;
  final Color indicatorLineColor;
  final Color confirmButtonBackgroundColor;
  final Color cancelButtonBackgroundColor;

  final EdgeInsets indicatorLineEdgePadding;

  final Radius cornerRadius;
  final Radius indicatorLineRadius;

  final double indicatorLineThickness;
  final double indicatorLineWidth;

  ActionSheetStyle(
      {this.backgroundColor,
      this.indicatorLineColor,
      this.confirmButtonBackgroundColor,
      this.cancelButtonBackgroundColor,
      this.indicatorLineEdgePadding,
      this.cornerRadius,
      this.indicatorLineRadius,
      this.indicatorLineThickness,
      this.indicatorLineWidth});

  factory ActionSheetStyle.defaultStyle() {
    return ActionSheetStyle(
      backgroundColor: const Color(0xFFffffff),
      indicatorLineColor: const Color(0xFFe0e1ee),
      confirmButtonBackgroundColor: const Color(0xFF24d900),
      cancelButtonBackgroundColor: const Color(0xFFe9eaf2),
      indicatorLineEdgePadding: const EdgeInsets.only(top: 8, bottom: 50),
      cornerRadius: const Radius.circular(40),
      indicatorLineRadius: const Radius.circular(2.5),
      indicatorLineThickness: 5,
      indicatorLineWidth: 40,
    );
  }

  ActionSheetStyle copyWith(
      {Color backgroundColor,
      Color indicatorLineColor,
      Color confirmButtonBackgroundColor,
      Color cancelButtonBackgroundColor,
      EdgeInsets indicatorLineEdgePadding,
      Radius cornerRadius,
      Radius indicatorLineRadius,
      double indicatorLineThickness,
      double indicatorLineWidth}) {
    return ActionSheetStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      indicatorLineColor: indicatorLineColor ?? this.indicatorLineColor,
      confirmButtonBackgroundColor:
          confirmButtonBackgroundColor ?? this.confirmButtonBackgroundColor,
      cancelButtonBackgroundColor:
          cancelButtonBackgroundColor ?? this.cancelButtonBackgroundColor,
      indicatorLineEdgePadding:
          indicatorLineEdgePadding ?? this.indicatorLineEdgePadding,
      cornerRadius: cornerRadius ?? this.cornerRadius,
      indicatorLineRadius: indicatorLineRadius ?? this.indicatorLineRadius,
      indicatorLineThickness:
          indicatorLineThickness ?? this.indicatorLineThickness,
      indicatorLineWidth: indicatorLineWidth ?? this.indicatorLineWidth,
    );
  }
}

class ActionSheet extends StatelessWidget {
  final ActionSheetViewModel _viewModel;
  final ActionSheetStyle _style;

  const ActionSheet({Key key, ActionSheetViewModel viewModel, ActionSheetStyle style}) : this._viewModel = viewModel, this._style = style, super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color cornersColor = const Color(0xFF737373);
    return Container(
        color: cornersColor,
        child: Container(
            decoration: BoxDecoration(
                color: _style.backgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: _style.cornerRadius,
                    topRight: _style.cornerRadius)),
            child: Column(
              children: buildCells(_style, _viewModel),
    ))
    );
  }

  static List<Widget> buildCells(ActionSheetStyle style, ActionSheetViewModel viewModel) {
    List<Widget> listBuilder = [];

    listBuilder.add(_buildIndicatorLine(style));
    for (var action in viewModel.actions) {
      switch (action.type) {
        case ActionType.simple:
          listBuilder.add(ActionSheetListItem(style: ActionSheetListItemStyle.defaultStyle(),
              viewModel: ActionSheetListItemViewModel(title: action.title, onTap: action.onTap, isDestructive: action.isDestructive, type: action.type)));
          break;
        case ActionType.withIcon:
          listBuilder.add(ActionSheetListItem(style: ActionSheetListItemStyle.defaultStyle(),
              viewModel: ActionSheetListItemViewModel(title: action.title, onTap: action.onTap, icon: action.icon, isDestructive: action.isDestructive, type: action.type)));
          break;
        case ActionType.selectable:
          listBuilder.add(ActionSheetListItem(style: ActionSheetListItemStyle.selectableStyle(),
              viewModel: ActionSheetListItemViewModel(title: action.title, onTap: action.onTap, icon: action.icon, checkBoxIcon: action.checkBoxIcon, isDestructive: action.isDestructive, type: action.type, isSelected: false)));
          break;
        }

      if (action != viewModel.actions.last) {
        listBuilder.add(ListDivider.build());
      }
    }

    listBuilder.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
               RoundedButton.build(RoundedButtonViewModel(title: viewModel.cancelButtonTitle),
                   style: ActionSheetLargeRoundedButtonStyle()),
               RoundedButton.build(RoundedButtonViewModel(title: viewModel.confirmButtonTitle),
                   style: ActionSheetLargeRoundedButtonStyle())
          ],
        ));

    return listBuilder;
  }

  static Widget _buildIndicatorLine(ActionSheetStyle style) {
    return Center(
      child: Container(
        margin: style.indicatorLineEdgePadding,
        width: style.indicatorLineWidth,
        height: style.indicatorLineThickness,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(style.indicatorLineRadius),
          color: style.indicatorLineColor,
        ),
      ),
    );
  }
}

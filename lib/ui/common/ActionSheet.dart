import 'package:farmsmart_flutter/ui/common/ActionSheetLargeRoundedButtonStyle.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheetListItem.dart';
import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/mockData/MockActionSheetViewModel.dart';
import 'package:flutter/material.dart';

class ActionSheetViewModel {
  List<ActionSheetListItemViewModel> actions;
  String confirmButtonTitle;
  String cancelButtonTitle;

  ActionSheetViewModel(this.actions, this.confirmButtonTitle,
      {this.cancelButtonTitle});
}

class ActionSheetStyle {
  final Color cornersColor = const Color(0xFF737373);
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
  final ActionSheetListItemStyle _cellStyle;

  const ActionSheet(
      {Key key,
      ActionSheetViewModel viewModel,
      ActionSheetStyle style,
      ActionSheetListItemStyle cellStyle})
      : this._viewModel = viewModel,
        this._style = style,
        this._cellStyle = cellStyle,
        super(key: key);

  static Widget _build(BuildContext context, ActionSheetViewModel viewModel,
      ActionSheetStyle style, ActionSheetListItemStyle cellStyle) {
    return Container(
        color: style.cornersColor,
        child: Container(
            decoration: BoxDecoration(
                color: style.backgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: style.cornerRadius, topRight: style.cornerRadius)),
            child: HeaderAndFooterListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: viewModel.actions.length,
                itemBuilder: (BuildContext context, int index) =>
                    ActionSheetListItem(
                        viewModel: ActionSheetListItemViewModel(
                            viewModel.actions[index].title,
                            viewModel.actions[index].action,
                            viewModel.actions[index].isDestructive,
                            icon: viewModel.actions[index].icon,
                            checkBoxIcon:
                                viewModel.actions[index].checkBoxIcon),
                        style: cellStyle,
                        numberOfActions: viewModel.actions.length,
                        currentAction: index),
                header: _buildIndicatorLine(style),
                footer: RoundedButton.build(
                    RoundedButtonViewModel(title: viewModel.confirmButtonTitle),
                    style: ActionSheetLargeRoundedButtonStyle()))));
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

  @override
  Widget build(BuildContext context) {
    return _build(context, _viewModel, _style, _cellStyle);
  }
}

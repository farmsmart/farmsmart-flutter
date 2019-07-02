import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/mockData/MockActionSheetViewModel.dart';
import 'package:flutter/material.dart';

class ActionListItemViewModel {
  String title;
  String icon;
  String checkBoxIcon;
  bool isDestructive;
  Function action;

  ActionListItemViewModel(this.title, this.action, this.isDestructive, {this.icon, this.checkBoxIcon});
}

class ActionSheetViewModel {
  List<ActionListItemViewModel> actions;
  String confirmButtonTitle;
  String cancelButtonTitle;

  ActionSheetViewModel(this.actions, this.confirmButtonTitle, {this.cancelButtonTitle});
}

class ActionSheetStyle {
  final Color cornersColor = const Color(0xFF737373);
  final Color backgroundColor;
  final Color indicatorLineColor;
  final Color actionItemBackgroundColor;
  final Color confirmButtonBackgroundColor;
  final Color cancelButtonBackgroundColor;

  final TextStyle actionTextStyle;
  final TextStyle destructiveTextStyle;

  final EdgeInsets actionItemEdgePadding;
  final EdgeInsets indicatorLineEdgePadding;

  final Radius cornerRadius;
  final Radius indicatorLineRadius;

  final double indicatorLineThickness;
  final double actionItemHeight;
  final double iconLineSpace;
  final double actionItemElevation;
  final double iconHeight;

  final int maxLines;

  ActionSheetStyle({this.backgroundColor, this.indicatorLineColor,
      this.actionItemBackgroundColor, this.confirmButtonBackgroundColor,
      this.cancelButtonBackgroundColor, this.actionTextStyle,
      this.destructiveTextStyle, this.actionItemEdgePadding,
      this.indicatorLineEdgePadding, this.cornerRadius, this.indicatorLineRadius,
      this.indicatorLineThickness, this.actionItemHeight, this.iconLineSpace,
      this.actionItemElevation, this.iconHeight, this.maxLines});

  factory ActionSheetStyle.defaultStyle() {
    return ActionSheetStyle(
      backgroundColor: const Color(0xFFffffff),
      indicatorLineColor: const Color(0xFFe0e1ee),
      actionItemBackgroundColor: const Color(0x00000000),
      confirmButtonBackgroundColor: const Color(0xFF24d900),
      cancelButtonBackgroundColor: const Color(0xFFe9eaf2),
      actionTextStyle: const TextStyle(fontSize: 17,
          fontWeight: FontWeight.normal,
          color: Color(0xFF1a1b46)),
      destructiveTextStyle: const TextStyle(fontSize: 17,
          fontWeight: FontWeight.normal,
          color: Color(0xFFff6060)),
      actionItemEdgePadding: const EdgeInsets.symmetric(horizontal: 32),
      indicatorLineEdgePadding: const EdgeInsets.only(top: 8, bottom: 50),
      cornerRadius: const Radius.circular(40),
      indicatorLineRadius: const Radius.circular(2.5),
      indicatorLineThickness: 5,
      actionItemHeight: 70,
      iconLineSpace: 21.5,
      actionItemElevation: 0,
      iconHeight: 16.5,
      maxLines: 1,
    );
  }

  factory ActionSheetStyle.selectableStyle() {
    return ActionSheetStyle.defaultStyle().copyWith(iconHeight: 24);
  }

  ActionSheetStyle copyWith({Color backgroundColor, Color indicatorLineColor,
    Color actionItemBackgroundColor, Color confirmButtonBackgroundColor, Color cancelButtonBackgroundColor,
    TextStyle actionTextStyle, TextStyle destructiveTextStyle, EdgeInsets actionItemEdgePadding,
    EdgeInsets indicatorLineEdgePadding, Radius cornerRadius, Radius indicatorLineRadius,
    double indicatorLineThickness, double actionItemHeight, double iconLineSpace,
    double actionItemElevation, double iconHeight, int maxLines}) {

    return ActionSheetStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        indicatorLineColor: indicatorLineColor ?? this.indicatorLineColor,
        actionItemBackgroundColor: actionItemBackgroundColor ?? this.actionItemBackgroundColor,
        confirmButtonBackgroundColor: confirmButtonBackgroundColor ?? this.confirmButtonBackgroundColor,
        cancelButtonBackgroundColor: cancelButtonBackgroundColor ?? this.cancelButtonBackgroundColor,
        actionTextStyle: actionTextStyle ?? this.actionTextStyle,
        destructiveTextStyle: destructiveTextStyle ?? this.destructiveTextStyle,
        actionItemEdgePadding: actionItemEdgePadding ?? this. actionItemEdgePadding,
        indicatorLineEdgePadding: indicatorLineEdgePadding ?? this.indicatorLineEdgePadding,
        cornerRadius: cornerRadius ?? this.cornerRadius,
        indicatorLineRadius: indicatorLineRadius ?? this.indicatorLineRadius,
        indicatorLineThickness: indicatorLineThickness ?? this.indicatorLineThickness,
        actionItemHeight: actionItemHeight ?? this.actionItemHeight,
        iconLineSpace: iconLineSpace ?? this.iconLineSpace,
        actionItemElevation: actionItemElevation ?? this.actionItemElevation,
        iconHeight: iconHeight ?? this.iconHeight,
        maxLines: maxLines ?? this.maxLines
    );
  }
}

class ActionSheet extends StatelessWidget{
  final ActionSheetViewModel _viewModel;
  final ActionSheetStyle _style;

  const ActionSheet({Key key, ActionSheetViewModel viewModel, ActionSheetStyle style}) : this._viewModel = viewModel, this._style = style, super(key: key);

  static Widget _build(BuildContext context, ActionSheetViewModel viewModel, ActionSheetStyle style) {
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
                    _buildActionCell(style, viewModel.actions[index],
                        viewModel.actions.length, index),
                header: _buildIndicatorLine(style),
                footer: RoundedButton(viewModel: RoundedButtonViewModel(title: viewModel.confirmButtonTitle),
                    style: RoundedButtonStyle.actionSheetLargeRoundedButton()))
        ));
  }



  static Widget _buildIndicatorLine(ActionSheetStyle style) {
    return Center(
      child: Container(
        margin: style.indicatorLineEdgePadding,
        width: 100,
        height: style.indicatorLineThickness,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(style.indicatorLineRadius),
          color: style.indicatorLineColor,
        ),
      ),
    );
  }

  static Widget _buildActionCell(ActionSheetStyle style, ActionListItemViewModel viewModel,
      int numberOfActions, int currentAction) {
    return Column(
      children: <Widget>[
        Card(
          elevation: style.actionItemElevation,
          color: style.actionItemBackgroundColor,
          child: InkWell(
            onTap: () => print(viewModel.title), //No mock here -> View Model
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
        currentAction == numberOfActions - 1 ? Wrap() : ListDivider.build(),
      ],
    );
  }

  static List<Widget> _buildActionContent(ActionSheetStyle style, ActionListItemViewModel viewModel) {
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
    return _build(context, _viewModel, _style);
  }

  //FIXME: To show ActionBottomSheet (need to implement)
  Future _onMenuPressed(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (widgetBuilder) =>  ActionSheet(viewModel: MockProfitLossListViewModel.build(), style: ActionSheetStyle.defaultStyle())
    );
  }
}

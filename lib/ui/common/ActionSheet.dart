import 'package:farmsmart_flutter/ui/common/ActionSheetListItem.dart';
import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:flutter/material.dart';

class _Constants {
  static final Color cornersColor = const Color(0xFF737373);
}

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

  final TextStyle confirmButtonTextStyle;

  final EdgeInsets indicatorLineEdgePadding;
  final EdgeInsets edgePadding;

  final Radius cornerRadius;
  final Radius indicatorLineRadius;

  final double indicatorLineThickness;
  final double indicatorLineWidth;
  final double buttonSpacing;

  ActionSheetStyle(
      {this.backgroundColor,
      this.indicatorLineColor,
      this.confirmButtonBackgroundColor,
      this.cancelButtonBackgroundColor,
        this.confirmButtonTextStyle,
      this.indicatorLineEdgePadding,
      this.edgePadding,
      this.cornerRadius,
      this.indicatorLineRadius,
      this.indicatorLineThickness,
      this.indicatorLineWidth,
      this.buttonSpacing});

  factory ActionSheetStyle.defaultStyle() {
    return ActionSheetStyle(
        backgroundColor: const Color(0xFFffffff),
        indicatorLineColor: const Color(0xFFe0e1ee),
        confirmButtonBackgroundColor: const Color(0xFF24d900),
        cancelButtonBackgroundColor: const Color(0xFFe9eaf2),
        confirmButtonTextStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(0xFFffffff)),
        indicatorLineEdgePadding: const EdgeInsets.only(top: 8, bottom: 50),
        edgePadding:
            const EdgeInsets.only(left: 32, top: 31, right: 32, bottom: 32),
        cornerRadius: const Radius.circular(40),
        indicatorLineRadius: const Radius.circular(2.5),
        indicatorLineThickness: 5,
        indicatorLineWidth: 40,
        buttonSpacing: 16);
  }

  ActionSheetStyle copyWith(
      {Color backgroundColor,
      Color indicatorLineColor,
      Color confirmButtonBackgroundColor,
      Color cancelButtonBackgroundColor,
      TextStyle confirmButtonTextStyle,
      EdgeInsets indicatorLineEdgePadding,
      EdgeInsets edgePadding,
      Radius cornerRadius,
      Radius indicatorLineRadius,
      double indicatorLineThickness,
      double indicatorLineWidth,
      double buttonSpacing}) {
    return ActionSheetStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        indicatorLineColor: indicatorLineColor ?? this.indicatorLineColor,
        confirmButtonBackgroundColor:
            confirmButtonBackgroundColor ?? this.confirmButtonBackgroundColor,
        cancelButtonBackgroundColor:
            cancelButtonBackgroundColor ?? this.cancelButtonBackgroundColor,
        confirmButtonTextStyle : confirmButtonTextStyle ?? this.confirmButtonTextStyle,
        indicatorLineEdgePadding:
            indicatorLineEdgePadding ?? this.indicatorLineEdgePadding,
        edgePadding: edgePadding ?? this.edgePadding,
        cornerRadius: cornerRadius ?? this.cornerRadius,
        indicatorLineRadius: indicatorLineRadius ?? this.indicatorLineRadius,
        indicatorLineThickness:
            indicatorLineThickness ?? this.indicatorLineThickness,
        indicatorLineWidth: indicatorLineWidth ?? this.indicatorLineWidth,
        buttonSpacing: buttonSpacing ?? this.buttonSpacing);
  }
}

class ActionSheet extends StatefulWidget {
  final ActionSheetViewModel _viewModel;
  final ActionSheetStyle _style;

  const ActionSheet(
      {Key key, ActionSheetViewModel viewModel, ActionSheetStyle style})
      : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  _ActionSheetState createState() => _ActionSheetState(_viewModel, _style);
}

class _ActionSheetState extends State<ActionSheet> {
  final ActionSheetViewModel _viewModel;
  final ActionSheetStyle _style;

  _ActionSheetState(this._viewModel, this._style);

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
        color: _Constants.cornersColor, //TODO: check the real corners color
        child: Container(
            decoration: BoxDecoration(
                color: _style.backgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: _style.cornerRadius,
                    topRight: _style.cornerRadius)),
            child: Column(
              children: <Widget>[
                _buildIndicatorLine(_style),
                Expanded(
                  child: _buildList(_style, _viewModel),
                ),
                Padding(
                  padding: _style.edgePadding,
                  child: Row(
                    children: _buildListFooter(_style, _viewModel, context),
                  ),
                ),
              ],
            )));
  }

  Widget _buildIndicatorLine(ActionSheetStyle style) {
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

  Widget _buildList(ActionSheetStyle style, ActionSheetViewModel viewModel) {
    return ListView.separated(
      itemCount: viewModel.actions.length,
      itemBuilder: (context, index) => ListTile(
            title: ActionSheetListItem(
                viewModel: ActionSheetListItemViewModel(
                    title: viewModel.actions[index].title,
                    icon: viewModel.actions[index].icon,
                    type: viewModel.actions[index].type,
                    checkBoxIcon: viewModel.actions[index].checkBoxIcon,
                    isSelected: viewModel.actions[index].isSelected,
                    isDestructive: viewModel.actions[index].isDestructive,
                    onTap: viewModel.actions[index].onTap)),
            onTap: () => select(index),
          ),
      separatorBuilder: (context, index) => ListDivider.build(),
    );
  }

  List<Widget> _buildListFooter(ActionSheetStyle _style,
      ActionSheetViewModel _viewModel, BuildContext context) {
    List<Widget> listBuilder = [
      Expanded(
        child: RoundedButton(
            viewModel: RoundedButtonViewModel(
                title: _viewModel.cancelButtonTitle,
                onTap: () => Navigator.pop(context)),
            style: RoundedButtonStyle.actionSheetLargeRoundedButton()),
      )
    ];

    if (_viewModel.confirmButtonTitle != null) {
      listBuilder.clear();
      listBuilder.add(Expanded(
        child: RoundedButton(
            viewModel: RoundedButtonViewModel(
                title: _viewModel.cancelButtonTitle,
                onTap: () => dismissActionSheet()),
            style: RoundedButtonStyle.actionSheetLargeRoundedButton()),
      ));
      listBuilder.add(SizedBox(width: _style.buttonSpacing));
      listBuilder.add(Expanded(child: hasSelectedItem(context, _style)));
    }

    return listBuilder;
  }

  void dismissActionSheet() {
    clearSelection();
    Navigator.pop(context);
  }

  void clearSelection() {
    for (var actions in _viewModel.actions) {
      actions.isSelected = false;
    }
  }

  void select(int index) {
    if (_viewModel.actions[index].type == ActionType.selectable) {
      setState(() {
        clearSelection();
        _viewModel.actions[index].isSelected = true;
      });
    } else {
      _viewModel.actions[index].onTap;
    }
  }

  RoundedButton hasSelectedItem(BuildContext context, ActionSheetStyle style) {
    for (var action in _viewModel.actions) {
      if (action.isSelected != false) {
        return RoundedButton(
            viewModel:
                RoundedButtonViewModel(title: _viewModel.confirmButtonTitle),
            style: RoundedButtonStyle.actionSheetLargeRoundedButton().copyWith(
                backgroundColor: style.confirmButtonBackgroundColor,
                buttonTextStyle: style.confirmButtonTextStyle));
      }
    }

    return RoundedButton(
        viewModel: RoundedButtonViewModel(
            title: _viewModel.confirmButtonTitle, onTap: null),
        style: RoundedButtonStyle.actionSheetLargeRoundedButton());
  }
}

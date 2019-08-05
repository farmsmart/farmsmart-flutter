import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/chat/ui/viewmodel/SelectableOptionViewModel.dart';
import 'package:farmsmart_flutter/chat/ui/viewmodel/SelectableOptionsViewModel.dart';

class SelectableOptionsStyle {
  final EdgeInsetsGeometry outerContainerMargin;
  final Axis wrapDirection;
  final WrapAlignment wrapAlignment;
  final WrapAlignment wrapRunAlignment;
  final double wrapSpacing;
  final EdgeInsetsGeometry optionMargin;
  final EdgeInsetsGeometry optionPadding;
  final Decoration optionDecoration;
  final TextAlign optionTextAlign;
  final TextStyle optionTextStyle;

  const SelectableOptionsStyle({
    this.outerContainerMargin,
    this.wrapDirection,
    this.wrapAlignment,
    this.optionDecoration,
    this.optionMargin,
    this.optionPadding,
    this.optionTextAlign,
    this.optionTextStyle,
    this.wrapRunAlignment,
    this.wrapSpacing,
  });

  SelectableOptionsStyle copyWith({
    EdgeInsetsGeometry outerContainerMargin,
    Axis wrapDirection,
    WrapAlignment wrapAlignment,
    WrapAlignment wrapRunAlignment,
    double wrapSpacing,
    EdgeInsetsGeometry optionMargin,
    EdgeInsetsGeometry optionPadding,
    Decoration optionDecoration,
    TextAlign optionTextAlign,
    TextStyle optionTextStyle,
  }) {
    return SelectableOptionsStyle(
      outerContainerMargin: outerContainerMargin ?? this.outerContainerMargin,
      optionDecoration: optionDecoration ?? this.optionDecoration,
      optionMargin: optionMargin ?? this.optionMargin,
      optionPadding: optionPadding ?? this.optionPadding,
      optionTextAlign: optionTextAlign ?? this.optionTextAlign,
      optionTextStyle: optionTextStyle ?? this.optionTextStyle,
      wrapAlignment: wrapAlignment ?? this.wrapAlignment,
      wrapDirection: wrapDirection ?? this.wrapDirection,
      wrapRunAlignment: wrapRunAlignment ?? this.wrapRunAlignment,
      wrapSpacing: wrapSpacing ?? this.wrapSpacing,
    );
  }
}

class _DefaultStyle extends SelectableOptionsStyle {
  final EdgeInsetsGeometry outerContainerMargin = const EdgeInsets.only(
    left: 60.0,
    right: 20.0,
  );
  final Axis wrapDirection = Axis.horizontal;
  final WrapAlignment wrapAlignment = WrapAlignment.end;
  final WrapAlignment wrapRunAlignment = WrapAlignment.end;
  final double wrapSpacing = 8.0;
  final EdgeInsetsGeometry optionMargin =
      const EdgeInsets.symmetric(vertical: 10.0);
  final EdgeInsetsGeometry optionPadding = const EdgeInsets.all(16.0);
  final Decoration optionDecoration = const BoxDecoration(
    color: Color(0x1400CD9F),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  );
  final TextAlign optionTextAlign = TextAlign.left;
  final TextStyle optionTextStyle = const TextStyle(
    color: Color(0xFF00CD9F),
    fontSize: 15.0,
  );

  const _DefaultStyle({
    EdgeInsetsGeometry outerContainerMargin,
    Axis wrapDirection,
    WrapAlignment wrapAlignment,
    WrapAlignment wrapRunAlignment,
    double wrapSpacing,
    EdgeInsetsGeometry optionMargin,
    EdgeInsetsGeometry optionPadding,
    Decoration optionDecoration,
    TextAlign optionTextAlign,
    TextStyle optionTextStyle,
  });
}

const SelectableOptionsStyle _defaultStyle = const _DefaultStyle();

class SelectableOptions extends StatelessWidget {
  final SelectableOptionsViewModel _viewModel;
  final Function(SelectableOptionViewModel) _onTap;
  final SelectableOptionsStyle _style;

  SelectableOptions({
    @required SelectableOptionsViewModel viewModel,
    Function(SelectableOptionViewModel) onTap,
    SelectableOptionsStyle style = _defaultStyle,
  })  : this._viewModel = viewModel,
        this._onTap = onTap ?? (() => {}),
        this._style = style;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _style.outerContainerMargin,
      child: Wrap(
        direction: _style.wrapDirection,
        alignment: _style.wrapAlignment,
        runAlignment: _style.wrapRunAlignment,
        spacing: _style.wrapSpacing,
        children: _buildSelectableOptions(_viewModel.options),
      ),
    );
  }

  List<Widget> _buildSelectableOptions(
      List<SelectableOptionViewModel> options) {
    List<Widget> output = [];
    options.forEach((option) => output.add(_buildSelectableOption(option)));
    return output;
  }

  Widget _buildSelectableOption(SelectableOptionViewModel viewModel) {
    return GestureDetector(
        onTap: () => _onTap(viewModel),
        child: Container(
          margin: _style.optionMargin,
          padding: _style.optionPadding,
          decoration: _style.optionDecoration,
          child: Text(
            viewModel.title,
            textAlign: _style.optionTextAlign,
            style: _style.optionTextStyle,
          ),
        ));
  }
}

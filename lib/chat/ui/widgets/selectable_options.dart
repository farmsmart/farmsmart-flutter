import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/chat/ui/viewmodel/SelectableOptionViewModel.dart';
import 'package:farmsmart_flutter/chat/ui/viewmodel/SelectableOptionsViewModel.dart';

class _Constants {
  static const defaultOuterContainerMargin = const EdgeInsets.only(
    left: 60.0,
    right: 20.0,
  );
  static const defaultWrapDirection = Axis.horizontal;
  static const defaultWrapAlignment = WrapAlignment.end;
  static const defaultWrapRunAlignment = WrapAlignment.end;
  static const defaultWrapSpacing = 8.0;
  static const defaultOptionMargin = const EdgeInsets.symmetric(vertical: 10.0);
  static const defaultOptionPadding = const EdgeInsets.all(16.0);
  static const defaultOptionDecoration = const BoxDecoration(
    color: Color(0x1400CD9F),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  );
  static const defaultOptionTextAlign = TextAlign.left;
  static const defaultOptionTextStyle = const TextStyle(
    color: Color(0xFF00CD9F),
    fontSize: 15.0,
  );

  static const pairLength = 2;
  static const firstIndex = 0;
  static const secondIndex = 1;
  static const pairOptionSizedBoxWidth = 16.0;
}

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
  final EdgeInsetsGeometry outerContainerMargin =
      _Constants.defaultOuterContainerMargin;
  final Axis wrapDirection = _Constants.defaultWrapDirection;
  final WrapAlignment wrapAlignment = _Constants.defaultWrapAlignment;
  final WrapAlignment wrapRunAlignment = _Constants.defaultWrapRunAlignment;
  final double wrapSpacing = _Constants.defaultWrapSpacing;
  final EdgeInsetsGeometry optionMargin = _Constants.defaultOptionMargin;
  final EdgeInsetsGeometry optionPadding = _Constants.defaultOptionPadding;
  final Decoration optionDecoration = _Constants.defaultOptionDecoration;
  final TextAlign optionTextAlign = _Constants.defaultOptionTextAlign;
  final TextStyle optionTextStyle = _Constants.defaultOptionTextStyle;

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
    List<SelectableOptionViewModel> options = _viewModel.options;
    switch (options.length) {
      case _Constants.pairLength:
        return _buildExpandedPair(options);
      default:
        return _buildWrappedOptions(options);
    }
  }

  Widget _buildExpandedPair(List<SelectableOptionViewModel> options) {
    return Container(
      margin: _style.outerContainerMargin,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildExpandedSelectableOption(options[_Constants.firstIndex]),
          _buildSizedBox(),
          _buildExpandedSelectableOption(options[_Constants.secondIndex]),
        ],
      ),
    );
  }

  Widget _buildWrappedOptions(List<SelectableOptionViewModel> options) {
    return Container(
      margin: _style.outerContainerMargin,
      child: Wrap(
        direction: _style.wrapDirection,
        alignment: _style.wrapAlignment,
        runAlignment: _style.wrapRunAlignment,
        spacing: _style.wrapSpacing,
        children: _buildSelectableOptions(options),
      ),
    );
  }

  List<Widget> _buildSelectableOptions(
    List<SelectableOptionViewModel> options,
  ) {
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
      ),
    );
  }

  Widget _buildExpandedSelectableOption(SelectableOptionViewModel viewModel) {
    return Expanded(
      child: _buildSelectableOption(viewModel),
    );
  }

  Widget _buildSizedBox() {
    return SizedBox(width: _Constants.pairOptionSizedBoxWidth);
  }
}

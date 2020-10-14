import 'package:flutter/material.dart';

class _Constants {
  static const defaultTextFormFieldContainerPadding =
      const EdgeInsets.symmetric(horizontal: 16.0);
  static const defaultTextFormFieldStyle = const TextStyle(
    color: Color(0xFF1A1B46),
    fontSize: 15.0,
  );
  static const defaultButtonColor = const Color(0xFF00CD9F);
  static const defaultBoxDecorationBorderRadius =
      const BorderRadius.all(Radius.circular(20.0));
  static const defaultBoxDecorationBorderColor = const Color(0xFFE9EAF2);
  static const defaultBoxDecorationBorderWidth = 2.0;
}

class TextInputStyle {
  final EdgeInsetsGeometry textFormFieldContainerPadding;
  final TextStyle textFormFieldStyle;
  final Color buttonColor;
  final BorderRadiusGeometry boxDecorationBorderRadius;
  final Color boxDecorationBorderColor;
  final double boxDecorationBorderWidth;

  const TextInputStyle({
    this.buttonColor,
    this.textFormFieldContainerPadding,
    this.textFormFieldStyle,
    this.boxDecorationBorderRadius,
    this.boxDecorationBorderColor,
    this.boxDecorationBorderWidth,
  });

  TextInputStyle copyWith({
    EdgeInsetsGeometry textFormFieldContainerPadding,
    TextStyle textFormFieldStyle,
    Color buttonColor,
    BorderRadiusGeometry boxDecorationBorderRadius,
    Color boxDecorationBorderColor,
    double boxDecorationBorderWidth,
  }) {
    return TextInputStyle(
      textFormFieldContainerPadding:
          textFormFieldContainerPadding ?? this.textFormFieldContainerPadding,
      textFormFieldStyle: textFormFieldStyle ?? this.textFormFieldStyle,
      buttonColor: buttonColor ?? this.buttonColor,
      boxDecorationBorderRadius:
          boxDecorationBorderRadius ?? this.boxDecorationBorderRadius,
      boxDecorationBorderColor:
          boxDecorationBorderColor ?? this.boxDecorationBorderColor,
      boxDecorationBorderWidth:
          boxDecorationBorderWidth ?? this.boxDecorationBorderWidth,
    );
  }
}

class _DefaultStyle extends TextInputStyle {
  final EdgeInsetsGeometry textFormFieldContainerPadding =
      _Constants.defaultTextFormFieldContainerPadding;
  final TextStyle textFormFieldStyle = _Constants.defaultTextFormFieldStyle;
  final Color buttonColor = _Constants.defaultButtonColor;
  final BorderRadiusGeometry boxDecorationBorderRadius =
      _Constants.defaultBoxDecorationBorderRadius;
  final Color boxDecorationBorderColor =
      _Constants.defaultBoxDecorationBorderColor;
  final double boxDecorationBorderWidth =
      _Constants.defaultBoxDecorationBorderWidth;

  const _DefaultStyle({
    EdgeInsetsGeometry textFormFieldContainerPadding,
    TextStyle textFormFieldStyle,
    Color buttonColor,
    BorderRadiusGeometry boxDecorationBorderRadius,
    Color boxDecorationBorderColor,
    double boxDecorationBorderWidth,
  });
}

const TextInputStyle _defaultStyle = const _DefaultStyle();

class TextInputState extends State<TextInput> {
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Form form = Form(
      key: widget.formKey,
      child: _buildTextFormField(),
    );
    _manageFocus();
    return form;
  }

  void _manageFocus() {
    if (widget._isFocusedOnBuild) {
      FocusScope.of(context).autofocus(_focusNode);
    }
  }

  _buildTextFormField() => Center(
        child: Container(
          padding: widget._style.textFormFieldContainerPadding,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: widget._style.boxDecorationBorderRadius,
            border: Border.all(
              color: widget._style.boxDecorationBorderColor,
              width: widget._style.boxDecorationBorderWidth,
            ),
          ),
          child: TextFormField(
            controller: widget._controller,
            decoration: widget._decoration,
            focusNode: _focusNode,
            validator: (value) {
              return widget._formFieldValidatorFunction(value);
            },
            style: widget._style.textFormFieldStyle,
          ),
        ),
      );
}

class TextInput extends StatefulWidget {
  final TextEditingController _controller;
  final InputDecoration _decoration;
  final String Function(String) _formFieldValidatorFunction;
  final bool _isFocusedOnBuild;
  final TextInputStyle _style;
  final formKey = GlobalKey<FormState>();

  TextInput({
    TextEditingController controller,
    InputDecoration decoration,
    String Function(String) formFieldValidatorFunction,
    bool isFocusedOnBuild,
    TextInputStyle style = _defaultStyle,
  })  : this._controller = controller,
        this._decoration = decoration,
        this._formFieldValidatorFunction = formFieldValidatorFunction,
        this._isFocusedOnBuild = isFocusedOnBuild,
        this._style = style;

  @override
  TextInputState createState() {
    return TextInputState();
  }
}

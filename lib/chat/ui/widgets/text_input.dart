import 'package:flutter/material.dart';

class TextInputStyle {
  final EdgeInsetsGeometry formContainerMargin;
  final MainAxisSize formRowMainAxisSize;
  final MainAxisAlignment formRowMainAxisAlignment;
  final int textFormFieldFlex;
  final int buttonFlex;
  final EdgeInsetsGeometry textFormFieldContainerPadding;
  final Decoration textFormFieldContainerDecoration;
  final TextStyle textFormFieldStyle;
  final Color buttonColor;

  const TextInputStyle({
    this.formContainerMargin,
    this.buttonColor,
    this.buttonFlex,
    this.formRowMainAxisAlignment,
    this.formRowMainAxisSize,
    this.textFormFieldContainerDecoration,
    this.textFormFieldContainerPadding,
    this.textFormFieldFlex,
    this.textFormFieldStyle,
  });

  TextInputStyle copyWith({
    EdgeInsetsGeometry formContainerMargin,
    MainAxisSize formRowMainAxisSize,
    MainAxisAlignment formRowMainAxisAlignment,
    int textFormFieldFlex,
    int buttonFlex,
    EdgeInsetsGeometry textFormFieldContainerPadding,
    Decoration textFormFieldContainerDecoration,
    TextStyle textFormFieldStyle,
    Color buttonColor,
  }) {
    return TextInputStyle(
      formContainerMargin: formContainerMargin ?? this.formContainerMargin,
      formRowMainAxisSize: formRowMainAxisSize ?? this.formRowMainAxisSize,
      formRowMainAxisAlignment:
          formRowMainAxisAlignment ?? this.formRowMainAxisAlignment,
      textFormFieldFlex: textFormFieldFlex ?? this.textFormFieldFlex,
      buttonFlex: buttonFlex ?? this.buttonFlex,
      textFormFieldContainerPadding:
          textFormFieldContainerPadding ?? this.textFormFieldContainerPadding,
      textFormFieldContainerDecoration: textFormFieldContainerDecoration ??
          this.textFormFieldContainerDecoration,
      textFormFieldStyle: textFormFieldStyle ?? this.textFormFieldStyle,
      buttonColor: buttonColor ?? this.buttonColor,
    );
  }
}

class _DefaultStyle extends TextInputStyle {
  final EdgeInsetsGeometry formContainerMargin = const EdgeInsets.symmetric(
    vertical: 10.0,
    horizontal: 20.0,
  );
  final MainAxisSize formRowMainAxisSize = MainAxisSize.max;
  final MainAxisAlignment formRowMainAxisAlignment =
      MainAxisAlignment.spaceBetween;
  final int textFormFieldFlex = 5;
  final int buttonFlex = 1;
  final EdgeInsetsGeometry textFormFieldContainerPadding =
      const EdgeInsets.symmetric(
    vertical: 6.0,
    horizontal: 20.0,
  );
  final Decoration textFormFieldContainerDecoration = const BoxDecoration(
    color: Color(0x1400CD9F),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  );
  final TextStyle textFormFieldStyle = const TextStyle(
    color: Color(0xFF00CD9F),
    fontSize: 15.0,
  );
  final Color buttonColor = const Color(0xFF00CD9F);

  const _DefaultStyle({
    EdgeInsetsGeometry formContainerMargin,
    MainAxisSize formRowMainAxisSize,
    MainAxisAlignment formRowMainAxisAlignment,
    int textFormFieldFlex,
    int buttonFlex,
    EdgeInsetsGeometry textFormFieldContainerPadding,
    Decoration textFormFieldContainerDecoration,
    TextStyle textFormFieldStyle,
    Color buttonColor,
  });
}

const TextInputStyle _defaultStyle = const _DefaultStyle();

class TextInputState extends State<TextInput> {
  final TextEditingController _controller;
  final InputDecoration _decoration;
  final Function _onSendPressed;
  final _formKey = GlobalKey<FormState>();
  final String Function(String) _formFieldValidatorFunction;
  final String _buttonText;
  final TextInputStyle _style;
  final FocusNode _focusNode = FocusNode();
  final bool _isFocusedOnBuild;

  TextInputState({
    TextEditingController controller,
    InputDecoration decoration,
    Function onSendPressed,
    Function(String) formFieldValidatorFunction,
    String buttonText,
    TextInputStyle style,
    bool isFocusedOnBuild,
  })  : this._controller = controller ?? TextEditingController(),
        this._decoration = decoration ?? InputDecoration(),
        this._onSendPressed = onSendPressed ?? (() => {}),
        this._formFieldValidatorFunction = formFieldValidatorFunction,
        this._buttonText = buttonText ?? "",
        this._isFocusedOnBuild = isFocusedOnBuild ?? false,
        this._style = style ?? _defaultStyle;

  @override
  Widget build(BuildContext context) {
    Form form = Form(
      key: _formKey,
      child: Container(
        margin: _style.formContainerMargin,
        child: Row(
          mainAxisSize: _style.formRowMainAxisSize,
          mainAxisAlignment: _style.formRowMainAxisAlignment,
          children: <Widget>[
            _buildTextFormField(),
            _buildSendButton(),
          ],
        ),
      ),
    );
    _manageFocus();
    return form;
  }

  _buildTextFormField() {
    return Flexible(
      flex: _style.textFormFieldFlex,
      child: Container(
        padding: _style.textFormFieldContainerPadding,
        decoration: _style.textFormFieldContainerDecoration,
        child: TextFormField(
          controller: _controller,
          decoration: _decoration,
          focusNode: _focusNode,
          validator: (value) {
            return _formFieldValidatorFunction(value);
          },
          style: _style.textFormFieldStyle,
        ),
      ),
    );
  }

  _buildSendButton() {
    return Flexible(
      flex: _style.buttonFlex,
      child: FloatingActionButton(
        child: Text(_buttonText),
        backgroundColor: _style.buttonColor,
        onPressed: () {
          _formKey.currentState.validate();
          _onSendPressed();
        },
      ),
    );
  }

  void _manageFocus() {
    if (_isFocusedOnBuild) {
      FocusScope.of(context).requestFocus(_focusNode);
    }
  }
}

class TextInput extends StatefulWidget {
  final TextEditingController _controller;
  final InputDecoration _decoration;
  final Function _onSendPressed;
  final String Function(String) _formFieldValidatorFunction;
  final String _buttonText;
  final bool _isFocusedOnBuild;

  TextInput({
    TextEditingController controller,
    InputDecoration decoration,
    Function onSendPressed,
    String Function(String) formFieldValidatorFunction,
    String buttonText,
    bool isFocusedOnBuild,
  })  : this._controller = controller,
        this._decoration = decoration,
        this._onSendPressed = onSendPressed,
        this._formFieldValidatorFunction = formFieldValidatorFunction,
        this._isFocusedOnBuild = isFocusedOnBuild,
        this._buttonText = buttonText;

  @override
  TextInputState createState() {
    return TextInputState(
        decoration: _decoration,
        controller: _controller,
        onSendPressed: _onSendPressed,
        formFieldValidatorFunction: _formFieldValidatorFunction,
        buttonText: _buttonText,
        isFocusedOnBuild: _isFocusedOnBuild);
  }
}

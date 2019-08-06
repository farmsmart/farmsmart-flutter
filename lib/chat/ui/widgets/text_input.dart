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
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Form form = Form(
      key: _formKey,
      child: Container(
        margin: widget._style.formContainerMargin,
        child: Row(
          mainAxisSize: widget._style.formRowMainAxisSize,
          mainAxisAlignment: widget._style.formRowMainAxisAlignment,
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
      flex: widget._style.textFormFieldFlex,
      child: Container(
        padding: widget._style.textFormFieldContainerPadding,
        decoration: widget._style.textFormFieldContainerDecoration,
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

  _buildSendButton() {
    return Flexible(
      flex: widget._style.buttonFlex,
      child: FloatingActionButton(
        child: Text(widget._buttonText),
        backgroundColor: widget._style.buttonColor,
        onPressed: () {
          _formKey.currentState.validate();
          widget._onSendPressed();
        },
      ),
    );
  }

  void _manageFocus() {
    if (widget._isFocusedOnBuild) {
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
  final TextInputStyle _style;

  TextInput({
    TextEditingController controller,
    InputDecoration decoration,
    Function onSendPressed,
    String Function(String) formFieldValidatorFunction,
    String buttonText,
    bool isFocusedOnBuild,
    TextInputStyle style = _defaultStyle,
  })  : this._controller = controller,
        this._decoration = decoration,
        this._onSendPressed = onSendPressed,
        this._formFieldValidatorFunction = formFieldValidatorFunction,
        this._isFocusedOnBuild = isFocusedOnBuild,
        this._buttonText = buttonText,
        this._style = style;

  @override
  TextInputState createState() {
    return TextInputState();
  }
}

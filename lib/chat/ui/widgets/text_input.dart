import 'package:farmsmart_flutter/chat/ui/widgets/roundedButton.dart';
import 'package:flutter/material.dart';

class _Constants {
  static const defaultFormContainerMargin = const EdgeInsets.all(0.0);
  static const defaultFormRowMainAxisSize = MainAxisSize.max;
  static const defaultFormRowMainAxisAlignment = MainAxisAlignment.spaceBetween;
  static const defaultTextFormFieldFlex = 4;
  static const defaultButtonFlex = 1;
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
  static const defaultSizedBoxSeparatorWidth = 10.0;
}

class TextInputStyle {
  final EdgeInsetsGeometry formContainerMargin;
  final MainAxisSize formRowMainAxisSize;
  final MainAxisAlignment formRowMainAxisAlignment;
  final int textFormFieldFlex;
  final int buttonFlex;
  final EdgeInsetsGeometry textFormFieldContainerPadding;
  final TextStyle textFormFieldStyle;
  final Color buttonColor;
  final BorderRadiusGeometry boxDecorationBorderRadius;
  final Color boxDecorationBorderColor;
  final double boxDecorationBorderWidth;
  final double sizedBoxSeparatorWidth;

  const TextInputStyle({
    this.formContainerMargin,
    this.buttonColor,
    this.buttonFlex,
    this.formRowMainAxisAlignment,
    this.formRowMainAxisSize,
    this.textFormFieldContainerPadding,
    this.textFormFieldFlex,
    this.textFormFieldStyle,
    this.boxDecorationBorderRadius,
    this.boxDecorationBorderColor,
    this.boxDecorationBorderWidth,
    this.sizedBoxSeparatorWidth,
  });

  TextInputStyle copyWith({
    EdgeInsetsGeometry formContainerMargin,
    MainAxisSize formRowMainAxisSize,
    MainAxisAlignment formRowMainAxisAlignment,
    int textFormFieldFlex,
    int buttonFlex,
    EdgeInsetsGeometry textFormFieldContainerPadding,
    TextStyle textFormFieldStyle,
    Color buttonColor,
    BorderRadiusGeometry boxDecorationBorderRadius,
    Color boxDecorationBorderColor,
    double boxDecorationBorderWidth,
    double sizedBoxSeparatorWidth,
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
      textFormFieldStyle: textFormFieldStyle ?? this.textFormFieldStyle,
      buttonColor: buttonColor ?? this.buttonColor,
      boxDecorationBorderRadius:
          boxDecorationBorderRadius ?? this.boxDecorationBorderRadius,
      boxDecorationBorderColor:
          boxDecorationBorderColor ?? this.boxDecorationBorderColor,
      boxDecorationBorderWidth:
          boxDecorationBorderWidth ?? this.boxDecorationBorderWidth,
      sizedBoxSeparatorWidth:
          sizedBoxSeparatorWidth ?? this.sizedBoxSeparatorWidth,
    );
  }
}

class _DefaultStyle extends TextInputStyle {
  final EdgeInsetsGeometry formContainerMargin =
      _Constants.defaultFormContainerMargin;
  final MainAxisSize formRowMainAxisSize =
      _Constants.defaultFormRowMainAxisSize;
  final MainAxisAlignment formRowMainAxisAlignment =
      _Constants.defaultFormRowMainAxisAlignment;
  final int textFormFieldFlex = _Constants.defaultTextFormFieldFlex;
  final int buttonFlex = _Constants.defaultButtonFlex;
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
  final double sizedBoxSeparatorWidth =
      _Constants.defaultSizedBoxSeparatorWidth;

  const _DefaultStyle({
    EdgeInsetsGeometry formContainerMargin,
    MainAxisSize formRowMainAxisSize,
    MainAxisAlignment formRowMainAxisAlignment,
    int textFormFieldFlex,
    int buttonFlex,
    EdgeInsetsGeometry textFormFieldContainerPadding,
    TextStyle textFormFieldStyle,
    Color buttonColor,
    BorderRadiusGeometry boxDecorationBorderRadius,
    Color boxDecorationBorderColor,
    double boxDecorationBorderWidth,
    double sizedBoxSeparatorWidth,
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
            _buildSpace(),
            _buildSendButton(),
          ],
        ),
      ),
    );
    _manageFocus();
    return form;
  }

  void _manageFocus() {
    if (widget._isFocusedOnBuild) {
      FocusScope.of(context).requestFocus(_focusNode);
    }
  }

  _buildTextFormField() => Flexible(
        flex: widget._style.textFormFieldFlex,
        child: Center(
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
        ),
      );

  _buildSpace() => SizedBox(width: widget._style.sizedBoxSeparatorWidth);

  _buildSendButton() => Flexible(
        flex: widget._style.buttonFlex,
        child: RoundedButton(
          viewModel: RoundedButtonViewModel(
              title: widget._buttonText,
              onTap: () {
                _formKey.currentState.validate();
                widget._onSendPressed();
              }),
          style: widget._roundedButtonStyle,
        ),
      );
}

class TextInput extends StatefulWidget {
  final TextEditingController _controller;
  final InputDecoration _decoration;
  final Function _onSendPressed;
  final String Function(String) _formFieldValidatorFunction;
  final String _buttonText;
  final bool _isFocusedOnBuild;
  final TextInputStyle _style;
  final RoundedButtonStyle _roundedButtonStyle;

  TextInput({
    TextEditingController controller,
    InputDecoration decoration,
    Function onSendPressed,
    String Function(String) formFieldValidatorFunction,
    @required String buttonText,
    bool isFocusedOnBuild,
    @required RoundedButtonStyle roundedButtonStyle,
    TextInputStyle style = _defaultStyle,
  })  : this._controller = controller,
        this._decoration = decoration,
        this._onSendPressed = onSendPressed,
        this._formFieldValidatorFunction = formFieldValidatorFunction,
        this._isFocusedOnBuild = isFocusedOnBuild,
        this._buttonText = buttonText,
        this._roundedButtonStyle = roundedButtonStyle,
        this._style = style;

  @override
  TextInputState createState() {
    return TextInputState();
  }
}

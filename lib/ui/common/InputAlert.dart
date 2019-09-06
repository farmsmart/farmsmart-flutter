import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class _Constants {
  static final EdgeInsets alertEdgePadding =
      const EdgeInsets.symmetric(horizontal: 24);
  static final BorderRadius cornerRadius =
      const BorderRadius.all(Radius.circular(24.0));
  static final EdgeInsets alertInnerPadding =
      const EdgeInsets.only(left: 32, right: 32, bottom: 31, top: 31);
  static final double titleLineSpace = 19;
  static final double detailLineSpace = 28;
  static final double actionHeight = 48;
  static final double actionWidth = 120;
  static final BorderRadius actionCornerRadius =
      const BorderRadius.all(Radius.circular(14));
  static final double actionLineSpace = 8;
}

class InputAlertViewModel {
  String cancelActionText;
  String confirmActionText;
  String titleText;
  String hint;
  Function(String) confirmInputAction;

  InputAlertViewModel({
    @required this.cancelActionText,
    @required this.confirmActionText,
    @required this.titleText,
    this.hint,
    this.confirmInputAction,
  });
}

class InputAlertStyle {
  final Color backgroundColor;
  final TextStyle titleTextStyle;
  final TextStyle detailTextStyle;
  final Color actionBackgroundColor;
  final Color destructiveActionBackgroundColor;
  final TextStyle actionTextStyle;

  const InputAlertStyle({
    this.backgroundColor,
    this.titleTextStyle,
    this.detailTextStyle,
    this.actionBackgroundColor,
    this.destructiveActionBackgroundColor,
    this.actionTextStyle,
  });

  InputAlertStyle copyWith({
    Color backgroundColor,
    TextStyle titleTextStyle,
    TextStyle detailTextStyle,
    Color actionBackgroundColor,
    Color destructiveActionBackgroundColor,
    TextStyle actionTextStyle,
  }) {
    return InputAlertStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      detailTextStyle: detailTextStyle ?? this.detailTextStyle,
      actionBackgroundColor:
          actionBackgroundColor ?? this.actionBackgroundColor,
      destructiveActionBackgroundColor: destructiveActionBackgroundColor ??
          this.destructiveActionBackgroundColor,
      actionTextStyle: actionTextStyle ?? this.actionTextStyle,
    );
  }
}

class _DefaultStyle extends InputAlertStyle {
  final backgroundColor = const Color(0xffffffff);
  final titleTextStyle = const TextStyle(
    color: Color(0xff1a1b46),
    fontSize: 27,
    fontWeight: FontWeight.bold,
  );
  final detailTextStyle = const TextStyle(
    color: Color(0xff1a1b46),
    fontSize: 17,
    height: 1.1,
    fontWeight: FontWeight.normal,
  );
  final actionBackgroundColor = const Color(0xff24d900);
  final destructiveActionBackgroundColor = const Color(0xffff6060);
  final actionTextStyle = const TextStyle(
    color: Color(0xffffffff),
    fontSize: 15,
  );

  const _DefaultStyle({
    Color backgroundColor,
    TextStyle titleTextStyle,
    TextStyle detailTextStyle,
    Color actionBackgroundColor,
    Color destructiveActionBackgroundColor,
    TextStyle actionTextStyle,
  });
}

const InputAlertStyle _defaultStyle = const _DefaultStyle();

class InputAlert extends StatelessWidget {
  final InputAlertViewModel _viewModel;
  final InputAlertStyle _style;

  TextEditingController _textFieldController = TextEditingController();


  static present(InputAlert alert, BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => alert,
    );
  }

  InputAlert({
    Key key,
    InputAlertViewModel viewModel,
    InputAlertStyle style = _defaultStyle,
  })  : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: _Constants.alertEdgePadding,
          decoration: BoxDecoration(
            borderRadius: _Constants.cornerRadius,
            color: _style.backgroundColor,
          ),
          child: Padding(
            padding: _Constants.alertInnerPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  _viewModel.titleText,
                  style: _style.titleTextStyle,
                ),
                SizedBox(
                  height: _Constants.titleLineSpace,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _textFieldController,
                      decoration:
                          InputDecoration(hintText: _viewModel.hint),
                    ),
                    SizedBox(
                      height: _Constants.detailLineSpace,
                    ),
                    Row(
                      children: _buildAction(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAction(BuildContext context) {
    List<Widget> listBuilder = [
      Expanded(
        child: RoundedButton(
          viewModel: RoundedButtonViewModel(
            title: _viewModel.cancelActionText,
            onTap: () => Navigator.of(context).pop(),
          ),
          style: RoundedButtonStyle.actionSheetLargeRoundedButton().copyWith(
            height: _Constants.actionHeight,
            width: _Constants.actionWidth,
            borderRadius: _Constants.actionCornerRadius,
          ),
        ),
      ),
    ];
    listBuilder.add(
      SizedBox(
        width: _Constants.actionLineSpace,
      ),
    );
    listBuilder.add(
      Expanded(
        child: RoundedButton(
          viewModel: RoundedButtonViewModel(
              title: _viewModel.confirmActionText,
              onTap: () => confirmAndDismiss(context)),
          style: RoundedButtonStyle.actionSheetLargeRoundedButton().copyWith(
            height: _Constants.actionHeight,
            width: _Constants.actionWidth,
            backgroundColor: _style.actionBackgroundColor,
            buttonTextStyle: _style.actionTextStyle,
            borderRadius: _Constants.actionCornerRadius,
          ),
        ),
      ),
    );
    return listBuilder;
  }

  confirmAndDismiss(BuildContext context) {
    if(_textFieldController.text != null && _textFieldController.text.isNotEmpty){
      _viewModel.confirmInputAction(_textFieldController.text);
      Navigator.of(context).pop();
    }
  }
}

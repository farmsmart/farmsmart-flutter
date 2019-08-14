import 'package:flutter/material.dart';

class MessageBubbleStyle {
  final EdgeInsetsGeometry outerContainerMargin;
  final BorderRadiusGeometry textContainerBorderRadius;
  final EdgeInsetsGeometry textContainerPadding;
  final EdgeInsetsGeometry textContainerMargin;
  final Color textContainerBackgroundColor;
  final TextAlign textAlignment;
  final TextStyle textStyle;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final MainAxisAlignment rowMainAxisAlignment;

  const MessageBubbleStyle({
    this.outerContainerMargin,
    this.textContainerBorderRadius,
    this.textContainerPadding,
    this.textAlignment,
    this.textContainerBackgroundColor,
    this.textStyle,
    this.textContainerMargin,
    this.rowMainAxisAlignment,
    this.rowCrossAxisAlignment,
  });

  MessageBubbleStyle copyWith({
    EdgeInsetsGeometry outerContainerMargin,
    BorderRadiusGeometry textContainerBorderRadius,
    EdgeInsetsGeometry textContainerPadding,
    EdgeInsetsGeometry textContainerMargin,
    Color textContainerBackgroundColor,
    TextAlign textAlignment,
    TextStyle textStyle,
    CrossAxisAlignment rowCrossAxisAlignment,
    MainAxisAlignment rowMainAxisAlignment,
  }) {
    return MessageBubbleStyle(
      textContainerBorderRadius:
          textContainerBorderRadius ?? this.textContainerBorderRadius,
      textAlignment: textAlignment ?? this.textAlignment,
      textStyle: textStyle ?? this.textStyle,
      textContainerBackgroundColor:
          textContainerBackgroundColor ?? this.textContainerBackgroundColor,
      rowCrossAxisAlignment:
          rowCrossAxisAlignment ?? this.rowCrossAxisAlignment,
      textContainerMargin: textContainerMargin ?? this.textContainerMargin,
      outerContainerMargin: outerContainerMargin ?? this.outerContainerMargin,
      textContainerPadding: textContainerPadding ?? this.textContainerPadding,
      rowMainAxisAlignment: rowMainAxisAlignment ?? this.rowMainAxisAlignment,
    );
  }
}

class _DefaultMessageBubbleStyle extends MessageBubbleStyle {
  final EdgeInsetsGeometry outerContainerMargin = const EdgeInsets.symmetric(
    vertical: 10.0,
    horizontal: 20.0,
  );
  final BorderRadiusGeometry textContainerBorderRadius =
      const BorderRadius.all(Radius.circular(20.0));
  final EdgeInsetsGeometry textContainerPadding = const EdgeInsets.all(16.0);
  final EdgeInsetsGeometry textContainerMargin = const EdgeInsets.only(
    left: 30.0,
    right: 0.0,
  );
  final Color textContainerBackgroundColor = const Color(0xFF00CD9F);
  final TextAlign textAlignment = TextAlign.start;
  final TextStyle textStyle = const TextStyle(
    color: const Color(0xFFFFFFFF),
    fontSize: 15.0,
  );
  final CrossAxisAlignment rowCrossAxisAlignment = CrossAxisAlignment.end;
  final MainAxisAlignment rowMainAxisAlignment = MainAxisAlignment.end;

  const _DefaultMessageBubbleStyle({
    EdgeInsetsGeometry outerContainerMargin,
    BorderRadiusGeometry textContainerBorderRadius,
    EdgeInsetsGeometry textContainerPadding,
    EdgeInsetsGeometry textContainerMargin,
    Color textContainerBackgroundColor,
    TextAlign textAlignment,
    TextStyle textStyle,
    CrossAxisAlignment rowCrossAxisAlignment,
    MainAxisAlignment rowMainAxisAlignment,
  });
}

const MessageBubbleStyle _defaultStyle = const _DefaultMessageBubbleStyle();

class MessageBubble extends StatelessWidget {
  final MessageBubbleViewModel _viewModel;
  final MessageBubbleStyle _style;
  final Function _onTap;

  bool _notNull(Widget item) => item != null;

  MessageBubble({
    @required MessageBubbleViewModel viewModel,
    MessageBubbleStyle style = _defaultStyle,
    Function onTap,
  })  : this._viewModel = viewModel,
        this._style = style,
        this._onTap = onTap ?? (() => {});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _onTap,
        child: Container(
          margin: _style.outerContainerMargin,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: _style.rowCrossAxisAlignment,
            mainAxisAlignment: _style.rowMainAxisAlignment,
            children: <Widget>[
              _buildAvatar(),
              _buildContainer(),
            ].where(_notNull).toList(),
          ),
        ));
  }

  _buildAvatar() {
    return _viewModel.avatar;
  }

  _buildContainer() {
    return Flexible(
      child: Container(
        padding: _style.textContainerPadding,
        margin: _style.textContainerMargin,
        decoration: BoxDecoration(
          color: _style.textContainerBackgroundColor,
          borderRadius: _style.textContainerBorderRadius,
        ),
        child: _buildItem(),
      ),
    );
  }

  _buildItem() {
    return Column(
      children: <Widget>[
        _buildChild(),
        _buildText(_viewModel.message),
      ].where(_notNull).toList(),
    );
  }

  _buildChild() {
    return _viewModel.messageChild;
  }

  _buildText(String message) {
    if (message != null && message.isNotEmpty) {
      return Text(
        message,
        textAlign: _style.textAlignment,
        style: _style.textStyle,
      );
    }
  }
}

class MessageBubbleViewModel {
  final Widget messageChild;
  final Widget avatar;
  String message;
  MessageType messageType;


  MessageBubbleViewModel({
    this.message,
    this.messageChild,
    this.avatar,
    this.messageType,
  });
}

enum MessageType {
  sent,
  received,
  receivedStackTop,
  receivedStackBottom,
  receivedStackBetween,
  header,
  loading,
}

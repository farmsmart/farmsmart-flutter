import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoundedButtonStateFulViewModel {
  RoundedButtonViewModel roundedButtonViewModel;
  bool isActive;

  RoundedButtonStateFulViewModel({
    this.roundedButtonViewModel,
    this.isActive = true,
  });
}

class RoundedButtonStateFulStyle {
  final RoundedButtonStyle activeRoundedButtonStyle;
  final RoundedButtonStyle inactiveRoundedButtonStyle;

  const RoundedButtonStateFulStyle({
    this.activeRoundedButtonStyle,
    this.inactiveRoundedButtonStyle,
  });

  RoundedButtonStateFulStyle copyWith({
    RoundedButtonStyle activeRoundedButtonStyle,
    RoundedButtonStyle inactiveRoundedButtonStyle,
  }) {
    return RoundedButtonStateFulStyle(
      activeRoundedButtonStyle:
          activeRoundedButtonStyle ?? this.activeRoundedButtonStyle,
      inactiveRoundedButtonStyle:
          inactiveRoundedButtonStyle ?? this.inactiveRoundedButtonStyle,
    );
  }
}

class _DefaultStyle extends RoundedButtonStateFulStyle {
  final RoundedButtonStyle activeRoundedButtonStyle = const RoundedButtonStyle(
    backgroundColor: Color(0xff24d900),
    borderRadius: BorderRadius.all(Radius.circular(8)),
    buttonTextStyle: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: Color(0xffffffff),
    ),
    iconEdgePadding: 5,
    height: 40,
    width: double.infinity,
    buttonIconSize: null,
    iconButtonColor: Color(0xFFFFFFFF),
    buttonShape: BoxShape.rectangle,
  );

  final RoundedButtonStyle inactiveRoundedButtonStyle =
      const RoundedButtonStyle(
    backgroundColor: Color(0xffffffff),
    buttonTextStyle: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: Color(0xff4c4e6e),
    ),
    borderRadius: BorderRadius.all(Radius.circular(8)),
    iconEdgePadding: 5,
    height: 40,
    width: double.infinity,
    buttonIconSize: null,
    iconButtonColor: Color(0xFFFFFFFF),
    buttonShape: BoxShape.rectangle,
  );

  const _DefaultStyle({
    RoundedButtonStyle activeRoundedButtonStyle,
    RoundedButtonStyle inactiveRoundedButtonStyle,
  });
}

const RoundedButtonStateFulStyle _defaultStyle = const _DefaultStyle();

class RoundedButtonStateFul extends StatefulWidget {
  final RoundedButtonStateFulStyle _style;
  final RoundedButtonStateFulViewModel _viewModel;

  RoundedButtonStateFul({
    Key key,
    RoundedButtonStateFulViewModel viewModel,
    RoundedButtonStateFulStyle style = _defaultStyle,
  })  : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  _RoundedButtonStateFulState createState() => _RoundedButtonStateFulState();
}

class _RoundedButtonStateFulState extends State<RoundedButtonStateFul> {
  bool _isEnabled;

  @override
  void initState() {
    _isEnabled = widget._viewModel.isActive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      viewModel: widget._viewModel.roundedButtonViewModel,
      style: _isEnabled
          ? widget._style.activeRoundedButtonStyle
          : widget._style.inactiveRoundedButtonStyle,
    );
  }
}

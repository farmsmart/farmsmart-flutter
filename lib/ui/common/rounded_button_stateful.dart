import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoundedButtonStatefulViewModel {
  RoundedButtonViewModel roundedButtonViewModel;
  bool isActive;

  RoundedButtonStatefulViewModel({
    this.roundedButtonViewModel,
    this.isActive = true,
  });
}

class RoundedButtonStatefulStyle {
  final RoundedButtonStyle activeRoundedButtonStyle;
  final RoundedButtonStyle inactiveRoundedButtonStyle;

  const RoundedButtonStatefulStyle({
    this.activeRoundedButtonStyle,
    this.inactiveRoundedButtonStyle,
  });

  RoundedButtonStatefulStyle copyWith({
    RoundedButtonStyle activeRoundedButtonStyle,
    RoundedButtonStyle inactiveRoundedButtonStyle,
  }) {
    return RoundedButtonStatefulStyle(
      activeRoundedButtonStyle:
          activeRoundedButtonStyle ?? this.activeRoundedButtonStyle,
      inactiveRoundedButtonStyle:
          inactiveRoundedButtonStyle ?? this.inactiveRoundedButtonStyle,
    );
  }
}

class _DefaultStyle extends RoundedButtonStatefulStyle {
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

const RoundedButtonStatefulStyle _defaultStyle = const _DefaultStyle();

class RoundedButtonStateful extends StatefulWidget {
  final RoundedButtonStatefulStyle _style;
  final RoundedButtonStatefulViewModel _viewModel;

  RoundedButtonStateful({
    Key key,
    RoundedButtonStatefulViewModel viewModel,
    RoundedButtonStatefulStyle style = _defaultStyle,
  })  : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  _RoundedButtonStatefulState createState() => _RoundedButtonStatefulState();
}

class _RoundedButtonStatefulState extends State<RoundedButtonStateful> {
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

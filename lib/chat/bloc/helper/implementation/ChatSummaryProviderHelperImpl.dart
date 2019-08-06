import 'package:farmsmart_flutter/chat/ui/widgets/separator_wrapper.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:flutter/material.dart';

import '../ChatSummaryProviderHelper.dart';

class _Constants {
  static final double detailsButtonHeight = 48.0;
  static final BorderRadius detailsButtonRadius = BorderRadius.all(
    Radius.circular(12.0),
  );
  static final TextStyle detailsButtonTextStyle = TextStyle(
    fontSize: 15.0,
    color: Color(0xFFFFFFFF),
  );
}

class ChatSummaryProviderHelperImpl implements ChatSummaryProviderHelper {
  @override
  Widget getSummary({String title, Function onTap}) {
    return SeparatorWrapper(
      wrappedChild: RoundedButton(
        viewModel: RoundedButtonViewModel(
          title: title,
          onTap: onTap,
        ),
        style: RoundedButtonStyle.largeRoundedButtonStyle().copyWith(
          height: _Constants.detailsButtonHeight,
          borderRadius: _Constants.detailsButtonRadius,
          buttonTextStyle: _Constants.detailsButtonTextStyle,
        ),
      ),
    );
  }
}

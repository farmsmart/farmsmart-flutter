import 'package:farmsmart_flutter/chat/ui/widgets/roundedButton.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/separator_wrapper.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/styles/rounded_button_styles.dart';
import 'package:flutter/material.dart';

import '../ChatSummaryProviderHelper.dart';

class ChatSummaryProviderHelperImpl implements ChatSummaryProviderHelper {
  @override
  Widget getSummary({String title, Function onTap}) {
    return SeparatorWrapper(
      wrappedChild: RoundedButton(
        viewModel: RoundedButtonViewModel(
          title: title,
          onTap: onTap,
        ),
        style: RoundedButtonStyles.chatButtonStyle(),
      ),
    );
  }
}

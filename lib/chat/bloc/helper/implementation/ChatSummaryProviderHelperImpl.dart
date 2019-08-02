import 'package:farmsmart_flutter/chat/ui/widgets/summary.dart';

import '../ChatSummaryProviderHelper.dart';

class ChatSummaryProviderHelperImpl
    implements
        ChatSummaryProviderHelper<SummaryViewModel, Map<String, String>> {
  @override
  SummaryViewModel getSummary({
    Map<String, String> inputModel,
    String titleValue,
    String titleText,
    String actionText,
  }) {
    String body = _getInputModelAsString(inputModel: inputModel);
    if (body.isNotEmpty) {
      return SummaryViewModel(
        actionText: actionText,
        titleText: titleText,
        titleValue: titleValue,
        bodyText: body,
      );
    } else {
      return null;
    }
  }

  String _getInputModelAsString({Map<String, String> inputModel}) {
    String response = "";
    inputModel.forEach((key, value) {
      response = response + key + " : " + value + "\n";
    });
    return response;
  }
}

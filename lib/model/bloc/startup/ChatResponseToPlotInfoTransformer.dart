import 'package:farmsmart_flutter/chat/ui/viewmodel/ChatResponseViewModel.dart';
import 'package:farmsmart_flutter/chat/utils/ChatResponseKeys.dart';
import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:intl/intl.dart';

class _Constants {
  static const dateFormat = "MMMM";
}

class ChatResponseToPlotInfoTransformer extends ObjectTransformer<
    Map<String, ChatResponseViewModel>, Map<String, Map<String, String>>> {
  final dateFormat = DateFormat(_Constants.dateFormat);

  @override
  Map<String, Map<String, String>> transform(
      {Map<String, ChatResponseViewModel> from}) {
    return from.map((key, value) {
      return MapEntry(key, _transformOptions(value));
    });
  }

  Map<String, String> _transformOptions(
      ChatResponseViewModel chatResponseViewModel) {
    Map<String, String> responseMap = {};
    responseMap[ChatResponseKeys.keyId] = chatResponseViewModel.id;
    responseMap[ChatResponseKeys.keyTitle] = chatResponseViewModel.title;
    final date = castOrNull<DateTime>(chatResponseViewModel.value);
    if (date != null) {
      responseMap[ChatResponseKeys.keyValue] = dateFormat.format(date);
    } else {
      responseMap[ChatResponseKeys.keyValue] = chatResponseViewModel.value;
    }

    return responseMap;
  }
}

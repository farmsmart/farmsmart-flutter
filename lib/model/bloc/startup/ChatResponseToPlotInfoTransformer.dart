import 'package:farmsmart_flutter/chat/ui/viewmodel/ChatResponseViewModel.dart';
import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:intl/intl.dart';

class _Strings {
  static const dateFormat = "MMMM";
}

class ChatResponseToPlotInfoTransformer extends ObjectTransformer<Map<String,ChatResponseViewModel>, Map<String,String>> {

  final dateFormat = DateFormat(_Strings.dateFormat);

  @override
  Map<String,String> transform({Map<String,ChatResponseViewModel> from}) {
    return from.map((key,value){
      final date = castOrNull<DateTime>(value.value);
      if (date != null){
        return MapEntry(key, dateFormat.format(date));
      }
      return MapEntry(key, value.id);
    });
  }
}
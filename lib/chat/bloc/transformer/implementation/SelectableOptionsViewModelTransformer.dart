import 'package:farmsmart_flutter/chat/model/form/input_request_entity.dart';
import 'package:farmsmart_flutter/chat/model/form/selectable_option_entity.dart';
import 'package:farmsmart_flutter/chat/ui/viewmodel/SelectableOptionViewModel.dart';
import 'package:farmsmart_flutter/chat/ui/viewmodel/SelectableOptionsViewModel.dart';

import 'package:farmsmart_flutter/chat/bloc/transformer/Transformer.dart';
import 'package:farmsmart_flutter/chat/bloc/transformer/implementation/SelectableOptionViewModelTransformer.dart';

class SelectableOptionsViewModelTransformer
    implements
        ObjectTransformer<InputRequestEntity, SelectableOptionsViewModel> {
  @override
  SelectableOptionsViewModel transform({InputRequestEntity from}) {
    return SelectableOptionsViewModel(
      maxSelection: from.args.maxSelection,
      options: _transformOptions(from.args.options),
    );
  }

  List<SelectableOptionViewModel> _transformOptions(
      List<SelectableOptionEntity> from) {
    SelectableOptionViewModelTransformer transformer =
        SelectableOptionViewModelTransformer();
    List<SelectableOptionViewModel> response = [];
    from.forEach((option) {
      response.add(transformer.transform(from: option));
    });
    return response;
  }
}

import 'package:farmsmart_flutter/chat/model/form/selectable_option_entity.dart';
import 'package:farmsmart_flutter/chat/ui/viewmodel/SelectableOptionViewModel.dart';

import 'package:farmsmart_flutter/chat/bloc/transformer/Transformer.dart';

class SelectableOptionViewModelTransformer
    implements
        ObjectTransformer<SelectableOptionEntity, SelectableOptionViewModel> {
  @override
  SelectableOptionViewModel transform({SelectableOptionEntity from}) {
    return SelectableOptionViewModel(
      id: from.id,
      title: from.title,
      description: from.description,
      responseText: from.responseText,
    );
  }
}

import 'package:farmsmart_flutter/ui/common/SectionListView.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:flutter/widgets.dart';

import 'CropInfoListItem.dart';

class CropInfoList extends StatelessWidget implements  ListViewSection {
  final List<CropInfoListItemViewModel> _items;

  const CropInfoList({Key key, List<CropInfoListItemViewModel> items}) : this._items = items, super(key: key); 
  @override
  Widget build(BuildContext context) {
    return HeaderAndFooterListView(itemBuilder: itemBuilder(), itemCount: itemCount(),);
  }

  @override
  itemBuilder() {
    return (BuildContext context, int index) {
      final itemViewModel = _items[index];
      return CropInfoListItem(viewModel: itemViewModel,);
    };
  }

  @override
  int itemCount() {
    return _items.length;
  }
}
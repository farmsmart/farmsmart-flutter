import 'package:farmsmart_flutter/ui/common/SectionListView.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_detail_listitem/recommendation_detail_listitem.dart';
import 'package:flutter/widgets.dart';

class CropInfoList extends StatelessWidget implements  ListViewSection {
  final List<RecommendationDetailListItemViewModel> _items;

  const CropInfoList({Key key, List<RecommendationDetailListItemViewModel> items}) : this._items = items, super(key: key); 
  @override
  Widget build(BuildContext context) {
    return HeaderAndFooterListView(itemBuilder: itemBuilder(), itemCount: itemCount(),);
  }

  @override
  itemBuilder() {
    return (BuildContext context, int index) {
      final itemViewModel = _items[index];
      return RecommendationDetailListItem(viewModel: itemViewModel,);
    };
  }

  @override
  int itemCount() {
    return _items.length;
  }
}
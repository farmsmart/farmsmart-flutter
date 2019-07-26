import 'package:farmsmart_flutter/ui/common/SectionListView.dart';
import 'package:flutter/material.dart';

/* 
Simple Widget to add header and footer elements to a list of elements
It should ensure elements are built as needed and not the whole list.
It hides the data offsetting complexity 
*/
class HeaderAndFooterListView extends StatelessWidget implements ListViewSection {

  final IndexedWidgetBuilder _containedItemBuilder;
  final int _containedItemCount;
  final List<Widget> _headers;
  final List<Widget> _footers;
  final ScrollPhysics _physics;
  final bool _shrinkWrap;

  HeaderAndFooterListView({IndexedWidgetBuilder itemBuilder, int itemCount = 0, List<Widget> headers = const [], List<Widget>  footers = const [], ScrollPhysics physics, bool shrinkWrap}) : this._containedItemBuilder = itemBuilder, 
  this._containedItemCount = itemCount, this._headers = headers, this._footers = footers, this._physics = physics, this._shrinkWrap = shrinkWrap;

  /*
  Modeling with lists for headers and footers simplifys the logic here and may be useful in the future
  For now we only expose the single header and footer functionality
  */

    @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: _physics,
      shrinkWrap: _shrinkWrap,
      itemCount: length(),
      itemBuilder: itemBuilder(),
    );
  }

  @override
  int length() {
    int headerLength =  _headers.length;
    int footerLength =  _footers.length;
    return headerLength + _containedItemCount + footerLength;
  }

  @override
  IndexedWidgetBuilder itemBuilder() {
    return (context, index) {
        int itemCount = _containedItemCount;
        int itemIndex = index - _headers.length; // index in terms of items
        int footerIndex = itemIndex - itemCount;  // index in terms of footer elements
        if (index < _headers.length) {
          return _headers[index];
        }
        else if (itemIndex < itemCount) {
          return _containedItemBuilder(context, itemIndex);
        }
        else {
          return _footers[footerIndex];
        }
      };
  }

}

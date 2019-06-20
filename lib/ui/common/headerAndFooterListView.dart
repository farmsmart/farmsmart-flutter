import 'package:flutter/material.dart';

/* 
Simple Widget to add header and footer elements to a list of elements
It should ensure elements are built as needed and not the whole list.
It hides the data offsetting complexity 
*/
class HeaderAndFooterListView {
  static Widget builder(
      {@required int itemCount,
      @required IndexedWidgetBuilder itemBuilder,
      ScrollPhysics physics,
      bool shrinkWrap = false,
      Widget header,
      Widget footer}) {
    final headerPresent = (header != null);
    final footerPresent = (footer != null);
    final empty  = <Widget>[];
    final headers = headerPresent ? [header] : empty;
    final footers = footerPresent ? [footer] : empty;
    return _builder(
        itemCount: itemCount,
        itemBuilder: itemBuilder,
        physics: physics,
        shrinkWrap: shrinkWrap,
        headers: headers,
        footers: footers);
  }

  /*
  Modeling with lists for headers and footers simplifys the logic here and may be useful in the future
  For now we only expose the single header and footer functionality
  */
  static Widget _builder(
      { @required int itemCount,
      @required IndexedWidgetBuilder itemBuilder,
      ScrollPhysics physics,
      bool shrinkWrap = false,
      List<Widget> headers = const <Widget>[],
      List<Widget> footers = const <Widget>[]}) {
    final int totalItemCount = headers.length + itemCount + footers.length;
    return ListView.builder(
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemCount: totalItemCount,
      itemBuilder: (context, index) {
        int itemIndex = index - headers.length; // index in terms of items
        int footerIndex = itemIndex - itemCount;  // index in terms of footer elements
        if (index < headers.length) {
          return headers[index];
        }
        else if (itemIndex < itemCount) {
          return itemBuilder(context, itemIndex);
        }
        else {
          return footers[footerIndex];
        }
      },
    );
  }
}

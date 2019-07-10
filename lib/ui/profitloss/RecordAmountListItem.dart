import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class RecordAmountListItemViewModel {
  String icon;
  String title;
  String hint;
  String arrow;
  DateTime selectedDate;
  List<String> listOfCrops = [];
  String selectedCrop;

  RecordAmountListItemViewModel(this.icon, this.hint,
      {this.arrow,
      this.title,
      this.selectedDate,
      this.listOfCrops,
      this.selectedCrop});
}

class RecordAmountListItemStyle {
  final Color actionItemBackgroundColor;

  final TextStyle titleTextStyle;
  final TextStyle pendingDetailTextStyle;
  final TextStyle detailTextStyle;

  final EdgeInsets actionItemEdgePadding;
  final EdgeInsets cardMargins;
  final CrossAxisAlignment itemAlignment;

  final double actionItemElevation;

  final double actionItemHeight;
  final double iconHeight;
  final double iconLineSpace;
  final double detailTextSpacing;

  final int maxLines;

  const RecordAmountListItemStyle(
      {this.actionItemBackgroundColor,
      this.titleTextStyle,
      this.pendingDetailTextStyle,
      this.detailTextStyle,
      this.actionItemEdgePadding,
      this.cardMargins,
      this.itemAlignment,
      this.actionItemElevation,
      this.actionItemHeight,
      this.iconHeight,
      this.iconLineSpace,
      this.detailTextSpacing,
      this.maxLines});

  RecordAmountListItemStyle copyWith(
      {Color actionItemBackgroundColor,
      TextStyle titleTextStyle,
      TextStyle pendingDetailTextStyle,
      TextStyle detailTextStyle,
      EdgeInsets actionItemEdgePadding,
      EdgeInsets cardMargins,
      CrossAxisAlignment itemAlignment,
      double actionItemElevation,
      double actionItemHeight,
      double iconHeight,
      double iconLineSpace,
      double detailTextSpacing,
      int maxLines}) {
    return RecordAmountListItemStyle(
        actionItemBackgroundColor:
            actionItemBackgroundColor ?? this.actionItemBackgroundColor,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        pendingDetailTextStyle:
            pendingDetailTextStyle ?? this.pendingDetailTextStyle,
        detailTextStyle: detailTextStyle ?? this.detailTextStyle,
        actionItemEdgePadding:
            actionItemEdgePadding ?? this.actionItemEdgePadding,
        cardMargins: cardMargins ?? this.cardMargins,
        itemAlignment: itemAlignment ?? this.itemAlignment,
        actionItemElevation: actionItemElevation ?? this.actionItemElevation,
        actionItemHeight: actionItemHeight ?? this.actionItemHeight,
        iconHeight: iconHeight ?? this.iconHeight,
        iconLineSpace: iconLineSpace ?? this.iconLineSpace,
        detailTextSpacing: detailTextSpacing ?? this.detailTextSpacing,
        maxLines: maxLines ?? this.maxLines);
  }
}

class _DefaultStyle extends RecordAmountListItemStyle {
  final Color actionItemBackgroundColor = const Color(0x00000000);

  final TextStyle titleTextStyle = const TextStyle(
      fontSize: 17, fontWeight: FontWeight.w400, color: Color(0xFF1a1b46));
  final TextStyle pendingDetailTextStyle = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.normal, color: Color(0x4c767690));
  final TextStyle detailTextStyle = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.normal, color: Color(0xff767690));

  final EdgeInsets actionItemEdgePadding =
      const EdgeInsets.symmetric(horizontal: 32);
  final EdgeInsets cardMargins = const EdgeInsets.all(0);

  final double actionItemElevation = 0;
  final CrossAxisAlignment itemAlignment = CrossAxisAlignment.center;

  final double actionItemHeight = 70;
  final double iconHeight = 20;
  final double iconLineSpace = 22;
  final double detailTextSpacing = 13;

  final int maxLines = 5;

  const _DefaultStyle(
      {Color actionItemBackgroundColor,
      TextStyle titleTextStyle,
      TextStyle pendingDetailTextStyle,
      TextStyle detailTextStyle,
      EdgeInsets actionItemEdgePadding,
      EdgeInsets cardMargins,
      CrossAxisAlignment itemAlignment,
      double actionItemElevation,
      double actionItemHeight,
      double iconHeight,
      double iconLineSpace,
      double detailTextSpacing,
      int maxLines});
}

const RecordAmountListItemStyle _defaultStyle = const _DefaultStyle();

class RecordAmountListItem extends StatefulWidget {
  final RecordAmountListItemStyle _style;
  final RecordAmountListItemViewModel _viewModel;

  const RecordAmountListItem(
      {Key key,
      RecordAmountListItemViewModel viewModel,
      RecordAmountListItemStyle style = _defaultStyle})
      : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  _RecordAmountListItemState createState() => _RecordAmountListItemState();
}

class _RecordAmountListItemState extends State<RecordAmountListItem> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
            margin: widget._style.cardMargins,
            elevation: widget._style.actionItemElevation,
            color: widget._style.actionItemBackgroundColor,
            child: Container(
              padding: widget._style.actionItemEdgePadding,
              alignment: Alignment.center,
              height: widget._style.actionItemHeight,
              child: Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: widget._style.itemAlignment,
                      children: _buildCellContent(),
                    )
                  ]),
            ))
      ],
    );
  }

  List<Widget> _buildCellContent() {
    List<Widget> listBuilder = [
      Image.asset(widget._viewModel.icon, height: widget._style.iconHeight),
      SizedBox(width: widget._style.iconLineSpace),
    ];

    if (widget._viewModel.selectedDate != null) {
      listBuilder.add(
          Text(widget._viewModel.title, style: widget._style.titleTextStyle));

      listBuilder.add(Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            InkWell(
                child: Text(
                    formatDate(widget._viewModel.selectedDate) ==
                            formatDate(DateTime.now())
                        ? widget._viewModel.hint
                        : formatDate(widget._viewModel.selectedDate),
                    style: widget._style.detailTextStyle),
                onTap: () => _selectDate(context)),
          ],
        ),
      ));
    }

    if (widget._viewModel.listOfCrops != null) {
      listBuilder.add(
          Text(widget._viewModel.title, style: widget._style.titleTextStyle));
      listBuilder.add(Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            DropdownButtonHideUnderline(
              child: DropdownButton(
                  value: widget._viewModel.selectedCrop,
                  style: widget._style.detailTextStyle,
                  items: getDropDownMenuItems(),
                  onChanged: changeDropDownItem,
                  hint: Text(widget._viewModel.hint,
                      style: widget._style.pendingDetailTextStyle),
                  icon: Icon(Icons.lens, size: 0)),
            )
          ],
        ),
      ));
    }

    if (widget._viewModel.selectedDate == null &&
        widget._viewModel.listOfCrops == null) {
      listBuilder.add(Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  hintText: widget._viewModel.hint,
                  hintStyle: widget._style.pendingDetailTextStyle,
                  border: InputBorder.none,
                  contentPadding: widget._style.cardMargins,
                  counterText: ""),
              textAlign: TextAlign.left,
              style: widget._style.detailTextStyle,
              maxLines: widget._style.maxLines,
            ),
          ],
        ),
      ));
      return listBuilder;
    }

    listBuilder.add(SizedBox(width: widget._style.iconLineSpace));
    listBuilder.add(Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Image.asset(widget._viewModel.arrow,
              height: widget._style.detailTextSpacing)
        ]));

    return listBuilder;
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: widget._viewModel.selectedDate,
        firstDate: DateTime(2019, 6),
        lastDate: DateTime(2101));

    if (picked != null && picked != widget._viewModel.selectedDate)
      setState(() {
        widget._viewModel.selectedDate = picked;
        formatDate(widget._viewModel.selectedDate);
      });
  }

  String formatDate(DateTime selectedDate) {
    var formatter = DateFormat('dd MMMM yyyy');
    String formatted = formatter.format(selectedDate);
    print(formatted);
    return formatted;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String crop in widget._viewModel.listOfCrops) {
      items.add(new DropdownMenuItem(value: crop, child: new Text(crop)));
    }
    return items;
  }

  void changeDropDownItem(String selectedCrop) {
    setState(() {
      widget._viewModel.selectedCrop = selectedCrop;
    });
  }
}

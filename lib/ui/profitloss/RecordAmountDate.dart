import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class RecordAmountPickerViewModel {
  String icon;
  String title;
  String detail;
  String arrow;
  DateTime selectedDate;
  List<String> listOfCrops = [];
  String selectedCrop;

  RecordAmountPickerViewModel(this.icon, this.title, this.detail, this.arrow,
      {this.selectedDate, this.listOfCrops, this.selectedCrop});
}

abstract class RecordAmountPickerStyle {
  final Color actionItemBackgroundColor;

  final TextStyle titleTextStyle;
  final TextStyle pendingTitleTextStyle;
  final TextStyle detailTextStyle;

  final EdgeInsets actionItemEdgePadding;

  final double actionItemElevation;

  final double actionItemHeight;
  final double iconHeight;
  final double iconLineSpace;

  RecordAmountPickerStyle(
      this.actionItemBackgroundColor,
      this.titleTextStyle,
      this.pendingTitleTextStyle,
      this.detailTextStyle,
      this.actionItemEdgePadding,
      this.actionItemElevation,
      this.actionItemHeight,
      this.iconHeight,
      this.iconLineSpace);

  RecordAmountPickerStyle copyWith(
      {Color actionItemBackgroundColor,
      TextStyle titleTextStyle,
      TextStyle pendingTitleTextStyle,
      TextStyle detailTextStyle,
      EdgeInsets actionItemEdgePadding,
      double actionItemElevation,
      double actionItemHeight,
      double iconHeight,
      double iconLineSpace});
}

class _DefaultStyle implements RecordAmountPickerStyle {
  final Color actionItemBackgroundColor = const Color(0x00000000);

  final TextStyle titleTextStyle = const TextStyle(
      fontSize: 17, fontWeight: FontWeight.w400, color: Color(0xFF1a1b46));
  final TextStyle pendingTitleTextStyle = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.normal, color: Color(0x4c767690));
  final TextStyle detailTextStyle = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.normal, color: Color(0xff767690));

  final EdgeInsets actionItemEdgePadding =
      const EdgeInsets.symmetric(horizontal: 32);

  final double actionItemElevation = 0;

  final double actionItemHeight = 70;
  final double iconHeight = 20;
  final double iconLineSpace = 22;

  const _DefaultStyle(
      {Color actionItemBackgroundColor,
      TextStyle titleTextStyle,
      TextStyle pendingTitleTextStyle,
      TextStyle detailTextStyle,
      EdgeInsets actionItemEdgePadding,
      double actionItemElevation,
      double actionItemHeight,
      double iconHeight,
      double iconLineSpace});

  @override
  RecordAmountPickerStyle copyWith(
      {Color actionItemBackgroundColor,
      TextStyle titleTextStyle,
      TextStyle pendingTitleTextStyle,
      TextStyle detailTextStyle,
      EdgeInsets actionItemEdgePadding,
      double actionItemElevation,
      double actionItemHeight,
      double iconHeight,
      double iconLineSpace}) {
    return _DefaultStyle(
        actionItemBackgroundColor:
            actionItemBackgroundColor ?? this.actionItemBackgroundColor,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        pendingTitleTextStyle:
            pendingTitleTextStyle ?? this.pendingTitleTextStyle,
        detailTextStyle: detailTextStyle ?? this.detailTextStyle,
        actionItemEdgePadding:
            actionItemEdgePadding ?? this.actionItemEdgePadding,
        actionItemElevation: actionItemElevation ?? this.actionItemElevation,
        actionItemHeight: actionItemHeight ?? this.actionItemHeight);
  }
}

const RecordAmountPickerStyle _defaultStyle = const _DefaultStyle();

class RecordAmountPicker extends StatefulWidget {
  final RecordAmountPickerStyle _style;
  final RecordAmountPickerViewModel _viewModel;

  const RecordAmountPicker(
      {Key key,
      RecordAmountPickerViewModel viewModel,
      RecordAmountPickerStyle style = _defaultStyle})
      : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  _RecordAmountPickerState createState() => _RecordAmountPickerState();
}

class _RecordAmountPickerState extends State<RecordAmountPicker> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
            margin: EdgeInsets.all(0),
            elevation: 0,
            color: Color(0x00000000),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32),
              alignment: Alignment.center,
              height: 70,
              child: Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
      Text(widget._viewModel.title, style: widget._style.titleTextStyle)
    ];

    if (widget._viewModel.selectedDate != null) {
      listBuilder.add(Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            InkWell(
                child: Text(
                    formatDate(widget._viewModel.selectedDate) ==
                            formatDate(DateTime.now())
                        ? "Today"
                        : formatDate(widget._viewModel.selectedDate),
                    style: widget._style.detailTextStyle),
                onTap: () => _selectDate(context)),
          ],
        ),
      ));
    }

    if (widget._viewModel.listOfCrops != null) {
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
                hint: Text("Select...", style: widget._style.pendingTitleTextStyle),
                icon: Icon(Icons.lens, size: 0),
              ),
            )
          ],
        ),
      ));
    }

    listBuilder.add(SizedBox(width: widget._style.iconLineSpace));
    listBuilder.add(Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[Image.asset(widget._viewModel.arrow, height: 13)]));

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

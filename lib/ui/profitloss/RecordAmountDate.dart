import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class RecordAmountDateViewModel {
  String icon;
  String title;
  String detail;
  String arrow;
  DateTime selectedDate;

  RecordAmountDateViewModel(this.icon, this.title, this.detail, this.arrow,
      this.selectedDate);
}

abstract class RecordAmountDateStyle {
  final Color actionItemBackgroundColor;

  final TextStyle titleTextStyle;
  final TextStyle pendingTitleTextStyle;
  final TextStyle detailTextStyle;

  final EdgeInsets actionItemEdgePadding;

  final double actionItemElevation;

  final double actionItemHeight;
  final double iconHeight;
  final double iconLineSpace;

  RecordAmountDateStyle(this.actionItemBackgroundColor, this.titleTextStyle,
      this.pendingTitleTextStyle, this.detailTextStyle,
      this.actionItemEdgePadding, this.actionItemElevation,
      this.actionItemHeight, this.iconHeight, this.iconLineSpace);

  RecordAmountDateStyle copyWith(
      {Color actionItemBackgroundColor, TextStyle titleTextStyle,
        TextStyle pendingTitleTextStyle, TextStyle detailTextStyle,
        EdgeInsets actionItemEdgePadding, double actionItemElevation,
        double actionItemHeight, double iconHeight, double iconLineSpace});
}

class _DefaultStyle implements RecordAmountDateStyle {
  final Color actionItemBackgroundColor = const Color(0x00000000);

  final TextStyle titleTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Color(0xFF1a1b46));
  final TextStyle pendingTitleTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Color(0xFF767690));
  final TextStyle detailTextStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Color(0x4c767690));

  final EdgeInsets actionItemEdgePadding =  const EdgeInsets.symmetric(horizontal: 32);

  final double actionItemElevation = 0;

  final double actionItemHeight = 70;
  final double iconHeight = 20;
  final double iconLineSpace = 22;

  const _DefaultStyle({Color actionItemBackgroundColor, TextStyle titleTextStyle,
    TextStyle pendingTitleTextStyle, TextStyle detailTextStyle,
    EdgeInsets actionItemEdgePadding, double actionItemElevation,
    double actionItemHeight, double iconHeight, double iconLineSpace});

  @override
  RecordAmountDateStyle copyWith(
      {Color actionItemBackgroundColor, TextStyle titleTextStyle,
        TextStyle pendingTitleTextStyle, TextStyle detailTextStyle,
        EdgeInsets actionItemEdgePadding, double actionItemElevation,
        double actionItemHeight, double iconHeight, double iconLineSpace}) {
    return _DefaultStyle(
      actionItemBackgroundColor: actionItemBackgroundColor ?? this.actionItemBackgroundColor,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      pendingTitleTextStyle: pendingTitleTextStyle ?? this.pendingTitleTextStyle,
      detailTextStyle: detailTextStyle ?? this.detailTextStyle,
      actionItemEdgePadding: actionItemEdgePadding ?? this.actionItemEdgePadding,
      actionItemElevation: actionItemElevation ?? this.actionItemElevation,
      actionItemHeight: actionItemHeight ?? this.actionItemHeight
    );
  }
}

const RecordAmountDateStyle _defaultStyle = const _DefaultStyle();


class RecordAmountDate extends StatefulWidget {
  final RecordAmountDateStyle _style;
  final RecordAmountDateViewModel _viewModel;

  const RecordAmountDate(
      {Key key, RecordAmountDateViewModel viewModel, RecordAmountDateStyle style = _defaultStyle})
      : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  _RecordAmountDateState createState() => _RecordAmountDateState();
}

class _RecordAmountDateState extends State<RecordAmountDate> {

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
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
                  children: _buildActionContent(context, widget._style, widget._viewModel)
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  List<Widget> _buildActionContent(BuildContext context, RecordAmountDateStyle style, RecordAmountDateViewModel viewModel) {
    List<Widget> listBuilder = [];

    listBuilder.add(Image.asset(viewModel.icon, height: style.iconHeight));
    listBuilder.add(SizedBox(width: style.iconLineSpace));

    listBuilder.add(Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
              decoration: InputDecoration.collapsed(hintText: viewModel.title, hintStyle: style.pendingTitleTextStyle),
              style: style.titleTextStyle,
              //overflow: TextOverflow.ellipsis,
              maxLines: 5),
        ],
      ),
    ));

    listBuilder.add(Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          InkWell(child:
          Text(formatDate(viewModel.selectedDate) == formatDate(DateTime.now()) ? "Today" : formatDate(viewModel.selectedDate), style: style.detailTextStyle),
          onTap: () => _selectDate(context)),
        ],
      ),
    ));

      listBuilder.add(SizedBox(width: style.iconLineSpace));
      listBuilder.add(Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Image.asset(viewModel.arrow, height: 13)
        ],
      ));

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
}
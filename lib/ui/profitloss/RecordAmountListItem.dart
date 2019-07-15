import 'package:farmsmart_flutter/ui/profitloss/RecordAmount.dart';
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
  String selectedItem;
  String description;
  final Function(String) listener;
  bool isEditable;

  RecordAmountListItemViewModel(
      {this.icon,
      this.hint,
      this.arrow,
      this.title,
      this.selectedDate,
      this.listOfCrops,
      this.selectedItem,
      this.description,
      this.listener,
      this.isEditable : true});
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
      const EdgeInsets.only(left: 32, right: 32, top: 25.8, bottom: 25.8);
  final EdgeInsets cardMargins = const EdgeInsets.all(0);

  final double actionItemElevation = 0;
  final CrossAxisAlignment itemAlignment = CrossAxisAlignment.center;

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
      double iconHeight,
      double iconLineSpace,
      double detailTextSpacing,
      int maxLines});
}

const RecordAmountListItemStyle _defaultStyle = const _DefaultStyle();

class RecordAmountListItem extends StatefulWidget {
  final RecordAmountListItemStyle _style;
  final RecordAmountListItemViewModel _viewModel;
  RecordAmountState parent;

  RecordAmountListItem(
      {Key key,
      RecordAmountListItemViewModel viewModel,
      RecordAmountListItemStyle style = _defaultStyle,
      RecordAmountState parent})
      : this._viewModel = viewModel,
        this._style = style,
        this.parent = parent,
        super(key: key);

  @override
  _RecordAmountListItemState createState() => _RecordAmountListItemState();
}

class _RecordAmountListItemState extends State<RecordAmountListItem> {
  final _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    RecordAmountListItemViewModel viewModel = widget._viewModel;
    RecordAmountListItemStyle style = widget._style;

    return Column(
      children: <Widget>[
        Card(
            margin: style.cardMargins,
            elevation: style.actionItemElevation,
            color: style.actionItemBackgroundColor,
            child: Container(
              padding: style.actionItemEdgePadding,
              alignment: Alignment.center,
              child: Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: style.itemAlignment,
                      children: _buildItemContent(viewModel, style),
                    )
                  ]),
            ))
      ],
    );
  }

  List<Widget> _buildItemContent(RecordAmountListItemViewModel viewModel, RecordAmountListItemStyle style) {
    List<Widget> listBuilder = [
      Image.asset(viewModel.icon, height: style.iconHeight),
      SizedBox(width: style.iconLineSpace),
    ];

    if (viewModel.selectedDate != null) {
      _buildDatePicker(listBuilder, viewModel, style);
    }

    if (viewModel.listOfCrops != null) {
      _buildItemPicker(listBuilder, viewModel, style);
    }

    if (viewModel.selectedDate == null &&
        viewModel.listOfCrops == null) {
      return _buildDescriptionTextField(listBuilder, viewModel, style);
    }

    if (viewModel.isEditable) {
      listBuilder.add(SizedBox(width: style.iconLineSpace));
      listBuilder.add(Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Image.asset(viewModel.arrow,
                height: style.detailTextSpacing)
          ]));
    }

    return listBuilder;
  }

  List<Widget> _buildDescriptionTextField(List<Widget> listBuilder, RecordAmountListItemViewModel viewModel, RecordAmountListItemStyle style) {
    listBuilder.add(Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          viewModel.isEditable
              ? TextField(
                  decoration: InputDecoration(
                      hintText: viewModel.hint,
                      hintStyle: style.pendingDetailTextStyle,
                      border: InputBorder.none,
                      contentPadding: style.cardMargins,
                      counterText: ""),
                  textAlign: TextAlign.left,
                  style: style.detailTextStyle,
                  maxLines: style.maxLines,
                  controller: _textFieldController,
                  onEditingComplete: () => _checkTextField(viewModel),
                  enabled:viewModel.isEditable,
                )
              : Text(viewModel.description,
                  textAlign: TextAlign.left,
                  style: style.detailTextStyle)
        ],
      ),
    ));
    return listBuilder;
  }

  void _buildItemPicker(List<Widget> listBuilder, RecordAmountListItemViewModel viewModel, RecordAmountListItemStyle style) {
    listBuilder.add(
        Text(viewModel.title, style: style.titleTextStyle));
    listBuilder.add(Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          viewModel.isEditable
              ? DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: viewModel.selectedItem,
                    style: style.detailTextStyle,
                    items: viewModel.isEditable
                        ? _getDropDownMenuItems(viewModel)
                        : null,
                    onChanged: _changeDropDownItem,
                    hint: Text(viewModel.hint,
                        style: style.pendingDetailTextStyle),
                    icon: Icon(Icons.lens, size: 0),
                    isDense: true,
                    isExpanded: false,
                  ),
                )
              : Text(viewModel.selectedItem,
                  style: style.detailTextStyle)
        ],
      ),
    ));
  }

  void _buildDatePicker(List<Widget> listBuilder, RecordAmountListItemViewModel viewModel, RecordAmountListItemStyle style) {
    listBuilder.add(
        Text(viewModel.title, style: style.titleTextStyle));

    listBuilder.add(Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          InkWell(
              child: Text(
                  _formatDate(viewModel.selectedDate) ==
                          _formatDate(DateTime.now())
                      ? viewModel.hint
                      : _formatDate(viewModel.selectedDate),
                  style: style.detailTextStyle),
              onTap: () =>
                  viewModel.isEditable ? _selectDate(context, viewModel) : null),
        ],
      ),
    ));
  }

  Future<Null> _selectDate(BuildContext context, RecordAmountListItemViewModel viewModel) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: viewModel.selectedDate,
        firstDate: DateTime(2019, 6),
        lastDate: DateTime(2101));

    if (picked != null && picked != viewModel.selectedDate)
      setState(() {
        viewModel.selectedDate = picked;
        _formatDate(viewModel.selectedDate);
      });
  }

  String _formatDate(DateTime selectedDate) {
    var formatter = DateFormat('dd MMMM yyyy');
    String formatted = formatter.format(selectedDate);
    print(formatted);
    return formatted;
  }

  List<DropdownMenuItem<String>> _getDropDownMenuItems(RecordAmountListItemViewModel viewModel) {
    List<DropdownMenuItem<String>> items = new List();
    for (String crop in viewModel.listOfCrops) {
      items.add(new DropdownMenuItem(value: crop,
          child: new Text(crop)));
    }
    return items;
  }

  void _checkTextField(RecordAmountListItemViewModel viewModel) {
    setState(() {
      if (_textFieldController.text != null) {
        viewModel.description = _textFieldController.text;
      }
    });
  }

  void _changeDropDownItem(String selectedCrop) {
    setState(() {
      widget._viewModel.selectedItem = selectedCrop;
      widget.parent.selectedCrop = selectedCrop;
      widget.parent.cropIsFilled = true;
      widget.parent.checkIfFilled();
    });
  }
}

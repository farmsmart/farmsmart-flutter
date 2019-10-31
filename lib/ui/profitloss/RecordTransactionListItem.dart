import 'package:farmsmart_flutter/ui/profitloss/RecordTransaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class _Constants {
  static final currentDate = DateTime.now();
  static final minDateLimit = DateTime(2019, 6);
  static final maxDateLimit = DateTime(2101);
  static final dateFormatter = DateFormat('dd MMMM yyyy');
  static final dateIcon = "assets/icons/detail_icon_date.png";
  static final cropIcon = "assets/icons/detail_icon_best_soil.png";
  static final descriptionIcon = "assets/icons/detail_icon_description.png";
  static final arrowIcon = "assets/icons/chevron.png";
}

class _LocalisedStrings {
  static String date() => Intl.message('Date');

  static String crop() => Intl.message('Crop');

  static String today() => Intl.message('Today');

  static String select() => Intl.message('Select...');

  static String description() => Intl.message('Description (optional)...');
}

class _Strings {
  static final emptyString = "";
}

enum RecordCellType {
  pickDate,
  pickItem,
  description,
}

class RecordTransactionListItemViewModel {
  RecordCellType type;
  DateTime selectedDate = DateTime.now();
  List<String> listOfCrops = [];
  String selectedItem;
  String description;
  bool isEditable;

  RecordTransactionListItemViewModel({
    this.type,
    this.selectedDate,
    this.listOfCrops,
    this.selectedItem,
    this.description,
    this.isEditable: true,
  });
}

class RecordTransactionListItemStyle {
  final TextStyle titleTextStyle;
  final TextStyle pendingDetailTextStyle;
  final TextStyle detailTextStyle;

  final EdgeInsets actionItemEdgePadding;
  final EdgeInsets cardMargins;

  final Offset pickerPosition;

  final double iconHeight;
  final double iconLineSpace;
  final double detailTextSpacing;
  final double descriptionLineSpace;

  final int maxLines;

  const RecordTransactionListItemStyle({
    this.titleTextStyle,
    this.pendingDetailTextStyle,
    this.detailTextStyle,
    this.actionItemEdgePadding,
    this.cardMargins,
    this.pickerPosition,
    this.iconHeight,
    this.iconLineSpace,
    this.detailTextSpacing,
    this.descriptionLineSpace,
    this.maxLines,
  });

  RecordTransactionListItemStyle copyWith({
    TextStyle titleTextStyle,
    TextStyle pendingDetailTextStyle,
    TextStyle detailTextStyle,
    EdgeInsets actionItemEdgePadding,
    EdgeInsets cardMargins,
    Offset pickerPosition,
    double iconHeight,
    double iconLineSpace,
    double detailTextSpacing,
    double descriptionLineSpace,
    int maxLines,
  }) {
    return RecordTransactionListItemStyle(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      pendingDetailTextStyle:
          pendingDetailTextStyle ?? this.pendingDetailTextStyle,
      detailTextStyle: detailTextStyle ?? this.detailTextStyle,
      actionItemEdgePadding:
          actionItemEdgePadding ?? this.actionItemEdgePadding,
      cardMargins: cardMargins ?? this.cardMargins,
      pickerPosition: pickerPosition ?? this.pickerPosition,
      iconHeight: iconHeight ?? this.iconHeight,
      iconLineSpace: iconLineSpace ?? this.iconLineSpace,
      detailTextSpacing: detailTextSpacing ?? this.detailTextSpacing,
      descriptionLineSpace: descriptionLineSpace ?? this.descriptionLineSpace,
      maxLines: maxLines ?? this.maxLines,
    );
  }
}

class _DefaultStyle extends RecordTransactionListItemStyle {
  final TextStyle titleTextStyle = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: Color(0xFF1a1b46),
  );

  final TextStyle detailTextStyle = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: Color(0xff767690),
  );

  final TextStyle pendingDetailTextStyle = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: Color(0x4c767690),
  );

  final EdgeInsets actionItemEdgePadding =
      const EdgeInsets.only(left: 32, right: 32, top: 10.5, bottom: 10.5);
  final EdgeInsets cardMargins = const EdgeInsets.all(0);

  final Offset pickerPosition = const Offset(90, 0);

  final double iconHeight = 20;
  final double iconLineSpace = 22;
  final double detailTextSpacing = 13;
  final double descriptionLineSpace = 12;

  final int maxLines = 5;

  const _DefaultStyle({
    TextStyle titleTextStyle,
    TextStyle pendingDetailTextStyle,
    TextStyle detailTextStyle,
    EdgeInsets actionItemEdgePadding,
    EdgeInsets cardMargins,
    Offset pickerPosition,
    double iconHeight,
    double iconLineSpace,
    double detailTextSpacing,
    double descriptionLineSpace,
    int maxLines,
  });
}

const RecordTransactionListItemStyle _defaultStyle = const _DefaultStyle();

class RecordTransactionListItem extends StatefulWidget {
  final RecordTransactionListItemStyle _style;
  final RecordTransactionListItemViewModel _viewModel;
  final GlobalKey _pickerKey = new GlobalKey();

  RecordTransactionState parent;

  RecordTransactionListItem(
      {Key key,
      RecordTransactionListItemViewModel viewModel,
      RecordTransactionListItemStyle style = _defaultStyle,
      RecordTransactionState parent})
      : this._viewModel = viewModel,
        this._style = style,
        this.parent = parent,
        super(key: key);

  @override
  _RecordTransactionListItemState createState() =>
      _RecordTransactionListItemState();
}

class _RecordTransactionListItemState extends State<RecordTransactionListItem> {
  final _textFieldController = TextEditingController();

  var initialDescription;
  var initialDate;
  var initialSelectedItem;

  @override
  void initState() {
    super.initState();

    _initializeValues();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    RecordTransactionListItemViewModel viewModel = widget._viewModel;
    RecordTransactionListItemStyle style = widget._style;

    return Column(
      children: _buildItemContent(viewModel, style),
    );
  }

  List<Widget> _buildItemContent(RecordTransactionListItemViewModel viewModel,
      RecordTransactionListItemStyle style) {
    List<Widget> listBuilder = [];

    switch (viewModel.type) {
      case RecordCellType.pickDate:
        listBuilder.add(_buildDatePicker(viewModel, style));
        break;
      case RecordCellType.pickItem:
        listBuilder.add(_buildPickItem(viewModel, style));
        break;
      case RecordCellType.description:
        listBuilder.add(_buildDescription(viewModel, style));
        break;
    }
    return listBuilder;
  }

  ListTile _buildDatePicker(RecordTransactionListItemViewModel viewModel,
      RecordTransactionListItemStyle style) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            _Constants.dateIcon,
            height: style.iconHeight,
          ),
          SizedBox(
            width: style.iconLineSpace,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _LocalisedStrings.date(),
                  textAlign: TextAlign.start,
                  style: style.titleTextStyle,
                ),
                Text(
                  _formatDate(initialDate) ==
                          _formatDate(_Constants.currentDate)
                      ? _LocalisedStrings.today()
                      : _formatDate(initialDate),
                  textAlign: TextAlign.end,
                  style: style.detailTextStyle,
                ),
              ],
            ),
          )
        ],
      ),
      trailing: viewModel.isEditable
          ? Image.asset(
              _Constants.arrowIcon,
              height: style.detailTextSpacing,
            )
          : null,
      dense: true,
      contentPadding: style.actionItemEdgePadding,
      onTap: () => _setSelectedDate(context, viewModel),
      enabled: viewModel.isEditable,
    );
  }

  ListTile _buildPickItem(
    RecordTransactionListItemViewModel viewModel,
    RecordTransactionListItemStyle style,
  ) {
    return ListTile(
      title: viewModel.isEditable
          ? _buildCropPicker(style, viewModel)
          : _buildNonEditableCropRow(style, viewModel),
      trailing: viewModel.isEditable
          ? Image.asset(
              _Constants.arrowIcon,
              height: style.detailTextSpacing,
            )
          : null,
      dense: true,
      contentPadding: style.actionItemEdgePadding,
      onTap: () => showPopUpMenu(),
      enabled: viewModel.isEditable,
    );
  }

  Row _buildNonEditableCropRow(
    RecordTransactionListItemStyle style,
    RecordTransactionListItemViewModel viewModel,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Image.asset(
          _Constants.cropIcon,
          height: style.iconHeight,
        ),
        SizedBox(
          width: style.iconLineSpace,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _LocalisedStrings.crop(),
                textAlign: TextAlign.start,
                style: style.titleTextStyle,
              ),
              Text(
                initialSelectedItem == null
                    ? _LocalisedStrings.select()
                    : initialSelectedItem,
                textAlign: TextAlign.end,
                style: style.detailTextStyle,
              ),
            ],
          ),
        )
      ],
    );
  }

  PopupMenuButton _buildCropPicker(
    RecordTransactionListItemStyle style,
    RecordTransactionListItemViewModel viewModel,
  ) {
    return PopupMenuButton(
      key: widget._pickerKey,
      offset: style.pickerPosition,
      onSelected: (selectedItem) => _setSelectedDropDownItem(selectedItem),
      itemBuilder: (BuildContext context) => _getDropDownMenuItems(viewModel),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            _Constants.cropIcon,
            height: style.iconHeight,
          ),
          SizedBox(
            width: style.iconLineSpace,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _LocalisedStrings.crop(),
                  textAlign: TextAlign.start,
                  style: style.titleTextStyle,
                ),
                initialSelectedItem == null
                    ? Text(
                        _LocalisedStrings.select(),
                        textAlign: TextAlign.end,
                        style: style.pendingDetailTextStyle,
                      )
                    : Text(
                        initialSelectedItem,
                        textAlign: TextAlign.end,
                        style: style.detailTextStyle,
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }

  ListTile _buildDescription(
    RecordTransactionListItemViewModel viewModel,
    RecordTransactionListItemStyle style,
  ) {
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                _Constants.descriptionIcon,
                height: style.iconHeight,
              ),
              SizedBox(width: style.iconLineSpace),
              Expanded(
                child: viewModel.isEditable
                    ? _buildEditableDescription(style, viewModel)
                    : _buildDescriptionText(viewModel, style),
              ),
            ],
          ),
          SizedBox(height: style.descriptionLineSpace)
        ],
      ),
      dense: true,
      contentPadding: style.actionItemEdgePadding,
      enabled: viewModel.isEditable,
    );
  }

  Text _buildDescriptionText(
    RecordTransactionListItemViewModel viewModel,
    RecordTransactionListItemStyle style,
  ) =>
      Text(
        viewModel.description,
        style: style.titleTextStyle,
      );

  TextField _buildEditableDescription(
    RecordTransactionListItemStyle style,
    RecordTransactionListItemViewModel viewModel,
  ) {
    return TextField(
      decoration: InputDecoration(
          hintText: _LocalisedStrings.description(),
          hintStyle: style.pendingDetailTextStyle,
          border: InputBorder.none,
          contentPadding: style.cardMargins,
          counterText: _Strings.emptyString),
      textAlign: TextAlign.left,
      style: style.detailTextStyle,
      maxLines: style.maxLines,
      controller: _textFieldController,
      onEditingComplete: () => _setDescription(viewModel),
      onChanged: (description) => _onDescriptionInputChanged(description),
      textInputAction: TextInputAction.next,
      enabled: viewModel.isEditable,
    );
  }

  _onDescriptionInputChanged(String description) {
    setState(() {
      if (description != _Strings.emptyString) {
        widget.parent.userData.description = description;
      }
    });
  }

  void showPopUpMenu() {
    dynamic popUpMenuState = widget._pickerKey.currentState;
    popUpMenuState.showButtonMenu();
  }

  Future<Null> _setSelectedDate(
    BuildContext context,
    RecordTransactionListItemViewModel viewModel,
  ) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: _Constants.minDateLimit,
      lastDate: _Constants.maxDateLimit,
    );

    if (picked != null) {
      setState(() {
        initialDate = picked;
        viewModel.selectedDate = picked;
        widget.parent.userData.date = picked;
      });
    }
  }

  String _formatDate(DateTime selectedDate) =>
      _Constants.dateFormatter.format(selectedDate);

  List<PopupMenuItem> _getDropDownMenuItems(
    RecordTransactionListItemViewModel viewModel,
  ) {
    return viewModel.listOfCrops
        .map((crop) => PopupMenuItem(value: crop, child: Text(crop)))
        .toList();
  }

  void _setDescription(RecordTransactionListItemViewModel viewModel) {
    setState(() {
      if (_textFieldController.text != null) {
        viewModel.description = _textFieldController.text;
        widget.parent.userData.description = _textFieldController.text;
      }
    });
  }

  void _setSelectedDropDownItem(String selectedCrop) {
    setState(() {
      initialSelectedItem = selectedCrop;
      widget._viewModel.selectedItem = selectedCrop;
      widget.parent.userData.crop = selectedCrop;
      widget.parent.isCropFilled = true;
      widget.parent.setIfRequiredFieldsAreFilled();
    });
  }

  void _initializeValues() {
    initialDescription = widget._viewModel.description;
    initialDate = widget._viewModel.selectedDate;
    initialSelectedItem = widget._viewModel.selectedItem;

    if(initialDescription != null && initialDescription.isNotEmpty){
      _textFieldController.text = initialDescription;
    }
  }
}

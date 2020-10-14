import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class _Constants {
  static const noDifferenceBetweenDates = 0;
  static const defaultMainAxisAlignment = MainAxisAlignment.start;
  static const defaultIsDenseList = true;
  static const defaultListTilePadding = const EdgeInsets.all(0);
  static const defaultLeftIconHeight = 20.0;
  static const defaultSizedBoxSeparatorWidth = 22.0;
  static const defaultPickerRowMainAxisAlignment =
      MainAxisAlignment.spaceBetween;
  static const defaultTrailingImageHeight = 13.0;
  static const defaultPickerDescriptionStyle = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: Color(0xFF1A1B46),
  );
  static const defaultPickerValueStyle = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: Color(0xFF767690),
  );

  static final dateFormatter = DateFormat('dd MMMM yyyy');
  static final currentDate = DateTime.now();
  static final minDateLimit = DateTime(2019, 6);
  static final maxDateLimit = DateTime(2101);
  static final dateIcon = "assets/icons/detail_icon_date.png";
  static final arrowIcon = "assets/icons/chevron.png";
}

class _LocalisedStrings {
  static String date() => Intl.message('Date');

  static String today() => Intl.message('Today');
}

class DatePickerStyle {
  final MainAxisAlignment rowMainAxisAlignment;
  final bool isDenseList;
  final EdgeInsetsGeometry listTilePadding;
  final double leftIconHeight;
  final double sizedBoxSeparatorWidth;
  final MainAxisAlignment pickerRowMainAxisAlignment;
  final double trailingImageHeight;
  final TextStyle pickerDescriptionStyle;
  final TextStyle pickerValueStyle;

  const DatePickerStyle({
    this.rowMainAxisAlignment,
    this.isDenseList,
    this.listTilePadding,
    this.leftIconHeight,
    this.sizedBoxSeparatorWidth,
    this.pickerRowMainAxisAlignment,
    this.trailingImageHeight,
    this.pickerDescriptionStyle,
    this.pickerValueStyle,
  });

  DatePickerStyle copyWith({
    MainAxisAlignment rowMainAxisAlignment,
    bool isDenseList,
    EdgeInsetsGeometry listTilePadding,
    double leftIconHeight,
    double sizedBoxSeparatorWidth,
    MainAxisAlignment pickerRowMainAxisAlignment,
    double trailingImageHeight,
    TextStyle pickerDescriptionStyle,
    TextStyle pickerValueStyle,
  }) {
    return DatePickerStyle(
      rowMainAxisAlignment: rowMainAxisAlignment ?? this.rowMainAxisAlignment,
      isDenseList: isDenseList ?? this.isDenseList,
      listTilePadding: listTilePadding ?? this.listTilePadding,
      leftIconHeight: leftIconHeight ?? this.leftIconHeight,
      sizedBoxSeparatorWidth:
          sizedBoxSeparatorWidth ?? this.sizedBoxSeparatorWidth,
      pickerRowMainAxisAlignment:
          pickerRowMainAxisAlignment ?? this.pickerRowMainAxisAlignment,
      trailingImageHeight: trailingImageHeight ?? this.trailingImageHeight,
      pickerDescriptionStyle:
          pickerDescriptionStyle ?? this.pickerDescriptionStyle,
      pickerValueStyle: pickerValueStyle ?? this.pickerValueStyle,
    );
  }
}

class _DefaultStyle extends DatePickerStyle {
  final MainAxisAlignment rowMainAxisAlignment =
      _Constants.defaultMainAxisAlignment;
  final bool isDenseList = _Constants.defaultIsDenseList;
  final EdgeInsetsGeometry listTilePadding = _Constants.defaultListTilePadding;
  final double leftIconHeight = _Constants.defaultLeftIconHeight;
  final double sizedBoxSeparatorWidth =
      _Constants.defaultSizedBoxSeparatorWidth;
  final MainAxisAlignment pickerRowMainAxisAlignment =
      _Constants.defaultPickerRowMainAxisAlignment;
  final double trailingImageHeight = _Constants.defaultTrailingImageHeight;
  final TextStyle pickerDescriptionStyle =
      _Constants.defaultPickerDescriptionStyle;
  final TextStyle pickerValueStyle = _Constants.defaultPickerValueStyle;

  const _DefaultStyle({
    MainAxisAlignment rowMainAxisAlignment,
    bool isDenseList,
    EdgeInsetsGeometry listTilePadding,
    double leftIconHeight,
    double sizedBoxSeparatorWidth,
    MainAxisAlignment pickerRowMainAxisAlignment,
    double trailingImageHeight,
    TextStyle pickerDescriptionStyle,
    TextStyle pickerValueStyle,
  });
}

const DatePickerStyle _defaultStyle = const _DefaultStyle();

class DatePicker extends StatefulWidget {
  final Function(DateTime) _onDateSelected;
  final DatePickerStyle _style;

  DatePicker({
    Function(DateTime) onDateSelected,
    DatePickerStyle style = _defaultStyle,
  })  : this._onDateSelected = onDateSelected,
        this._style = style;

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final DatePickerViewModel viewModel = DatePickerViewModel(
    isEditable: true,
    selectedDate: DateTime.now(),
  );

  @override
  void initState() {
    _onDatePicked(viewModel.selectedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildDatePicker(context);
  }

  ListTile _buildDatePicker(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: widget._style.rowMainAxisAlignment,
        children: <Widget>[
          _buildLeftIcon(),
          _buildSizedBox(),
          _buildRightChild(),
        ],
      ),
      trailing: _buildTrailingImage(),
      dense: widget._style.isDenseList,
      contentPadding: widget._style.listTilePadding,
      onTap: () => _setSelectedDate(context),
      enabled: viewModel.isEditable,
    );
  }

  _buildLeftIcon() => Image.asset(
        _Constants.dateIcon,
        height: widget._style.leftIconHeight,
      );

  _buildSizedBox() => SizedBox(
        width: widget._style.sizedBoxSeparatorWidth,
      );

  _buildRightChild() => Expanded(
        child: Row(
          mainAxisAlignment: widget._style.pickerRowMainAxisAlignment,
          children: <Widget>[
            _buildPickerDescription(),
            _buildPickerValue(),
          ],
        ),
      );

  _buildTrailingImage() => viewModel.isEditable
      ? Image.asset(
          _Constants.arrowIcon,
          height: widget._style.trailingImageHeight,
        )
      : null;

  _buildPickerDescription() => Text(
        _LocalisedStrings.date(),
        textAlign: TextAlign.start,
        style: widget._style.pickerDescriptionStyle,
      );

  _buildPickerValue() => Text(
        _getDisplayDate(),
        textAlign: TextAlign.end,
        style: widget._style.pickerValueStyle,
      );

  String _getDisplayDate()  => viewModel.selectedDate.difference(_Constants.currentDate).inDays ==
      _Constants.noDifferenceBetweenDates ? _LocalisedStrings.today() : _formatDate(viewModel.selectedDate);

  String _formatDate(DateTime date) => _Constants.dateFormatter.format(date);

  void _setSelectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: viewModel.selectedDate,
      firstDate: _Constants.minDateLimit,
      lastDate: _Constants.maxDateLimit,
    );

    if (picked != null) {
      setState(() {
        _onDatePicked(picked);
      });
    }
  }

  void _onDatePicked(DateTime dateTime) {
    widget._onDateSelected(dateTime);
    viewModel.selectedDate = dateTime;
  }
}

class DatePickerViewModel {
  final bool isEditable;
  DateTime selectedDate;

  DatePickerViewModel({
    this.isEditable,
    this.selectedDate,
  });
}

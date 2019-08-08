import 'package:flutter/material.dart';
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

class DatePicker extends StatefulWidget {
  final Function(String) onDateSelected;

  DatePicker({
    this.onDateSelected,
  });

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final DatePickerViewModel datePickerViewModel = DatePickerViewModel(
    isEditable: true,
    selectedDate: DateTime.now(),
  );

  @override
  void initState() {
    _onDatePicked(datePickerViewModel.selectedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildDatePicker(context);
  }

  ListTile _buildDatePicker(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            _Constants.dateIcon,
            height: 20.0,
          ),
          SizedBox(
            width: 22.0,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _LocalisedStrings.date(),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF1a1b46),
                  ),
                ),
                Text(
                  _formatDate(datePickerViewModel.selectedDate) ==
                          _formatDate(_Constants.currentDate)
                      ? _LocalisedStrings.today()
                      : _formatDate(datePickerViewModel.selectedDate),
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Color(0xff767690),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      trailing: datePickerViewModel.isEditable
          ? Image.asset(
              _Constants.arrowIcon,
              height: 13.0,
            )
          : null,
      dense: true,
      contentPadding: const EdgeInsets.all(0),
      onTap: () => _setSelectedDate(context),
      enabled: datePickerViewModel.isEditable,
    );
  }

  String _formatDate(DateTime selectedDate) =>
      _Constants.dateFormatter.format(selectedDate);

  void _setSelectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: datePickerViewModel.selectedDate,
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
    widget.onDateSelected(_formatDate(dateTime));
    datePickerViewModel.selectedDate = dateTime;
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

/*

 */

import 'package:farmsmart_flutter/chat/ui/viewmodel/SelectableOptionViewModel.dart';
import 'package:farmsmart_flutter/chat/ui/viewmodel/SelectableOptionsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class _Constants {
  static final cropIcon = "assets/icons/detail_icon_description.png";
  static final arrowIcon = "assets/icons/chevron.png";

  static const defaultListTileOffset = const Offset(90, 0);
  static const defaultListTileContentPadding = const EdgeInsets.all(0.0);
  static const defaultIsListTileDense = true;
  static const defaultRowMainAxisAlignment = MainAxisAlignment.start;
  static const defaultLeftIconHeight = 20.0;
  static const defaultSizedBoxSeparationWidth = 22.0;
  static const defaultRightChildMainAxisAlignment =
      MainAxisAlignment.spaceBetween;
  static const defaultOptionDescriptionStyle = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: Color(0xFF1a1b46),
  );
  static const defaultBasePickedOptionValueStyle = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: Color(0x4c767690),
  );
  static const defaultPickedOptionValueStyle = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: Color(0xff767690),
  );
  static const defaultTrailingImageHeight = 13.0;
}

class _LocalisedStrings {
  static String option() => Intl.message('Option');

  static String select() => Intl.message('Select...');
}

class DropDownPickerStyle {
  final Offset listTileOffset;
  final EdgeInsetsGeometry listTileContentPadding;
  final bool isListTileDense;
  final MainAxisAlignment rowMainAxisAlignment;
  final double leftIconHeight;
  final double sizedBoxSeparationWidth;
  final MainAxisAlignment rightChildMainAxisAlignment;
  final TextStyle optionDescriptionStyle;
  final TextStyle basePickedOptionValueStyle;
  final TextStyle pickedOptionValueStyle;
  final double trailingImageHeight;

  const DropDownPickerStyle({
    this.listTileOffset,
    this.listTileContentPadding,
    this.isListTileDense,
    this.rowMainAxisAlignment,
    this.leftIconHeight,
    this.sizedBoxSeparationWidth,
    this.rightChildMainAxisAlignment,
    this.optionDescriptionStyle,
    this.basePickedOptionValueStyle,
    this.pickedOptionValueStyle,
    this.trailingImageHeight,
  });

  DropDownPickerStyle copyWith({
    Offset listTileOffset,
    EdgeInsetsGeometry listTileContentPadding,
    bool isListTileDense,
    MainAxisAlignment rowMainAxisAlignment,
    double leftIconHeight,
    double sizedBoxSeparationWidth,
    MainAxisAlignment rightChildMainAxisAlignment,
    TextStyle optionDescriptionStyle,
    TextStyle basePickedOptionValueStyle,
    TextStyle pickedOptionValueStyle,
    double trailingImageHeight,
  }) {
    return DropDownPickerStyle(
      listTileOffset: listTileOffset ?? this.listTileOffset,
      listTileContentPadding:
          listTileContentPadding ?? this.listTileContentPadding,
      isListTileDense: isListTileDense ?? this.isListTileDense,
      rowMainAxisAlignment: rowMainAxisAlignment ?? this.rowMainAxisAlignment,
      leftIconHeight: leftIconHeight ?? this.leftIconHeight,
      sizedBoxSeparationWidth:
          sizedBoxSeparationWidth ?? this.sizedBoxSeparationWidth,
      rightChildMainAxisAlignment:
          rightChildMainAxisAlignment ?? this.rightChildMainAxisAlignment,
      optionDescriptionStyle:
          optionDescriptionStyle ?? this.optionDescriptionStyle,
      basePickedOptionValueStyle:
          basePickedOptionValueStyle ?? this.basePickedOptionValueStyle,
      pickedOptionValueStyle:
          pickedOptionValueStyle ?? this.pickedOptionValueStyle,
      trailingImageHeight: trailingImageHeight ?? this.trailingImageHeight,
    );
  }
}

class _DefaultStyle extends DropDownPickerStyle {
  final Offset listTileOffset = _Constants.defaultListTileOffset;
  final EdgeInsetsGeometry listTileContentPadding =
      _Constants.defaultListTileContentPadding;
  final bool isListTileDense = _Constants.defaultIsListTileDense;
  final MainAxisAlignment rowMainAxisAlignment =
      _Constants.defaultRowMainAxisAlignment;
  final double leftIconHeight = _Constants.defaultLeftIconHeight;
  final double sizedBoxSeparationWidth =
      _Constants.defaultSizedBoxSeparationWidth;
  final MainAxisAlignment rightChildMainAxisAlignment =
      _Constants.defaultRightChildMainAxisAlignment;
  final TextStyle optionDescriptionStyle =
      _Constants.defaultOptionDescriptionStyle;
  final TextStyle basePickedOptionValueStyle =
      _Constants.defaultBasePickedOptionValueStyle;
  final TextStyle pickedOptionValueStyle =
      _Constants.defaultPickedOptionValueStyle;
  final double trailingImageHeight = _Constants.defaultTrailingImageHeight;

  const _DefaultStyle({
    Offset listTileOffset,
    EdgeInsetsGeometry listTileContentPadding,
    bool isListTileDense,
    MainAxisAlignment rowMainAxisAlignment,
    double leftIconHeight,
    double sizedBoxSeparationWidth,
    MainAxisAlignment rightChildMainAxisAlignment,
    TextStyle optionDescriptionStyle,
    TextStyle basePickedOptionValueStyle,
    TextStyle pickedOptionValueStyle,
    double trailingImageHeight,
  });
}

const DropDownPickerStyle _defaultStyle = const _DefaultStyle();

class DropDownPicker extends StatefulWidget {
  final Function(SelectableOptionViewModel) _onOptionSelected;
  final SelectableOptionsViewModel _viewModel;
  final DropDownPickerStyle _style;

  DropDownPicker({
    SelectableOptionsViewModel viewModel,
    Function(SelectableOptionViewModel) onOptionSelected,
    DropDownPickerStyle style = _defaultStyle,
  })  : this._viewModel = viewModel,
        this._onOptionSelected = onOptionSelected,
        this._style = style;

  @override
  _DropDownPickerState createState() => _DropDownPickerState();
}

class _DropDownPickerState extends State<DropDownPicker> {
  SelectableOptionViewModel _selectedOptionViewModel;

  @override
  Widget build(BuildContext context) {
    return _buildDatePicker(context);
  }

  Widget _buildDatePicker(BuildContext context) {
    return ListTile(
      title: PopupMenuButton(
        offset: widget._style.listTileOffset,
        onSelected: (selectedOption) =>
            _setSelectedDropDownItem(selectedOption),
        itemBuilder: (BuildContext context) => _getDropDownMenuItems(),
        child: _buildMainRow(),
      ),
      contentPadding: widget._style.listTileContentPadding,
      trailing: _buildTrailingImage(),
      dense: widget._style.isListTileDense,
    );
  }

  _buildMainRow() => Row(
        mainAxisAlignment: widget._style.rowMainAxisAlignment,
        children: <Widget>[
          _buildLeftIcon(),
          _buildSizedBox(),
          _buildRightChild(),
        ],
      );

  _buildLeftIcon() => Image.asset(
        _Constants.cropIcon,
        height: widget._style.leftIconHeight,
      );

  _buildSizedBox() => SizedBox(width: widget._style.sizedBoxSeparationWidth);

  _buildRightChild() => Expanded(
        child: Row(
          mainAxisAlignment: widget._style.rightChildMainAxisAlignment,
          children: <Widget>[
            _buildOptionDescription(),
            _buildPickedOptionValue(),
          ],
        ),
      );

  _buildOptionDescription() => Text(
        _LocalisedStrings.option(),
        textAlign: TextAlign.start,
        style: widget._style.optionDescriptionStyle,
      );

  _buildPickedOptionValue() => _selectedOptionViewModel == null
      ? Text(
          _LocalisedStrings.select(),
          textAlign: TextAlign.end,
          style: widget._style.basePickedOptionValueStyle,
        )
      : Text(
          _selectedOptionViewModel.title,
          textAlign: TextAlign.end,
          style: widget._style.pickedOptionValueStyle,
        );

  _buildTrailingImage() => Image.asset(
        _Constants.arrowIcon,
        height: widget._style.trailingImageHeight,
      );

  List<PopupMenuItem> _getDropDownMenuItems() {
    return widget._viewModel.options
        .map(
            (option) => PopupMenuItem(value: option, child: Text(option.title)))
        .toList();
  }

  void _setSelectedDropDownItem(SelectableOptionViewModel selectedOption) {
    setState(() {
      _onOptionSelected(selectedOption);
    });
  }

  void _onOptionSelected(SelectableOptionViewModel option) {
    widget._onOptionSelected(option);
    _selectedOptionViewModel = option;
  }
}

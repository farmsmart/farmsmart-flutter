import 'package:farmsmart_flutter/ui/common/recommendation_detail_listitem/recommendation_detail_listitem.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class _Strings {
  static final String yourName = Intl.message("Your Name");
  static final String country = Intl.message("Country");
  static final String landSize = Intl.message("Land Size");
  static final String season = Intl.message("Season");
  static final String motivation = Intl.message("Motivation");
  static final String soilType = Intl.message("Soil Type");
  static final String farmDetailsTitle = Intl.message("Your Farm Details");
}

class _Constants {
  static final double wrapSpacing = 5;
  static final double wrapRunSpacing = 5;
  static final int maxCircles = 6;
  static final int minCircles = 0;

  static final BorderRadius circleBorderRadius =
      BorderRadius.all(Radius.circular(30));
}

class FarmDetailsListItemViewModel {
  String title;
  String detail;
  List<Color> colors;

  FarmDetailsListItemViewModel({
    this.title,
    this.detail,
    this.colors = const <Color>[],
  });
}

class FarmDetailsListItemStyle {}

class FarmDetailsListItem extends StatelessWidget {
  final FarmDetailsListItemViewModel _viewModel;
  final FarmDetailsListItemStyle _style;

  const FarmDetailsListItem(
      {Key key,
      FarmDetailsListItemViewModel viewModel,
      FarmDetailsListItemStyle style})
      : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 10),
      title: _buildTitle(),
      trailing: Container(
        width: 160,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _viewModel.colors != null ? _buildCirclesWrap() : Wrap(),
            SizedBox(width: 7.5),
            _buildDetail(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetail() {
    return Flexible(
      flex: 2,
      child: Text(
        _viewModel.detail,
        textAlign: TextAlign.right,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Color(0xff767690),
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Text _buildTitle() {
    return Text(
      _viewModel.title,
      style: TextStyle(
        color: Color(0xff1a1b46),
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  _buildCirclesWrap() {
    return Flexible(
      flex: 1,
      child: Wrap(
        direction: Axis.vertical,
        verticalDirection: VerticalDirection.down,
        spacing: _Constants.wrapSpacing,
        runSpacing: _Constants.wrapRunSpacing,
        children: _viewModel.colors.length > 9
            ? _buildCircles(_viewModel.colors).sublist(0, 9)
            : _buildCircles(_viewModel.colors),
      ),
    );
  }

  List<Widget> _buildCircles(List<Color> colors) {
    return colors
        .map(
          (color) => Container(
            height: 12,
            width: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: _Constants.circleBorderRadius,
            ),
          ),
        )
        .toList();
  }
}

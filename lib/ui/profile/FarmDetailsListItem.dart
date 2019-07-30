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
  static final EdgeInsets wrapColorsPadding = const EdgeInsets.only(
    top: 11.5,
  );

  static final double wrapSpacing = 8;
  static final double wrapRunSpacing = 8;

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

  const FarmDetailsListItem({Key key,
    FarmDetailsListItemViewModel viewModel,
    FarmDetailsListItemStyle style})
      : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 32),
      title: _buildTitle(),
      trailing: Container(
        width: 150,
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
    return Expanded(
      child: Text(
        _viewModel.detail,
        maxLines: 3,
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
    return Padding(
      padding: _Constants.wrapColorsPadding,
      child: Wrap(
        direction: _viewModel.colors.length > 2 ? Axis.vertical : Axis.horizontal,
        spacing: _Constants.wrapSpacing,
        runSpacing: _Constants.wrapRunSpacing,
        children: _buildCircles(_viewModel.colors),
      ),
    );
  }

  List<Widget> _buildCircles(List<Color> colors) =>
      colors
          .map(
            (color) =>
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: color,
                borderRadius: _Constants.circleBorderRadius,
              ),
            ),
      )
          .toList();
}

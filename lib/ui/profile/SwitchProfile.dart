import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/profile/SwitchProfileItems.dart';
import 'package:flutter/material.dart';

class _Constants {
  static final String navCancelIcon = "assets/raw/nav_icon_cancel.png";
  static final String topButtonIcon = "assets/icons/profit_add.png";
  static final double appBarElevation = 0;
  static final EdgeInsets appBarEdgePadding = EdgeInsets.only(left: 25);
  static final double appBarIconSize = 20;
  static final EdgeInsets topButtonEdgePadding =
      const EdgeInsets.only(right: 32.0);
  static final EdgeInsets generalEdgePadding =
      const EdgeInsets.only(left: 32, top: 10, bottom: 36);
  static final EdgeInsets bottomButtonEdgePadding =
      const EdgeInsets.only(right: 24, left: 24, bottom: 24);
}

class SwitchProfileViewModel {
  String title;
  String actionTitle;
  bool isVisible;
  List<SwitchProfileItemsViewModel> actions;
  int selectedIndex;
  int currentIndex;

  SwitchProfileViewModel({
    this.title,
    this.actionTitle,
    this.isVisible = false,
    this.actions,
    this.selectedIndex,
    this.currentIndex
  });
}

class SwitchProfileStyle {
  final TextStyle titleTextStyle;

  const SwitchProfileStyle({
    this.titleTextStyle,
  });

  SwitchProfileStyle copyWith({
    TextStyle titleTextStyle,
  }) {
    return SwitchProfileStyle(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    );
  }
}

class _DefaultStyle extends SwitchProfileStyle {
  final TextStyle titleTextStyle = const TextStyle(
    color: Color(0xff1a1b46),
    fontSize: 27,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
  );

  const _DefaultStyle({
    TextStyle titleTextStyle,
  });
}

const SwitchProfileStyle _defaultStyle = const _DefaultStyle();

class SwitchProfile extends StatefulWidget {
  final SwitchProfileViewModel _viewModel;
  final SwitchProfileStyle _style;

  SwitchProfile({
    Key key,
    SwitchProfileViewModel viewModel,
    SwitchProfileStyle style = _defaultStyle,
  })  : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  SwitchProfileState createState() => SwitchProfileState();
}

class SwitchProfileState extends State<SwitchProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildSimpleAppBar(context),
      body: _buildBody(),
      floatingActionButton: _buildFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: _Constants.generalEdgePadding,
            child: Text(
              widget._viewModel.title,
              textAlign: TextAlign.left,
              style: widget._style.titleTextStyle,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) => SwitchProfileItems(
              viewModel: SwitchProfileItemsViewModel(
                title: widget._viewModel.actions[index].title,
                image: widget._viewModel.actions[index].image,
                icon: widget._viewModel.actions[index].icon,
                isSelected: widget._viewModel.actions[index].isSelected,
                itemAction: () => _select(index),
              ),
            ),
            separatorBuilder: (context, index) => ListDivider.build(),
            itemCount: widget._viewModel.actions.length,
          ),
        ],
      ),
    );
  }

  _buildFloatingButton() {
    return Padding(
      padding: _Constants.bottomButtonEdgePadding,
      child: Visibility(
        visible: widget._viewModel.isVisible,
        child: RoundedButton(
            viewModel: RoundedButtonViewModel(
                title: widget._viewModel.title, onTap: () => _switchProfileTapped()),
            style: RoundedButtonStyle.largeRoundedButtonStyle()),
      ),
    );
  }

  AppBar _buildSimpleAppBar(BuildContext context) {
    return AppBar(
      elevation: _Constants.appBarElevation,
      leading: FlatButton(
        onPressed: () => Navigator.pop(context, false),
        padding: _Constants.appBarEdgePadding,
        child: Image.asset(
          _Constants.navCancelIcon,
          height: _Constants.appBarIconSize,
          width: _Constants.appBarIconSize,
        ),
      ),
      actions: <Widget>[
        Center(
          child: Padding(
            padding: _Constants.topButtonEdgePadding,
            child: RoundedButton(
                viewModel: RoundedButtonViewModel(
                    icon: _Constants.topButtonIcon, onTap: () => _bla()),
                style: RoundedButtonStyle.defaultStyle()),
          ),
        ),
      ],
    );
  }

  void _select(int index) {
    print(index.toString() + " This is the index");
    print(widget._viewModel.currentIndex.toString() + " This is the currentIndex");
    print(widget._viewModel.selectedIndex.toString() + " This is the selectedIndex");
    if(widget._viewModel.currentIndex != index) {
      _bla();
    }
    setState(() {
      widget._viewModel.currentIndex = index;
      _clearSelection();
      widget._viewModel.actions[index].isSelected = true;
    });
  }

  void _clearSelection() {
    for (var actions in widget._viewModel.actions) {
      actions.isSelected = false;
    }
  }

  //TODO: REname this function please
  _bla() {
    setState(() {
      widget._viewModel.isVisible = !widget._viewModel.isVisible;
    });
  }

  _switchProfileTapped() {
    setState(() {
      widget._viewModel.selectedIndex = widget._viewModel.currentIndex;
    });
  }
}

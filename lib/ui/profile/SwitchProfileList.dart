import 'package:farmsmart_flutter/model/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/model/bloc/chatFlow/FlowCoordinator.dart';
import 'package:farmsmart_flutter/model/entities/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/LoadableViewModel.dart';
import 'package:farmsmart_flutter/ui/common/RefreshableViewModel.dart';
import 'package:farmsmart_flutter/ui/common/ViewModelProviderBuilder.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/profile/SwitchProfileListItem.dart';
import 'package:flutter/material.dart';

class _Icons {
  static final String dismissModal = "assets/raw/nav_icon_cancel.png";
  static final String topButton = "assets/icons/profit_add.png";
}

class _Constants {
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

class SwitchProfileListViewModel implements RefreshableViewModel, LoadableViewModel {
  String title;
  String actionTitle;
  bool isVisible;
  List<SwitchProfileListItemViewModel> items;
  int confirmedIndex;
  int selectedIndex;
  LoadingStatus loadingStatus;
  FlowCoordinator newProfileFlow;
  Function refresh;

  SwitchProfileListViewModel({
    @required this.title,
    @required this.actionTitle,
    this.isVisible = false,
    this.items,
    this.confirmedIndex,
    this.selectedIndex,
    this.loadingStatus,
    @required this.newProfileFlow,
    this.refresh,
  });
}

class SwitchProfileListStyle {
  final TextStyle titleTextStyle;

  const SwitchProfileListStyle({
    this.titleTextStyle,
  });

  SwitchProfileListStyle copyWith({
    TextStyle titleTextStyle,
  }) {
    return SwitchProfileListStyle(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    );
  }
}

class _DefaultStyle extends SwitchProfileListStyle {
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

const SwitchProfileListStyle _defaultStyle = const _DefaultStyle();

class SwitchProfileList extends StatefulWidget {
  final ViewModelProvider<SwitchProfileListViewModel> _provider;
  final SwitchProfileListStyle _style;

  SwitchProfileList({
    Key key,
    ViewModelProvider<SwitchProfileListViewModel> provider,
    SwitchProfileListStyle style = _defaultStyle,
  })  : this._provider = provider,
        this._style = style,
        super(key: key);

  @override
  SwitchProfileListState createState() => SwitchProfileListState();
}

class SwitchProfileListState extends State<SwitchProfileList> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProviderBuilder(provider: widget._provider, successBuilder: _buildSuccess,);
  }
  Widget _buildSuccess({BuildContext context, AsyncSnapshot<SwitchProfileListViewModel> snapshot}) {
    final viewModel = snapshot.data;
    return Scaffold(
      appBar: _buildSimpleAppBar(context, viewModel),
      body: _buildBody(viewModel),
      floatingActionButton: _buildFloatingButton(context, viewModel),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _buildBody(SwitchProfileListViewModel viewModel) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: _Constants.generalEdgePadding,
            child: Text(
              viewModel.title,
              textAlign: TextAlign.left,
              style: widget._style.titleTextStyle,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) => SwitchProfileListItem(
              viewModel: SwitchProfileListItemViewModel(
                title: viewModel.items[index].title,
                image: viewModel.items[index].image,
                icon: viewModel.items[index].icon,
                isSelected: viewModel.items[index].isSelected,
                tapAction: () => _select(index, viewModel),
                avatarViewModelProvider: viewModel.items[index].avatarViewModelProvider,
              ),
            ),
            separatorBuilder: (context, index) => ListDivider.build(),
            itemCount: viewModel.items.length,
          ),
        ],
      ),
    );
  }

  _buildFloatingButton(BuildContext context, SwitchProfileListViewModel viewModel) {
    return Padding(
      padding: _Constants.bottomButtonEdgePadding,
      child: Visibility(
        visible: viewModel.isVisible,
        child: RoundedButton(
            viewModel: RoundedButtonViewModel(
                title: viewModel.title,
                onTap: () => _switchProfileTapped(context, viewModel)),
            style: RoundedButtonStyle.largeRoundedButtonStyle()),
      ),
    );
  }

  AppBar _buildSimpleAppBar(BuildContext context, SwitchProfileListViewModel viewModel) {
    return AppBar(
      elevation: _Constants.appBarElevation,
      leading: FlatButton(
        onPressed: () => Navigator.of(context).pop(),
        padding: _Constants.appBarEdgePadding,
        child: Image.asset(
          _Icons.dismissModal,
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
                    icon: _Icons.topButton,
                    onTap: () => _newProfileTapped(context,viewModel)),
                style: RoundedButtonStyle.defaultStyle()),
          ),
        ),
      ],
    );
  }

  void _newProfileTapped(BuildContext context, SwitchProfileListViewModel viewModel) {
    viewModel.newProfileFlow.run(context);
  }

  void _select(int index, SwitchProfileListViewModel viewModel) {
    setState(() {
      viewModel.selectedIndex = index;
      _clearSelection(viewModel);
      viewModel.items[index].isSelected = true;
    });
    _checkSelection(viewModel);
  }

  void _checkSelection(SwitchProfileListViewModel viewModel) {
    if (viewModel.confirmedIndex != viewModel.selectedIndex) {
      setState(() {
        viewModel.isVisible = true;
      });
    } else {
      setState(() {
        viewModel.isVisible = false;
      });
    }
  }

  void _clearSelection(SwitchProfileListViewModel viewModel) {
    for (var actions in viewModel.items) {
      actions.isSelected = false;
    }
  }

  _switchProfileTapped(BuildContext context, SwitchProfileListViewModel viewModel) {
    setState(() {
      viewModel.isVisible = false;
      viewModel.items[viewModel.selectedIndex].switchAction(); 
      Navigator.of(context).pop();
    });
  }
}

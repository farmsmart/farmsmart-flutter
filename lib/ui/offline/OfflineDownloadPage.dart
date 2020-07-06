import 'package:farmsmart_flutter/model/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/model/entities/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/CircularProgress.dart';
import 'package:farmsmart_flutter/ui/common/LoadableViewModel.dart';
import 'package:farmsmart_flutter/ui/common/ViewModelProviderBuilder.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class _Constants {
  static const textPadding =
      const EdgeInsets.only(top: 24, right: 24, left: 24);
  static const buttonPadding =
      const EdgeInsets.symmetric(vertical: 20, horizontal: 10);
  static const textStyle = TextStyle(
    fontSize: 17,
    color: Color(
      0xff4c4e6e,
    ),
  );
  static final titleTextStyle = const TextStyle(
    color: Color(0xff1a1b46),
    fontSize: 27,
    fontWeight: FontWeight.bold,
  );
  static final detailTextStyle = const TextStyle(
    color: Color(0xff1a1b46),
    fontSize: 17,
    height: 1.1,
    fontWeight: FontWeight.normal,
  );
  static final EdgeInsets alertEdgePadding =
      const EdgeInsets.symmetric(horizontal: 24);
  static final BorderRadius cornerRadius =
      const BorderRadius.all(Radius.circular(24.0));
  static final EdgeInsets alertInnerPadding =
      const EdgeInsets.only(left: 24, right: 24, bottom: 0, top: 24);
  static final double actionHeight = 48;
  static final double actionWidth = 120;
}

class _LocalisedStrings {
  static String title() => Intl.message('Enable Offline Use');
  static String description() => Intl.message(
      'To allow offline use, you must download the apps most recent content. Please check your connection to avoid data charges.');
  static String confirm() => Intl.message('Download');
  static String pleaseWait() => Intl.message('Please Wait');
  static String completed() => Intl.message('Completed');
  static String cancel() => Intl.message('Cancel');
}

class OfflineDownloadPageViewModel implements LoadableViewModel {
  final LoadingStatus loadingStatus;
  final double progress;
  final Error error;
  final Function downloadAction;


  OfflineDownloadPageViewModel(
      this.loadingStatus, this.downloadAction, this.progress, this.error);
}

class OfflineDownloadPage extends StatelessWidget {
  final ViewModelProvider<OfflineDownloadPageViewModel> _viewModelProvider;

  const OfflineDownloadPage({
    Key key,
    ViewModelProvider<OfflineDownloadPageViewModel> provider,
  })  : this._viewModelProvider = provider,
        super(key: key);

  static present(OfflineDownloadPage page, BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => page,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: _Constants.alertEdgePadding,
          decoration: BoxDecoration(
            borderRadius: _Constants.cornerRadius,
            color: Colors.white,
          ),
          child: Padding(
              padding: _Constants.alertInnerPadding,
              child: ViewModelProviderBuilder<OfflineDownloadPageViewModel>(
                provider: _viewModelProvider,
                successBuilder: _successBuilder,
                loadingBuilder: _loadingBuilder,
              )),
        ),
      ),
    );
  }

  Widget _successBuilder(
      {BuildContext context,
      AsyncSnapshot<OfflineDownloadPageViewModel> snapshot}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(_LocalisedStrings.title(), style: _Constants.titleTextStyle),
        _buildDescription(),
        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          _buildCancelButton(context),
          _buildActionButton(snapshot.data),
        ]),
      ],
    );
  }

  Widget _loadingBuilder(
      {BuildContext context,
      AsyncSnapshot<OfflineDownloadPageViewModel> snapshot}) {
    OfflineDownloadPageViewModel viewModel = snapshot.data;
    if (viewModel.progress == 1.0) {
      Future.delayed(Duration(seconds: 2)).then((_) {
        _dismiss(context);
      });
    }
  
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      height: 235.0,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[ Stack(children: <Widget>[
        CircularProgress(
            progress: viewModel.progress, size: 127.0, lineWidth: 2.0),
        SizedBox(height: 127.0, child:
        Center(
          child: Text(
            viewModel.progress < 1.0
                ? _LocalisedStrings.pleaseWait()
                : _LocalisedStrings.completed(),
            style: _Constants.detailTextStyle,
          ),
        ))
      ]), _buildCancelButton(context)]),
    );
  }

  void _dismiss(BuildContext context) {
    Navigator.of(context).pop();
  }

  Widget _buildActionButton(OfflineDownloadPageViewModel viewModel) {
    return Padding(
      padding: _Constants.buttonPadding,
      child: RoundedButton(
          viewModel: RoundedButtonViewModel(
            title: _LocalisedStrings.confirm(),
            onTap: () => viewModel.downloadAction(),
          ),
          style: RoundedButtonStyle.largeRoundedButtonStyle().copyWith(
            height: _Constants.actionHeight,
            width: _Constants.actionWidth,
          )),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return Padding(
      padding: _Constants.buttonPadding,
      child: RoundedButton(
          viewModel: RoundedButtonViewModel(
            title: _LocalisedStrings.cancel(),
            onTap: () => _dismiss(context),
          ),
          style: RoundedButtonStyle.actionSheetLargeRoundedButton().copyWith(
            height: _Constants.actionHeight,
            width: _Constants.actionWidth,
          )),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: _Constants.textPadding,
      child: Text(
        _LocalisedStrings.description(),
        textAlign: TextAlign.left,
        style: _Constants.textStyle,
      ),
    );
  }
}

import 'package:farmsmart_flutter/model/bloc/ResetStateWidget.dart';
import 'package:farmsmart_flutter/model/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/ui/LandingPage.dart';
import 'package:farmsmart_flutter/ui/common/ViewModelProviderBuilder.dart';
import 'package:flutter/widgets.dart';

import 'viewmodel/startupViewModel.dart';

class Startup extends StatelessWidget {
  final ViewModelProvider<StartupViewModel> _provider;
  final Widget _home;

  const Startup({
    Key key,
    ViewModelProvider<StartupViewModel> provider,
    Widget home,
    Widget loginSignup,
  })  : this._provider = provider,
        this._home = home,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProviderBuilder(
      provider: _provider,
      successBuilder: _successBuilder,
    );
  }

  Widget _successBuilder({BuildContext context, AsyncSnapshot snapshot}) {
    final viewModel = snapshot.data;
    return viewModel.isLoggedIn
        ? _homeBuilder(context: context, viewModel: viewModel)
        : _loginSignupBuilder(context: context, viewModel: viewModel);
  }

  Widget _loginSignupBuilder({BuildContext context, StartupViewModel viewModel}) {
    return LandingPage(viewModel: viewModel.landingPageViewModel,);
  }

  Widget _homeBuilder({BuildContext context, StartupViewModel viewModel}) {
    return ResetStateWidget(child:_home);
  }
}

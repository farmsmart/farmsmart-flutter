import 'package:farmsmart_flutter/flavors/app_config.dart';
import 'package:farmsmart_flutter/model/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/model/bloc/article/ArticleListProvider.dart';
import 'package:farmsmart_flutter/model/repositories/article/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/ui/LandingPage.dart';
import 'package:farmsmart_flutter/ui/article/viewModel/ArticleListViewModel.dart';
import 'package:farmsmart_flutter/ui/common/ViewModelProviderBuilder.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'viewmodel/startupViewModel.dart';

class Startup extends StatelessWidget {
  final ViewModelProviderInterface<StartupViewModel> _provider;
  final Widget _home;

  const Startup({
    Key key,
    ViewModelProviderInterface<StartupViewModel> provider,
    Widget home,
    Widget loginSignup,
  })  : this._provider = provider,
        this._home = home,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProviderBuilder(
      defaultProvider: _provider,
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
   final repositoryProvider = AppConfig.of(context).repositoryProvider;

   final articleProvider = ArticleListProvider(
        title: "title",
        repository: repositoryProvider.getArticleRepository(),
        group: ArticleCollectionGroup.discovery,
        relatedTitle: "related",
      );

    return Provider<ViewModelProviderInterface<ArticleListViewModel>>.value(
  value: articleProvider, child:_home);
  }
}

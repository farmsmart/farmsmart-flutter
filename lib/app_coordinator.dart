import 'package:farmsmart_flutter/model/repositories/repository_provider.dart';
import 'package:farmsmart_flutter/flavors/app_config.dart';
import 'package:farmsmart_flutter/ui/home.dart';
import 'package:farmsmart_flutter/ui/startup/startup.dart';
import 'package:flutter/material.dart';

import 'deep_link_helper.dart';
import 'utils/shared_preferences_helper.dart';

class AppCoordinator extends StatefulWidget {
  @override
  _AppCoordinatorState createState() => _AppCoordinatorState();
}

class _AppCoordinatorState extends State<AppCoordinator> {
  RepositoryProvider repositoryProvider;

  @override
  void initState() {
    super.initState();
    DeepLinkHelper(deepLinks: _deepLinks()).init();
  }

  @override
  Widget build(BuildContext context) {
    repositoryProvider = AppConfig.of(context).repositoryProvider;
    repositoryProvider.init(context);
    return Home(repositoryProvider: repositoryProvider,);
  }

  //TODO Should be implemented when the landing page is merged
  FutureBuilder<bool> appEntryManagement(){
    return FutureBuilder<bool>(
      future: SharedPreferencesHelper.isFirstLaunch(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
        if(snapshot.hasData){
          SharedPreferencesHelper.setIsFirstLaunch(false);

          //TODO Replace Text widget by LandingPage if snapshot.data is true
          return snapshot.data ? Text('FIRST LAUNCH') : Home(repositoryProvider: repositoryProvider,);
        }else{
          return Container();
        }
      },
    );
  }

  /*
    TODO Implement the right action and the right deep link parameter,
    This is just an example
   */
  List<DeepLink> _deepLinks() {
    return [
      DeepLink(
        deepLinkParameter: 'articleId',
        action: (deepLinkResult) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Center(
                child: Container(
                    child: Text(
                        'Opened article dynamic link with $deepLinkResult')),
              ),
            ),
          );
        },
      ),
      DeepLink(
        deepLinkParameter: 'cropId',
        action: (deepLinkResult) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Center(
                child: Container(
                    child:
                        Text('Opened crop dynamic link with $deepLinkResult')),
              ),
            ),
          );
        },
      ),
    ];
  }
}

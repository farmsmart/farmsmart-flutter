import 'package:farmsmart_flutter/ui/home_new.dart';
import 'package:flutter/material.dart';

import 'deep_link_helper.dart';

class AppCoordinator extends StatefulWidget {
  @override
  _AppCoordinatorState createState() => _AppCoordinatorState();
}

class _AppCoordinatorState extends State<AppCoordinator> {
  @override
  void initState() {
    super.initState();
    DeepLinkHelper(deepLinks: _deepLinks()).init();
  }

  @override
  Widget build(BuildContext context) {
    return Home();
  }


  List<DeepLink> _deepLinks() {
    return [
      DeepLink(
        deepLinkParameter: 'articleId',
        action: (deepLinkResult) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Center(
                child: Container(
                    child: Text('Opened article dynamic link with $deepLinkResult')),
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
                    child: Text('Opened crop dynamic link with $deepLinkResult')),
              ),
            ),
          );
        },
      ),
    ];
  }
}

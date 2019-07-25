import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DeepLink {
  final String deepLinkParameter;
  final Function(String) action;

  DeepLink({
    this.deepLinkParameter,
    this.action,
  });
}

class DeepLinkHelper {
  final List<DeepLink> deepLinks;

  DeepLinkHelper({
    this.deepLinks,
  });

  void init() {
    initDynamicLinks();
  }

  void initDynamicLinks() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    Uri deepLink = data?.link;

    if (data?.link != null) {
      _parseDeepLink(deepLink);
    }

    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData dynamicLink) async {
        final Uri deepLink = dynamicLink?.link;

        if (deepLink != null) {
          _parseDeepLink(deepLink);
        }
      },
      onError: (OnLinkErrorException e) async {
        print('onLinkError');
        print(e.message);
      },
    );
  }

  void _saveDynamicLink(){
    //TODO save to disk
  }

  void runPendingDynamicLink(){
    //TODO
  }

  void _parseDeepLink(Uri deepLink) {
    var decodedDynamicLink = Uri.decodeComponent(deepLink.toString());
    var stringURLtoURI = Uri.parse(decodedDynamicLink);

    if (stringURLtoURI != null) {
      var deepLinkCatch = deepLinks.firstWhere(
        (deepLink) => stringURLtoURI.queryParameters
            .containsKey(deepLink.deepLinkParameter),
      );

      if (deepLinkCatch != null) {
        deepLinkCatch.action(
          stringURLtoURI.queryParameters[deepLinkCatch.deepLinkParameter],
        );
      }
    }
  }
}

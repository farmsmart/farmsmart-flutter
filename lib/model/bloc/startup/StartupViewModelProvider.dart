import 'dart:async';
import 'dart:ui';

import 'package:farmsmart_flutter/chat/ChatPage.dart';
import 'package:farmsmart_flutter/chat/ui/viewmodel/ChatResponseViewModel.dart';
import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/bloc/startup/ChatResponseToPlotInfoTransformer.dart';
import 'package:farmsmart_flutter/model/model/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/model/loading_status.dart';
import 'package:farmsmart_flutter/model/repositories/MockStrings.dart';
import 'package:farmsmart_flutter/model/repositories/account/AccountRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/image/implementation/MockImageEntity.dart';
import 'package:farmsmart_flutter/ui/LandingPage.dart';
import 'package:farmsmart_flutter/ui/startup/viewmodel/startupViewModel.dart';
import 'package:intl/intl.dart';
import '../../../farmsmart_localizations.dart';
import '../ViewModelProvider.dart';

class _LocalisedStrings {
  static String detailText() =>
      Intl.message('A network and knowledge source for farmers in Kenya');

  static String actionText() => Intl.message('Get Started');

  static String footerText() =>
      Intl.message('Switch Langauge – Badilisha Lugha');
}

class _LocalisedAssets {
  static String onboardingFlow() =>
      Intl.message('assets/responses/farmsmart_chat_ui_flow.json');
}

class _Assets {
  static const headerImage = "assets/raw/illustration_welcome.png";
  static const logoImage = "assets/raw/logo_default.png";
}

class _Strings {
  static const nameField = "Name";
}

class StartupViewModelProvider implements ViewModelProvider<StartupViewModel> {
  final AccountRepositoryInterface _accountRepository;
  StartupViewModel _snapshot;
  final StreamController<StartupViewModel> _controller =
      StreamController<StartupViewModel>.broadcast();
  StartupViewModelProvider(this._accountRepository);

  @override
  StartupViewModel initial() {
    if (_snapshot == null) {
      _snapshot = StartupViewModel(
          LoadingStatus.LOADING, _refresh, false, _landingViewmModel());
      _refresh();
    }
    return _snapshot;
  }

  @override
  StartupViewModel snapshot() {
    return _snapshot;
  }

  @override
  Stream<StartupViewModel> stream() {
    return _controller.stream;
  }

  ChatPageViewModel _chatPageViewModel() {
    
    return ChatPageViewModel(_LocalisedAssets.onboardingFlow(), (data) {
      final Map<String, ChatResponseViewModel> chatInput =
          castOrNull<Map<String, ChatResponseViewModel>>(data);
      if (chatInput != null) {
        _createAccount(data);
      }
    }, (data) {
      //TODO: error case, should display a popup.
    });
  }

  void _createAccount(Map<String, ChatResponseViewModel> chatInput) {
    final name = chatInput[_Strings.nameField];
    final transformer = ChatResponseToPlotInfoTransformer();
    final plotInfo = transformer.transform(from: chatInput);
    //TODO: Remove the Mock ID´s once implemented
    if (name != null) {
      _accountRepository
          .create(
        mockPlainText.identifier(),
        mockPlainText.identifier(),
      )
          .then((account) {
        final newProfile = ProfileEntity(
          mockPlainText.identifier(),
          name.value,
          MockImageEntity().build().urlProvider,
          plotInfo,
        );
        account.profileRepository.add(newProfile).then((profile) {
          account.profileRepository.switchTo(profile);
          _refresh();
        });
      });
    }
  }

  LandingPageViewModel _landingViewmModel() {
    return LandingPageViewModel(
      detailText: _LocalisedStrings.detailText(),
      actionText: _LocalisedStrings.actionText(),
      footerText: _LocalisedStrings.footerText(),
      headerImage: _Assets.headerImage,
      subtitleImage: _Assets.logoImage,
      chatViewModel: _chatPageViewModel(),
      switchLanguageTapped: (language) => _switchLanguage(language),
    );
  }

  _switchLanguage(String language) {
    FarmsmartLocalizations.load(Locale(language));
  }

  void _refresh() {
    _accountRepository.getAuthorized().then((account) {
      _snapshot = StartupViewModel(
        LoadingStatus.SUCCESS,
        _refresh,
        (account != null),
        _landingViewmModel(),
      );
      _controller.sink.add(_snapshot);
    });
  }

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }
}

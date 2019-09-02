import 'package:farmsmart_flutter/chat/ChatPage.dart';
import 'package:farmsmart_flutter/chat/ui/viewmodel/ChatResponseViewModel.dart';
import 'package:farmsmart_flutter/model/bloc/startup/ChatResponseToPlotInfoTransformer.dart';
import 'package:farmsmart_flutter/model/entities/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/repositories/MockStrings.dart';
import 'package:farmsmart_flutter/model/repositories/account/AccountRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/image/implementation/MockImageEntity.dart';
import 'package:farmsmart_flutter/ui/common/modal_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../Transformer.dart';
import 'FlowCoordinator.dart';

class _LocalisedAssets {
  static String onboardingFlow() =>
      Intl.message('assets/responses/farmsmart_chat_ui_flow.json');
}

class _Strings {
  static const nameField = "Name";
}

class NewProfileFlowCoordinator implements FlowCoordinator {

  final AccountRepositoryInterface _accountRepository;
  final Function _onStatusChanged;
  FlowCoordinatorStatus _status = FlowCoordinatorStatus.Idle;

  NewProfileFlowCoordinator(this._accountRepository, Function onStatusChanged): this._onStatusChanged = onStatusChanged;
  
  void run(BuildContext context, {Function onSuccess, Function onFail}){
      _setStatus(FlowCoordinatorStatus.InProgress);
       NavigationScope.presentModal(
        context, ChatPage(viewModel: _chatPageViewModel(onSuccess: () {
          _setStatus(FlowCoordinatorStatus.Complete);
          if(onSuccess != null){
            onSuccess();
          }
        }, onFail: (error){
          _setStatus(FlowCoordinatorStatus.Complete);
          if(onFail != null) {
            onFail(error);
          }
        })));
  }

  ChatPageViewModel _chatPageViewModel({Function onSuccess, Function onFail}) {
    return ChatPageViewModel(_LocalisedAssets.onboardingFlow(), (data) {
      final Map<String, ChatResponseViewModel> chatInput =
          castOrNull<Map<String, ChatResponseViewModel>>(data);
      if (chatInput != null) {
        _updateAccount(data, onSuccess, onFail,);
      }
      else
      {
        onFail();
      }
    }, onFail);
  }

  void _setStatus(FlowCoordinatorStatus newStatus) {
    if(newStatus != _status){
       _status = newStatus;
       _onStatusChanged(this);
    }
  }

  void _updateAccount(Map<String, ChatResponseViewModel> chatInput, Function onSuccess, Function onFail) {
    final name = chatInput[_Strings.nameField];
    final transformer = ChatResponseToPlotInfoTransformer();
    final plotInfo = transformer.transform(from: chatInput);
    //TODO: Remove the Mock ID´s once implemented
    if (name != null) {
      _accountRepository.authorized().then((account) {
        final newProfile = ProfileEntity(
          mockPlainText.identifier(),
          name.value,
          MockImageEntity().build().urlProvider,
          plotInfo,
        );
        account.profileRepository.add(newProfile).then((profile) {
          account.profileRepository.switchTo(profile).then((result) {
            result ? onSuccess() : onFail();
          });
        });
      });
    }
    else {
      onFail();
    }
  }

  @override
  FlowCoordinatorStatus get status => _status;
}
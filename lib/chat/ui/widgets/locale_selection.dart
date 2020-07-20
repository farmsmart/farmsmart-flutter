import 'package:farmsmart_flutter/model/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/model/bloc/locale/locale_selection_viewmodel.dart';
import 'package:farmsmart_flutter/ui/common/ViewModelProviderBuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';


class LocaleSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<ViewModelProvider<LocaleSelectionViewModel>>(context);
    return ViewModelProviderBuilder<LocaleSelectionViewModel>(
      provider: provider,
      successBuilder: _buildSuccess,
    );
  }

  Widget _buildSuccess(
      {BuildContext context,
      AsyncSnapshot<LocaleSelectionViewModel> snapshot}) {
    final viewmodel = snapshot.data;

    final countryPanel = ExpansionPanel(headerBuilder: (context, expanded){
      return Text('Country');
    }, body:_buildCountryList(context, viewmodel), isExpanded: false);

    return ExpansionPanelList(children: [countryPanel],);
  }


  Widget _buildCountryList(BuildContext context, LocaleSelectionViewModel viewModel){
    return Text('Country list');
  }

  Widget _buildLanguageList(BuildContext context, LocaleSelectionViewModel viewModel){
    return Text('Lang list');
  }
}
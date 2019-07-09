import 'package:farmsmart_flutter/ui/common/CircularProgress.dart';
import 'package:farmsmart_flutter/ui/common/Dogtag.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/mockData/MockDogTagViewModel.dart';
import 'package:farmsmart_flutter/ui/mockData/MockRoundedButtonViewModel.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_data_source.dart';

class PlayGroundAtomDataSource implements PlaygroundDataSource {
  @override
  List<Widget> getList() {
    return [
      //Add your atoms here
      RoundedButton(viewModel: MockRoundedButtonViewModel.buildLarge(), style: RoundedButtonStyle.largeRoundedButtonStyle()),
      RoundedButton(viewModel: MockRoundedButtonViewModel.buildCompact(), style: RoundedButtonStyle.defaultStyle()),
      RoundedButton(viewModel: MockRoundedButtonViewModel.buildCompact(), style: RoundedButtonStyle.bigRoundedButton()),
      DogTag(viewModel: MockDogTagViewModel.buildWithText(), style: DogTagStyle.defaultStyle()),
      DogTag(viewModel: MockDogTagViewModel.buildWithPositiveNumber(), style: DogTagStyle.defaultStyle()),
      DogTag(viewModel: MockDogTagViewModel.buildWithNegativeNumber(), style: DogTagStyle.negativeStyle()),
    ];
  }
}

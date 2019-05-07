import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:farmsmart_flutter/redux/home/home_state.dart';
import 'package:farmsmart_flutter/redux/home/home_reducer.dart';
import 'package:farmsmart_flutter/redux/home/home_actions.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/home/screens.dart';


void main() {
  test('home state test', (){
    var state = homeReducer(HomeState.initial(), SwitchTabAction(HomeScreen.MY_PLOT_TAB));
    expect(state, HomeState(loadingStatus: LoadingStatus.LOADING, currentHomeTab: MY_PLOT_TAB));
  });
}
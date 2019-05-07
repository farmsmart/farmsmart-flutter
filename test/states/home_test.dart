import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:farmsmart_flutter/redux/home/home_state.dart';
import 'package:farmsmart_flutter/redux/home/home_reducer.dart';
import 'package:farmsmart_flutter/redux/home/home_actions.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/home/screens.dart';


void main() {
  test('Navigation test - to my plot', (){
    var state = homeReducer(HomeState.initial(), SwitchTabAction(HomeScreen.MY_PLOT_TAB));
    expect(state, HomeState(loadingStatus: LoadingStatus.LOADING, currentHomeTab: MY_PLOT_TAB));
  });

  test('Navigation test - to discover', (){
    var state = homeReducer(HomeState.initial(), SwitchTabAction(HomeScreen.ARTICLES_TAB));
    expect(state, HomeState(loadingStatus: LoadingStatus.LOADING, currentHomeTab: ARTICLES_TAB));
  });

  test('Navigation test - to commnity', (){
    var state = homeReducer(HomeState.initial(), SwitchTabAction(HomeScreen.COMMUNITY_TAB));
    expect(state, HomeState(loadingStatus: LoadingStatus.LOADING, currentHomeTab: COMMUNITY_TAB));
  });

  test('Navigation test - to profit loss', (){
    var state = homeReducer(HomeState.initial(), SwitchTabAction(HomeScreen.PROFIT_LOSS_TAB));
    expect(state, HomeState(loadingStatus: LoadingStatus.LOADING, currentHomeTab: PROFIT_LOSS_TAB));
  });

}
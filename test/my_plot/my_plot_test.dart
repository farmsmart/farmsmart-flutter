import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/redux/app/app_reducer.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/myPlot/my_plot_actions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

import '../utils/crop_mother.dart';

void main() {
  group('My Plot', () {
    Store<AppState> store;
    CropMother cropMother = CropMother();
    List<CropEntity> cropListInState() => store.state.myPlotState.cropList;

    setUp(() {
      store = Store<AppState>(appReducer, initialState: AppState.initial());
      expect(cropListInState(), []);
    });

    test('should add crop to plot', () {
      var crop = cropMother.crop;
      var cropsList = [crop];

      store.dispatch(UpdateCropListAction(cropsList));
      expect(cropListInState(), cropsList);
    });

    test('should remove crop from plot', () {
      var crop = cropMother.crop;
      var cropsList = [crop];

      store.dispatch(UpdateCropListAction(cropsList));
      expect(cropListInState(), cropsList);

      cropsList = [];

      store.dispatch(UpdateCropListAction(cropsList));
      expect(cropListInState(), cropsList);
    });

    test('should update existing crop on plot', () {
      var crop = cropMother.crop;
      var cropsList = [crop];

      store.dispatch(UpdateCropListAction(cropsList));
      expect(cropListInState(), cropsList);

      cropsList[0].name = 'Updated crop';

      store.dispatch(UpdateCropListAction(cropsList));
      expect(cropListInState()[0].name, crop.name);
    });
  });
}

import 'package:farmsmart_flutter/ui/common/CircularProgress.dart';
import 'package:farmsmart_flutter/ui/common/MockString.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MockCircularProgressViewModel {

  static CircularProgressViewModel buildWIthImage() {
    return CircularProgressViewModel(
        initialValue: 75, content: _mockContentWithImage());
  }
}

List<Widget> _mockContentWithImage() {
  List<Widget> listBuilder = [];
  listBuilder.add(FadeInImage(placeholder: null, image: null));
  listBuilder.add(Positioned.fill(
      child: Container(
    color: Color(0x1425df0c),
  )));
  return listBuilder;
}

MockString _mockImage = MockString(library: [
  "https://firebasestorage.googleapis."
      "com/v0/b/farmsmart-20190415.appspot.com/o/flamelink%2Fmedia%2F28qd9TZc0rfI0d5na41J_Chillies.png?alt=media&token=b0e220ef-f725-462a-9de8-acd4fc14f7a4",
  "https://firebasestorage.googleapis.com/v0/b/farmsmart-20190415.appspot.com/o/flamelink%2Fmedia%2F4SVJ5k7mON013WwHQn3f_2962762666_93a2027078_b.jpg?alt="
      "media&token=c49ac09f-8f9b-47c1-88de-2332aa8127d7",
  "https://firebasestorage.googleapis.com/v0/b/farmsmart-20190415.appspot.com/o/flamelink%2Fmedia%2FHQUyfY1LG7GOpjhfaGoq_Screenshot%202019-06-06%2017.17.08"
      ".png?alt=media&token=aeb484ee-0978-4ddc-8fec-d0806c3a1e3b",
]);


/*
List<Widget> _mockContentWithImage() {
  List<Widget> listBuilder = [];
  listBuilder.add(Image.network(
    _mockImage.random(),
    height: 80,
    width: 80,
    fit: BoxFit.cover,
  ));
  listBuilder.add(Positioned.fill(
      child: Container(
    color: Color(0x1425df0c),
  )));
  return listBuilder;
}
 */
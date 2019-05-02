import 'package:flutter/material.dart';

class HomeCommunityChild extends StatelessWidget {
  HomeCommunityChild();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset('assets/raw/crop_image_mock.png', fit: BoxFit.cover),
    );
  }
}


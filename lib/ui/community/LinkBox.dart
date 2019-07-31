import 'package:flutter/material.dart';


class LinkBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _bla(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.redAccent,
            //color: Color(0xfff5f8fa),
            borderRadius: BorderRadius.circular(12)
        ),
        padding: EdgeInsets.only(left: 24, right: 30, top: 20, bottom: 22.5),
        margin: EdgeInsets.only(left: 32, right: 32, top: 38.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildClipRRect(),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildTitleText(),
                  SizedBox(
                    height: 3,
                  ),
                  _buildDetailText(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Text _buildTitleText() {
    return Text(
      "Farming Tech",
      style: TextStyle(
        color: Color(0xff1a1b46),
        fontSize: 15,
        height: 1.05,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Text _buildDetailText() {
    return Text(
                "Join the WhatsApp group and discuss with fellow farmers",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xff4c4e6e),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              );
  }

  ClipRRect _buildClipRRect() {
    return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 40,
            width: 40,
            padding: EdgeInsets.all(6),
            color: Color(0xff25d366),
            child: Image.asset(
              "assets/icons/WhatsApp_Logo_short.png",
              height: 10,
              width: 10,
            ),
          ),
        );
  }

  //TODO: Add to the viewModel
  _bla() {
    print("Testing Touch");
  }
}

import 'package:flutter/material.dart';

class LinkBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfff5f8fa),
        borderRadius: BorderRadius.circular(12)
      ),
      padding: EdgeInsets.only(left: 24, right: 40, top: 20, bottom: 24.5),
      margin: EdgeInsets.only(left: 32, right: 32, top: 38.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 40,
              width: 40,
              padding: EdgeInsets.all(10),
              color: Color(0xff25d366),
              child: Image.asset(
                "assets/icons/radio_button_active.png",
                height: 20,
                width: 20,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Farming Tech",
                  style: TextStyle(
                    color: Color(0xff1a1b46),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Join the WhatsApp group and discuss with fellow farmers",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xff4c4e6e),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

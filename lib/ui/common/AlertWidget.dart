import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/mockData/MockRoundedButtonViewModel.dart';
import 'package:flutter/material.dart';

class AlertWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("Press Me"),
      onPressed: () => _confirmDialog(context),
    );
  }

  Future<bool> _confirmDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => Material(
            type: MaterialType.transparency,
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 32, right: 32, bottom: 31, top: 31),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Begin Stage 2",
                        style: TextStyle(
                            color: Color(0xff1a1b46),
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 19,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "Are you sure you want to beging Stage 2 – Planting?",
                            style: TextStyle(
                                color: Color(0xff1a1b46),
                                fontSize: 17,
                                height: 1.1,
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 28,
                          ),
                          Row(
                            children: _showBla(),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }

  List<Widget> _showBla() {
    List<Widget> listBuilder = [
      Expanded(
        child: RoundedButton(
          viewModel: RoundedButtonViewModel(title: "Cancel", onTap: () {}),
          style: RoundedButtonStyle.actionSheetLargeRoundedButton()
              .copyWith(height: 48, width: 120, borderRadius: BorderRadius.all(Radius.circular(14))),
        ),
      )
    ];
    listBuilder.add(SizedBox(
      width: 8,
    ));
    listBuilder.add(Expanded(
      child: RoundedButton(
        viewModel: RoundedButtonViewModel(title: "Yes", onTap: () {}),
        style: RoundedButtonStyle.actionSheetLargeRoundedButton().copyWith(
            height: 48,
            width: 120,
            backgroundColor: Color(0xff24d900),
            buttonTextStyle: TextStyle(color: Color(0xffffffff), fontSize: 15),
            borderRadius: BorderRadius.all(Radius.circular(14))),
      ),
    ));
    return listBuilder;
  }
}

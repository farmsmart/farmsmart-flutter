import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorRetry extends StatelessWidget {
  final _retryFunction;
  final _errorMessage;
  final _retryActionLabel;

  const ErrorRetry({Key key, String retryActionLabel, String errorMessage, Function retryFunction }) : this._errorMessage = errorMessage, this._retryActionLabel =  retryActionLabel, this._retryFunction = retryFunction, super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AlertDialog(title: Text(_errorMessage), actions: <Widget>[
            FlatButton(child: Text(_retryActionLabel), onPressed: _retryFunction)
          ])
        ],
      ),
    );
  }
    
}
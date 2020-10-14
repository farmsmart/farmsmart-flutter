import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class _Constants {
  static const textPadding =
      const EdgeInsets.only(top: 30, right: 32, left: 32);
  static const buttonPadding =
      const EdgeInsets.symmetric(vertical: 30, horizontal: 32);
  static const textStyle = TextStyle(
    fontSize: 17,
    color: Color(
      0xff4c4e6e,
    ),
  );
  static const imagePadding = const EdgeInsets.symmetric(horizontal: 65);
}

class EmptyViewViewModel {
  final String imagePath;
  final String description;
  final String actionText;
  final Function action;

  const EmptyViewViewModel({
    this.imagePath,
    this.description,
    this.actionText,
    this.action,
  });
}

class EmptyView extends StatelessWidget {
  final EmptyViewViewModel viewModel;

  const EmptyView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildImage(),
        _buildDescription(),
        _buildActionButton()
      ],
    );
  }

  Widget _buildImage() {
    return viewModel.imagePath != null
        ? Padding(
            padding: _Constants.imagePadding,
            child: Image.asset(viewModel.imagePath),
          )
        : SizedBox.shrink();
  }

  Widget _buildActionButton() {
    return Padding(
      padding: _Constants.buttonPadding,
      child: RoundedButton(
        viewModel: RoundedButtonViewModel(
          title: viewModel.actionText,
          onTap: () => viewModel.action(),
        ),
        style: RoundedButtonStyle.largeRoundedButtonStyle()
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: _Constants.textPadding,
      child: Text(
        viewModel.description,
        textAlign: TextAlign.center,
        style: _Constants.textStyle,
      ),
    );
  }
}

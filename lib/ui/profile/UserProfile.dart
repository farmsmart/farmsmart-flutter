import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/profile/UserProfileListItem.dart';
import 'package:flutter/material.dart';

class _Constants {
  static final String ACTIVE_CROPS = "Active crops";
  static final String COMPLETED = "Completed";
  static final link =
      "https://firebasestorage.googleapis.com/v0/b/farmsmart-20190415.appspot.com/o/flamelink%2Fmedia%2FLxHKKHJPSN3Atvbx1nv3_Cucumber.jpg?alt=media&token=642bb3b7-ac3d-4a6d-8b73-fbebd5c03eaa";
}

class UserProfileViewModel {
  String userName;
  int activeCrops;
  int completedCrops;
  String picture;
  String buttonTitle;
  List<UserProfileListItemViewModel> actions;
  final Future<String> imageUrl;

  UserProfileViewModel({
    this.userName,
    this.activeCrops,
    this.completedCrops,
    this.picture,
    this.buttonTitle,
    this.actions,
    this.imageUrl,
  });
}

class UserProfileStyle {}

class UserProfile extends StatelessWidget {
  final UserProfileViewModel _viewModel;
  final UserProfileStyle _style;

  const UserProfile({
    Key key,
    UserProfileViewModel viewModel,
    UserProfileStyle style,
  })  : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildHeader(context),
          _buildListOfActions(_viewModel)
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 0,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
                left: 32.0, top: 27.0, right: 32.0, bottom: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildMainTextView(context),
                SizedBox(width: 20),
                _buildPlotImage(),
                SizedBox(height: 25.5),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: <Widget>[
                RoundedButton(
                  viewModel: RoundedButtonViewModel(
                      title: "Swiftch Profile",
                      onTap: () => Navigator.pop(context)),
                  style: RoundedButtonStyle.largeRoundedButtonStyle().copyWith(
                    backgroundColor: Color(0xffe9eaf2),
                    height: 40,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    buttonTextStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff4c4e6e)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25)
        ],
      ),
    );
  }

  Widget _buildListOfActions(UserProfileViewModel viewModel) {
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: viewModel.actions.length,
      itemBuilder: (context, index) => UserProfileListItem(),
      separatorBuilder: (context, index) => ListDivider.build(),
    );
  }

  _buildMainTextView(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Ireti Kuta",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Color(0xff1a1b46),
            ),
          ),
          SizedBox(height: 0.5),
          Container(
            height: 2,
            width: 121,
            color: Color(0xffe9eaf2),
          ),
          SizedBox(height: 6.5),
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "6",
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff4c4e6e)),
                  ),
                  Text(
                    "Active crops",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: Color(0xffb7b8c9)),
                  ),
                ],
              ),
              SizedBox(width: 23),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "23",
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff4c4e6e)),
                  ),
                  Text(
                    "Completed",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: Color(0xffb7b8c9)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  ClipOval _buildPlotImage() {
    return ClipOval(
        child: Container(
      height: 72,
      width: 72,
      color: Colors.pink,
    ));
  }
}

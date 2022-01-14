import 'package:admin_project/models/user_model.dart';
import 'package:admin_project/screens/profile_screen/profile_screen.dart';
import 'package:admin_project/shared/constants/constants.dart';
import 'package:admin_project/shared/methods.dart';
import 'package:admin_project/style/colors.dart';
import 'package:admin_project/style/size_config.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
          vertical: getProportionateScreenHeight(8)),
      child: Container(
        width: SizeConfig.screenWidth,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
  }
}

class CustomUserItems extends StatelessWidget {
  UserModel model;

  CustomUserItems(this.model);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(context, ProfileScreen(model));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: model.image != DEFUlt
                  ? NetworkImage('${model.image}')
                  : AssetImage("assets/images/defult_image.png")
                      as ImageProvider,
              radius: SizeConfig.bodyHeight * 0.075,
            ),
            SizedBox(
              width: getProportionateScreenWidth(15),
            ),
            Expanded(
              child: Container(
                height: SizeConfig.bodyHeight * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text('${model.firstName} ${model.lastName}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                fontSize: getProportionateScreenHeight(24.0),
                              )),
                    ),
                    Text(
                      '${model.jobDesc}',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.black38,
                          fontSize: getProportionateScreenHeight(19.0)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

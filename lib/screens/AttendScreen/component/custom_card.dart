import 'package:admin_project/models/attend_model.dart';
import 'package:admin_project/style/size_config.dart';
import 'package:flutter/material.dart';

class CardAttendItem extends StatelessWidget {
  AttendModel attendModel;

  CardAttendItem({required this.attendModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(14),
          vertical: getProportionateScreenHeight(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            attendModel.isAttend
                ? Icon(Icons.check,
                    size: getProportionateScreenHeight(50.0),
                    color: Colors.blue)
                : Icon(Icons.clear,
                    size: getProportionateScreenHeight(50.0),
                    color: Colors.red),
            SizedBox(width: getProportionateScreenWidth(25)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: getProportionateScreenHeight(5)),
                Text(
                  '${attendModel.userName}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),

                SizedBox(height: getProportionateScreenHeight(5)),
                Text(
                  '${attendModel.date}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

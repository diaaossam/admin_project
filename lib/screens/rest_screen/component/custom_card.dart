import 'package:admin_project/models/attend_model.dart';
import 'package:admin_project/models/request_model.dart';
import 'package:admin_project/style/size_config.dart';
import 'package:flutter/material.dart';

class CardRestCustom extends StatelessWidget {
  RequestModel requestModel;

  CardRestCustom({required this.requestModel});

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
            Icon(Icons.clear,
                size: getProportionateScreenHeight(50.0), color: Colors.red),
            SizedBox(width: getProportionateScreenWidth(25)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: getProportionateScreenHeight(5)),
                Text(
                  '${requestModel.date}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Text(
                  '${requestModel.userName}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Text(
                  '${requestModel.reason}',
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

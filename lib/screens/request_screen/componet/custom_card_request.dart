import 'package:admin_project/screens/request_screen/cubit/req_cubit.dart';
import 'package:admin_project/style/size_config.dart';
import 'package:flutter/material.dart';

class CustomRequestCard extends StatelessWidget {
  String userName;
  String uid;
  String date;
  bool isRest;
  RequestCubit cubit;

  CustomRequestCard(
      this.userName, this.uid, this.date, this.isRest, this.cubit);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: getProportionateScreenHeight(20.0),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(14),
          vertical: getProportionateScreenHeight(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: isRest
                  ? buildText(
                      context, '${userName} want to have rest on date ${date}')
                  : buildText(
                      context, '${userName} is Pending new employee ? '),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20.0),
            ),
            Row(
              children: [
                Expanded(
                  child: buildButton(context, 'Accept', () {
                    cubit.sendRequestReply(uid, userName,'Accept', isRest);
                  }, true),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(30),
                ),
                Expanded(
                  child: buildButton(context, 'Reject', () {
                    cubit.sendRequestReply(uid, userName,'Reject', isRest);
                  }, false),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(context, String text, onPress, bool accept) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getProportionateScreenHeight(10.0)),
        color: accept ? Colors.green : Colors.red,
      ),
      child: MaterialButton(
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white,
              ),
        ),
        onPressed: onPress,
      ),
    );
  }

  Widget buildText(BuildContext context, String text) {
    return Text(
      '${text}',
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: getProportionateScreenWidth(16.0),
          ),
    );
  }
}

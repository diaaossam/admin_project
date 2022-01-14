import 'dart:io';

import 'package:admin_project/shared/components/custom_userslist.dart';
import 'package:admin_project/style/colors.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:admin_project/shared/components/default_button.dart';
import 'package:admin_project/shared/constants/constants.dart';
import 'package:admin_project/style/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeGenrator extends StatefulWidget {
  @override
  State<QrCodeGenrator> createState() => _QrCodeGenratorState();
}

class _QrCodeGenratorState extends State<QrCodeGenrator> {
  var checkIn = TextEditingController();
  var checkOut = TextEditingController();
  GlobalKey globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  'Check In ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 22.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Card(
                  color: Colors.orangeAccent.shade100,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(14),
                      vertical: getProportionateScreenHeight(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        checkIn.text.isEmpty
                            ? Container(
                                height: SizeConfig.bodyHeight * .25,
                                width: SizeConfig.bodyHeight * .25,
                                child: Image(
                                  image: AssetImage("assets/images/fram.png"),
                                  fit: BoxFit.fill,
                                ),
                              )
                            : QrImage(
                                data: checkIn.text,
                                size: SizeConfig.bodyHeight * .25,
                                backgroundColor: Colors.white,
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomDivider(),
          Expanded(
            child: Column(
              children: [
                Text(
                  'Check Out ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 22.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Card(
                  color: Colors.blue.withAlpha(30),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(14),
                      vertical: getProportionateScreenHeight(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        checkOut.text.isEmpty
                            ? Container(
                                height: SizeConfig.bodyHeight * .25,
                                width: SizeConfig.bodyHeight * .25,
                                child: Image(
                                  image: AssetImage("assets/images/fram.png"),
                                  fit: BoxFit.fill,
                                ),
                              )
                            : QrImage(
                                data: checkOut.text,
                                size: SizeConfig.bodyHeight * .25,
                                backgroundColor: Colors.white,
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: DefaultButton(
              press: () {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.SCALE,
                  dialogType: DialogType.WARNING,
                  body: Center(
                    child: Text(
                      'Are you sure want to send check in ?',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  title: 'Confirmation',
                  desc: 'Confirmation',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    setState(() {
                      checkIn.text =
                          '${DateFormat.MMMd().format(DateTime.now())} ${CHECK_IN}';
                    });
                    SnackBar(
                      content: Text('Qr Code Check In Genrated Success'),
                    );
                  },
                )..show();
              },
              text: 'Genrate Check In',
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(10.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: DefaultButton(
              press: () {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.SCALE,
                  dialogType: DialogType.WARNING,
                  body: Center(
                    child: Text(
                      'Are you sure want to send check out ?',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  title: 'Confirmation',
                  desc: 'Confirmation',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    setState(() {
                      checkOut.text =
                          '${DateFormat.MMMd().format(DateTime.now())} ${CHECK_OUT}';
                    });
                  },
                )..show();
              },
              text: 'Genrate Check Out',
            ),
          ),
        ],
      ),
    );
  }
}




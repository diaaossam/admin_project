import 'dart:ffi';

import 'package:admin_project/main_layout/main_layout.dart';
import 'package:admin_project/models/user_model.dart';
import 'package:admin_project/screens/profile_edit/components/drop2.dart';
import 'package:admin_project/screens/profile_screen/cubit/profile_screen_cubit.dart';
import 'package:admin_project/shared/components/default_button.dart';
import 'package:admin_project/shared/components/text_form_feild.dart';
import 'package:admin_project/shared/constants/constants.dart';
import 'package:admin_project/shared/methods.dart';
import 'package:admin_project/style/colors.dart';
import 'package:admin_project/style/size_config.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'drop_down.dart';
import 'miltry.dart';

class Body extends StatelessWidget {
  UserModel userModel;
  ProfileScreenCubit cubit;

  Body(this.userModel, this.cubit);

  var fisrtName = TextEditingController();
  var lastName = TextEditingController();
  var phone = TextEditingController();
  var address = TextEditingController();
  var totalSallary = TextEditingController();
  var bonus = TextEditingController();
  var discount = TextEditingController();
  var dateOfBirth = TextEditingController();
  var jobDesc = TextEditingController();
  var militryService = TextEditingController();
  var department = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var profileImage = cubit.profileImage;
    var coverImage = cubit.coverImage;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(8)),
        child: Column(
          children: [
            Container(
              height: SizeConfig.bodyHeight * 0.30,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Align(
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: SizeConfig.bodyHeight * .22,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              ),
                              image: DecorationImage(
                                  image: coverImage == null
                                      ? AssetImage("assets/images/cover.jpg")
                                      : FileImage(coverImage) as ImageProvider,
                                  fit: BoxFit.cover)),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: getProportionateScreenHeight(20.0),
                          child: IconButton(
                              onPressed: () {
                                cubit.getCoverImage(userModel.uid ?? '');
                              },
                              icon: Icon(Icons.camera_alt)),
                        )
                      ],
                    ),
                    alignment: AlignmentDirectional.topCenter,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: SizeConfig.bodyHeight * .084,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                          ),
                          CircleAvatar(
                            radius: SizeConfig.bodyHeight * .08,
                            backgroundImage: profileImage == null
                                ? AssetImage("assets/images/defult_image.png")
                                : FileImage(profileImage) as ImageProvider,
                          ),
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: getProportionateScreenHeight(20.0),
                        child: IconButton(
                            onPressed: () {
                              cubit.getProfileImage(userModel.uid ?? "");
                            },
                            icon: Icon(Icons.camera_alt)),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(25),
            ),
            Container(
              width: double.infinity,
              height: getProportionateScreenHeight(200),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(
                                      getProportionateScreenWidth(14.0))),
                              child: MaterialButton(
                                onPressed: () {
                                  showPro(context, cubit);
                                },
                                child: Text('Promotion',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            getProportionateScreenWidth(16.0))),
                              ))),
                      SizedBox(
                        width: getProportionateScreenWidth(30.0),
                      ),
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: kPrimaryColor),
                                  borderRadius: BorderRadius.circular(
                                      getProportionateScreenWidth(14.0))),
                              child: MaterialButton(
                                onPressed: () {
                                  showDep(context, cubit);
                                },
                                child: Text('Change Deparment',
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize:
                                            getProportionateScreenWidth(14.0))),
                              ))),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10.0),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: kPrimaryColor),
                                  borderRadius: BorderRadius.circular(
                                      getProportionateScreenWidth(14.0))),
                              child: MaterialButton(
                                onPressed: () {
                                  showDecrement(context, cubit);
                                },
                                child: Text('Discount',
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize:
                                            getProportionateScreenWidth(16.0))),
                              ))),
                      SizedBox(
                        width: getProportionateScreenWidth(30.0),
                      ),
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(
                                      getProportionateScreenWidth(14.0))),
                              child: MaterialButton(
                                onPressed: () {
                                  showIncrement(context, cubit);
                                },
                                child: Text('Bonus',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            getProportionateScreenWidth(16.0))),
                              ))),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10.0),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(50.0)),
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(14.0))),
                        child: MaterialButton(
                          onPressed: () {
                            showMiltray(context, cubit);
                          },
                          child: Text('Militry Service',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: getProportionateScreenWidth(16.0))),
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(25),
            ),
            DefultTextFormField(
              fisrtName..text = userModel.firstName ?? '',
              TextInputType.text,
              Icons.supervised_user_circle_sharp,
              'first name',
              (value) {
                if (value!.isEmpty) return 'first name is required';
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            DefultTextFormField(
              lastName..text = userModel.lastName ?? '',
              TextInputType.text,
              Icons.supervised_user_circle_sharp,
              'last name',
              (value) {
                if (value!.isEmpty) return 'last name is required';
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            DefultTextFormField(
              phone..text = userModel.phoneNumber ?? '',
              TextInputType.phone,
              Icons.phone,
              'phone',
              (value) {
                if (value!.isEmpty) return 'phone number is required';
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            DefultTextFormField(
              address..text = userModel.address ?? '',
              TextInputType.streetAddress,
              Icons.location_on_outlined,
              'Address',
              (value) {
                if (value!.isEmpty) return 'Address is required';
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            DefultTextFormField(
              dateOfBirth..text = userModel.dateOfBirth ?? '',
              TextInputType.datetime,
              Icons.date_range,
              'Date',
              (value) {
                if (value!.isEmpty) return 'Birth Date is required';
              },
              onTap: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950, 1, 1),
                        lastDate: DateTime.now())
                    .then((value) {
                  dateOfBirth.text = DateFormat.yMMMd().format(value!);
                });
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            DefultTextFormField(
              totalSallary..text = userModel.sallary ?? '',
              TextInputType.number,
              Icons.money,
              'Sallary',
              (value) {
                if (value!.isEmpty) return 'sallary is required';
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            DefaultButton(
              text: 'Update',
              press: () {
                cubit.updateUserInfo(userModel.uid, {
                  'firstName': fisrtName.text,
                  'lastName': lastName.text,
                  'phoneNumber': phone.text,
                  'dateOfBirth': dateOfBirth.text,
                  'address': address.text,
                  'sallary': totalSallary.text,
                  'sallaryThen':totalSallary.text,
                }).then((value) {
                  fisrtName.clear();
                  lastName.clear();
                  phone.clear();
                  dateOfBirth.clear();
                  address.clear();
                  totalSallary.clear();
                  bonus.clear();
                  dateOfBirth.clear();
                  jobDesc.clear();
                  militryService.clear();
                  department.clear();
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  AwesomeDialog showPro(context, ProfileScreenCubit cubit) {
    return AwesomeDialog(
      context: context,
      btnCancelOnPress: () {
        Navigator.of(context).pop();
      },
      animType: AnimType.SCALE,
      dialogType: DialogType.INFO,
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Promotion User',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 22.0),
              ),
              SizedBox(
                height: getProportionateScreenHeight(25.0),
              ),
              DropDownPromotion(),
            ],
          ),
        ),
      ),
      btnOkOnPress: () {
        cubit.sendNotificationForUser('pro', userModel.uid ?? '');
      },
    )..show();
  }

  AwesomeDialog showDep(context, ProfileScreenCubit cubit) {
    return AwesomeDialog(
      context: context,
      btnCancelOnPress: () {
        Navigator.of(context).pop();
      },
      animType: AnimType.SCALE,
      dialogType: DialogType.INFO,
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Change User Deparment',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 22.0),
              ),
              SizedBox(
                height: getProportionateScreenHeight(25.0),
              ),
              DropDownDepartment(),
            ],
          ),
        ),
      ),
      btnOkOnPress: () {
        cubit.sendNotificationForUser('dep', userModel.uid ?? '');
      },
    )..show();
  }

  AwesomeDialog showMiltray(context, ProfileScreenCubit cubit) {
    return AwesomeDialog(
      context: context,
      btnCancelOnPress: () {
        Navigator.of(context).pop();
      },
      animType: AnimType.SCALE,
      dialogType: DialogType.INFO,
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Change Militry Status',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 22.0),
              ),
              SizedBox(
                height: getProportionateScreenHeight(25.0),
              ),
              DropDownMilitry(),
            ],
          ),
        ),
      ),
      btnOkOnPress: () {
        cubit.updateUserInfo(userModel.uid ?? '',
            {"militryService": "${cubit.miltrayServiceValue}"});
      },
    )..show();
  }

  AwesomeDialog showIncrement(context, ProfileScreenCubit cubit) {
    return AwesomeDialog(
      context: context,
      btnCancelOnPress: () {
        Navigator.of(context).pop();
      },
      animType: AnimType.SCALE,
      dialogType: DialogType.INFO,
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sallary Bonus',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 22.0),
              ),
              SizedBox(
                height: getProportionateScreenHeight(25.0),
              ),
              DefultTextFormField(
                bonus,
                TextInputType.number,
                Icons.format_indent_increase_outlined,
                'Enter Increase Value',
                (value) {
                  if (value!.isEmpty) return 'Increase Value is required';
                },
              ),
            ],
          ),
        ),
      ),
      btnOkOnPress: () {
        if (userModel.sallaryThen != DEFUlt && bonus != null) {
          double sa1 = double.parse(userModel.sallaryThen ?? "");
          double sa2 = double.parse(bonus.text);
          String total = '${sa1 + sa2}';
          print(total);
          cubit.updateUserInfo(userModel.uid, {
            "sallaryThen": total,
          });
        }
      },
    )..show();
  }

  AwesomeDialog showDecrement(context, ProfileScreenCubit cubit) {
    return AwesomeDialog(
      context: context,
      btnCancelOnPress: () {
        Navigator.of(context).pop();
      },
      animType: AnimType.SCALE,
      dialogType: DialogType.INFO,
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sallary Decut',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 22.0),
              ),
              SizedBox(
                height: getProportionateScreenHeight(25.0),
              ),
              DefultTextFormField(
                discount,
                TextInputType.number,
                Icons.format_indent_increase_outlined,
                'Enter discount Value',
                (value) {
                  if (value!.isEmpty) return 'Discount Value is required';
                },
              ),
            ],
          ),
        ),
      ),
      btnOkOnPress: () {
        if (userModel.sallaryThen != DEFUlt && discount != null) {
          double sa1 = double.parse(userModel.sallaryThen ?? "");
          double sa2 = double.parse(discount.text) * -1;
          String total = '${sa1 + sa2}';
          print(total);
          cubit.updateUserInfo(userModel.uid, {
            "sallaryThen": total,
          });
        }
      },
    )..show();
  }
}

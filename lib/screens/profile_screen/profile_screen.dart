import 'package:admin_project/models/user_model.dart';
import 'package:admin_project/screens/profile_edit/profile_edit.dart';
import 'package:admin_project/screens/profile_screen/components/body.dart';
import 'package:admin_project/screens/profile_screen/cubit/profile_screen_states.dart';
import 'package:admin_project/shared/methods.dart';
import 'package:admin_project/style/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/profile_screen_cubit.dart';

class ProfileScreen extends StatelessWidget {
  UserModel userModel;

  ProfileScreen(this.userModel);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileScreenCubit, ProfileScreenState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: () {
                    navigateTo(context, EditProfileScreen(userModel));
                  },
                  child: Text('Edit')),
              SizedBox(
                width: getProportionateScreenWidth(10),
              )
            ],
          ),
          body: userModel != null
              ? Body(userModel, ProfileScreenCubit.get(context))
              : Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}

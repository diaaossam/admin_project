import 'package:admin_project/screens/users_screen/cubit/user_cubit.dart';
import 'package:admin_project/shared/components/custom_userslist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/user_states.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UsersCubit()..getAllUsers(),
      child: BlocConsumer<UsersCubit, UsersStates>(
          listener: (context, state) {},
          builder: (context, state) {
            UsersCubit cubit = UsersCubit.get(context);
            return cubit.usersList != null
                ? ListView.separated(
                    itemBuilder: (context, index) =>
                        CustomUserItems(cubit.usersList[index]),
                    separatorBuilder: (context, index) => CustomDivider(),
                    itemCount: cubit.usersList.length,
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }
}

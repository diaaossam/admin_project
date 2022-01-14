import 'package:admin_project/screens/sign_in/sign_in_screen.dart';
import 'package:admin_project/shared/components/bottom_nav_bar.dart';
import 'package:admin_project/shared/database/local/cache_helper.dart';
import 'package:admin_project/shared/methods.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/MainLayoutCubit.dart';
import 'cubit/MainLayoutStates.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MainLayoutCubit()..getToken(),
      child: BlocConsumer<MainLayoutCubit, MainLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          MainLayoutCubit cubit = MainLayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.title[cubit.currentIndex],
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 18.0),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.login_outlined),
                  onPressed: (){
                    cubit.signOut();
                    CachedHelper.clearData();
                    navigateToAndFinish(context, SignInScreen());

                  },
                ),
              ],
            ),
            bottomNavigationBar: BottomNavBar(cubit),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}

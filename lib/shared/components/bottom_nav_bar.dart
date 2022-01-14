import 'package:admin_project/main_layout/cubit/MainLayoutCubit.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  MainLayoutCubit cubit;

  BottomNavBar(this.cubit);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: cubit.bottomNavList,
      onTap: (index) {
        cubit.changeBottomNavIndex(context,index);
      },
      currentIndex: cubit.currentIndex,

    );
  }
}

import 'package:admin_project/screens/profile_screen/cubit/profile_screen_cubit.dart';
import 'package:admin_project/screens/profile_screen/cubit/profile_screen_states.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DropDownPromotion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileScreenCubit, ProfileScreenState>(
      listener: (context, state) {},
      builder: (context, state) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text(
              'Select Item',
              style: TextStyle(
                fontSize: 22.0,
                color: Theme
                    .of(context)
                    .hintColor,
              ),
            ),
            items: ProfileScreenCubit
                .get(context)
                .itemsPro
                .map((item) =>
                DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                ))
                .toList(),
            value: ProfileScreenCubit
                .get(context)
                .promotionValue,
            onChanged: (value) {
              ProfileScreenCubit.get(context).changePromotionState(value as String);
            },
            buttonHeight: 40,
            buttonWidth: 140,
            itemHeight: 40,
            itemWidth: 140,
          ),
        );
      },
    );
  }
}

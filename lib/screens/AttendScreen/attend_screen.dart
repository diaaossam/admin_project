import 'dart:developer';

import 'package:admin_project/screens/AttendScreen/attend_cubit/attend_cubit.dart';
import 'package:admin_project/screens/AttendScreen/attend_cubit/attens_state.dart';
import 'package:admin_project/style/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'component/custom_card.dart';

class AttendScreen extends StatelessWidget {
  const AttendScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
        AttendCubit()..getAttends(),
        child: BlocConsumer<AttendCubit, AttendState>(
          listener: (context, state) {},
          builder: (context, state) {
            return AttendCubit
                .get(context)
                .listAttend
                .length != 0
                ? ListView.separated(
              itemBuilder: (context, index) {
                return CardAttendItem(attendModel: AttendCubit
                    .get(context)
                    .listAttend[index],);
              },
              separatorBuilder: (context, index) =>
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20.0)),
                    child: Container(
                      color: Colors.grey,
                      width: double.infinity,
                      height: 1,
                    ),
                  ),
              itemCount: AttendCubit
                  .get(context)
                  .listAttend
                  .length,
            )
                : Center(
              child: Container(),
            );
          },
        ));
  }
}

import 'package:admin_project/screens/request_screen/cubit/req_cubit.dart';
import 'package:admin_project/screens/rest_screen/rest_cubit/rest_cubit.dart';
import 'package:admin_project/screens/rest_screen/rest_cubit/rest_state.dart';
import 'package:admin_project/style/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'component/custom_card.dart';

class RestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RestCubit()..getAllRest(),
        child: BlocConsumer<RestCubit, RestStates>(
          listener: (context, state) {},
          builder: (context, state) {
            print(RestCubit.get(context).listRest.length);
            return RestCubit.get(context).listRest.length != 0
                ? ListView.separated(
                    itemBuilder: (context, index) {
                      return CardRestCustom(
                        requestModel: RestCubit.get(context).listRest[index],
                      );
                    },
                    separatorBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20.0)),
                      child: Container(
                        color: Colors.grey,
                        width: double.infinity,
                        height: 1,
                      ),
                    ),
                    itemCount: RestCubit.get(context).listRest.length,
                  )
                : Center(
                    child: Container(),
                  );
          },
        ));
  }
}

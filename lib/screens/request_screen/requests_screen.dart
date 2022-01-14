import 'package:admin_project/screens/request_screen/componet/custom_card_request.dart';
import 'package:admin_project/screens/request_screen/cubit/req_cubit.dart';
import 'package:admin_project/screens/request_screen/cubit/req_states.dart';
import 'package:admin_project/shared/components/custom_userslist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestCubit()..getAllRequests(),
      child: BlocConsumer<RequestCubit, RequestStates>(
          listener: (context, state) {},
          builder: (context, state) {
            RequestCubit cubit = RequestCubit.get(context);
            return cubit.reqList != null
                ? ListView.separated(
                    itemBuilder: (context, index) => CustomRequestCard(
                        cubit.reqList[index].userName ?? '',
                        cubit.reqList[index].uid ?? '',
                        cubit.reqList[index].date ?? '',
                        cubit.reqList[index].isRest ?? true,
                        cubit),
                    separatorBuilder: (context, index) => CustomDivider(),
                    itemCount: cubit.reqList.length,
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }
}

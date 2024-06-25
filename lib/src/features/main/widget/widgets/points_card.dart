import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter_aws/src/app/data/app_dependencies.dart';

import 'package:learn_flutter_aws/src/core/localization/generated/l10n.dart';
import 'package:learn_flutter_aws/src/features/user/bloc/user/user_bloc.dart';

class PointsCard extends StatelessWidget {
  const PointsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      bloc: AppDependencies.of(context).userBloc,
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is UserFetchSuccess) {
          return Card(
            margin: const EdgeInsets.all(16),
            shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                S.of(context).pointsCounter(state.userModel.points.toString()),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          );
        }

        return const SizedBox();
      },
      //  => switch (state) {
      //   UserLoading() => const Center(child: CircularProgressIndicator()),
      //   UserFetchSuccess() => Card(
      //       margin: const EdgeInsets.all(16),
      //       shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(32)),
      //       child: Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      //         child: Text(
      //           S.of(context).pointsCounter(state.userModel.points),
      //           style: Theme.of(context).textTheme.titleMedium?.copyWith(
      //                 fontWeight: FontWeight.w700,
      //               ),
      //         ),
      //       ),
      //     ),
      //   _ => const SizedBox(),
      // },
    );
  }
}

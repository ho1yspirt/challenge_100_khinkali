import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:learn_flutter_aws/src/app/data/app_dependencies.dart';
import 'package:learn_flutter_aws/src/core/widgets/persistent_header.dart';
import 'package:learn_flutter_aws/src/features/device/bloc/list_devices/list_devices_bloc.dart';
import 'package:learn_flutter_aws/src/features/user/bloc/list_users/list_users_bloc.dart';
import 'package:learn_flutter_aws/src/features/user/bloc/user/user_bloc.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../widgets/points_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    AppDependencies.of(context).listUsersBloc.add(const ListUsersFetched());
    AppDependencies.of(context).listDevicesBloc.add(const ListDevicesFetched());
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    //! Ugly code, don't do like this

    AppDependencies.of(context).authDataSource.getIdToken().then((idToken) {
      final userId = JwtDecoder.decode(idToken ?? '')['sub'];

      AppDependencies.of(context).userBloc.add(UserFetched(id: userId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar.medium(
              title: Text(S.of(context).homeTitle),
            ),
            const SliverToBoxAdapter(child: PointsCard()),
            SliverPersistentHeader(
              pinned: true,
              delegate: PersistentHeader(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: TabBar(tabs: [
                  Tab(text: S.of(context).actionLeaderboard),
                  Tab(text: S.of(context).actionDevices),
                ]),
              ),
            ),
          ],
          body: TabBarView(children: [
            BlocBuilder<ListUsersBloc, ListUsersState>(
              bloc: AppDependencies.of(context).listUsersBloc,
              builder: (context, state) {
                if (state is ListUsersFetchSuccess) {
                  return ListView.builder(
                    itemCount: state.userModelList.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(state.userModelList[index].username.toString()),
                      trailing: Text(state.userModelList[index].points.toString()),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            BlocBuilder<ListDevicesBloc, ListDevicesState>(
              bloc: AppDependencies.of(context).listDevicesBloc,
              builder: (context, state) {
                if (state is ListDevicesFetchSuccess) {
                  return ListView.builder(
                    itemCount: state.deviceModelList.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(state.deviceModelList[index].address.toString()),
                      trailing: Text(state.deviceModelList[index].approvalsCount.toString()),
                    ),
                  );
                }
                return const SizedBox();
              },
            )
          ]),
        ),
      ),
    );
  }
}

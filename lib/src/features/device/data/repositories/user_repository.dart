import 'package:learn_flutter_aws/src/core/utils/logger.dart';
import 'package:learn_flutter_aws/src/features/user/data/datasources/user_datasource.dart';
import 'package:learn_flutter_aws/src/features/user/data/models/user_model.dart';

abstract interface class UserRepository {
  Future<UserModel> getUser({
    required String id,
  });

  Future<List<UserModel>> listUsers();
}

class UserRepository$Impl implements UserRepository {
  const UserRepository$Impl(this._userDatasource);

  final UserDatasource _userDatasource;

  @override
  Future<UserModel> getUser({required String id}) async {
    try {
      final Map<String, dynamic> result = await _userDatasource.getUser(id: id);

      logger.d(result);

      return UserModel.fromMap(result);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> listUsers() async {
    try {
      final Map<String, dynamic> result = await _userDatasource.listUsers();

      final List<UserModel> userModelList = List.generate(
        result['users'].length,
        (index) => UserModel.fromMap(result['users'][index]),
      );

      return userModelList;
    } catch (e) {
      rethrow;
    }
  }
}

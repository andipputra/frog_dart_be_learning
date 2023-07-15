import 'package:crypt/crypt.dart';
import 'package:learning_frog_be/core/database/database.dart';
import 'package:learning_frog_be/core/models/repositorie_response.dart';
import 'package:learning_frog_be/feature/users/models/data/user_model.dart';

class UserRepositories {
  final database = DatabaseConfig();

  Future<RepositorieResponse<dynamic>> getUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return RepositorieResponse(data: null, isSuccess: false);
  }

  Future<RepositorieResponse<dynamic>> insertUser({
    required UserModel user,
  }) async {
    final connection = await database.getConnection();

    final password = Crypt.sha256(user.password.toString()).toString();

    const sqlQuery = '''
              INSERT INTO eterno.users (fullname, email, password)
              VALUES (@fullname, @email, @password);
              ''';

    final queryResponse = await connection.mappedResultsQuery(
      sqlQuery,
      substitutionValues: {
        'fullname': user.fullname,
        'email': user.email,
        'password': password,
      },
    );

    return RepositorieResponse(data: queryResponse.toString(), isSuccess: true);
  }
}

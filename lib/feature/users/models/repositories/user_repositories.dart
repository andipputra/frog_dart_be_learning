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
    final connection = await database.getConnection();

    const sqlQuery = 'SELECT * FROM eterno.users WHERE email = @email';

    final queryResponse = await connection.mappedResultsQuery(
      sqlQuery,
      substitutionValues: {
        'email': email,
      },
    );

    if (queryResponse.isEmpty) {
      return RepositorieResponse(data: 'not-found', isSuccess: false);
    }

    if (queryResponse.length > 1) {
      return RepositorieResponse(data: 'redundant-data', isSuccess: false);
    }

    final userMap = queryResponse.first['users'];

    if(userMap == null){
      return RepositorieResponse(data: 'not-found', isSuccess: false);
    }

    final user = UserModel.fromJson(userMap);

    final isPasswordMatch = Crypt(user.password.toString()).match(password);

    if (!isPasswordMatch) {
      return RepositorieResponse(data: 'password not match', isSuccess: false);
    }

    return RepositorieResponse(data: user.toJson(), isSuccess: true);
  }

  Future<RepositorieResponse<dynamic>> insertUser({
    required UserModel user,
  }) async {
    final connection = await database.getConnection();

    final password = Crypt.sha256(user.password.toString()).toString();

    const sqlQuery = '''
              INSERT INTO eterno.users (fullname, email, password)
              VALUES (@fullname, @email, @password) 
              RETURNING *;
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

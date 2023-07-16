import 'package:dart_frog/dart_frog.dart';
import 'package:learning_frog_be/core/extensions/binding.dart';
import 'package:learning_frog_be/core/extensions/request_content_type_x.dart';
import 'package:learning_frog_be/core/helpers/response_helper.dart';
import 'package:learning_frog_be/core/jwt/jwt.dart';
import 'package:learning_frog_be/feature/users/models/data/user_model.dart';
import 'package:learning_frog_be/feature/users/models/repositories/user_repositories.dart';

class AuthController {
  static final repositories = UserRepositories();
  static Future<Response> login(RequestContext context) async {
    if (!context.isContentTypeJson) {
      return ResponseHelper.badRequest(message: 'Request format not JSON');
    }

    final body = await context.shouldBindJSON();

    if (body == null) {
      return ResponseHelper.badRequest(message: 'Request format not JSON');
    }

    final response = await repositories.getUserWithEmailAndPassword(
      email: body['email'].toString(),
      password: body['password'].toString(),
    );

    if (response.isSuccess) {
      final jwtService = context.read<JwtService>();
      final token =
          await jwtService.generateToken(response.data as Map<String, dynamic>);

      return ResponseHelper.success(
        body: response.data,
        token: token,
      );
    } else {
      return ResponseHelper.badRequest(message: response.data.toString());
    }
  }

  static Future<Response> register(RequestContext context) async {
    if (!context.isContentTypeJson) {
      return ResponseHelper.badRequest(message: 'Request format not JSON');
    }

    final body = await context.shouldBindJSON();

    if (body == null) {
      return ResponseHelper.badRequest(message: 'Request format not JSON');
    }

    final user = UserModel.fromJson(body);

    final response = await repositories.insertUser(user: user);

    if (response.isSuccess) {
      final jwtService = context.read<JwtService>();
      
      final token =
          await jwtService.generateToken(response.data as Map<String, dynamic>);

      return ResponseHelper.success(body: response.data, token: token);
    } else {
      return ResponseHelper.badRequest(message: response.data.toString());
    }
  }
}

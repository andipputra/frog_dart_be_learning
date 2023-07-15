import 'package:dart_frog/dart_frog.dart';
import 'package:learning_frog_be/core/extensions/binding.dart';
import 'package:learning_frog_be/core/extensions/request_content_type_x.dart';
import 'package:learning_frog_be/core/helpers/response_helper.dart';
import 'package:learning_frog_be/feature/users/models/data/user_model.dart';
import 'package:learning_frog_be/feature/users/models/repositories/user_repositories.dart';

class AuthController {
  static Future<Response> login(RequestContext context) async {
    if (!context.isContentTypeJson) {
      return ResponseHelper.badRequest(message: 'Request format not JSON');
    }

    final body = await context.shouldBindJSON();

    if (body == null) {
      return ResponseHelper.badRequest(message: 'Request format not JSON');
    }

    return ResponseHelper.success(body: body);
  }

  static Future<Response> register(RequestContext context) async {
    if (!context.isContentTypeJson) {
      return ResponseHelper.badRequest(message: 'Request format not JSON');
    }

    final body = await context.shouldBindJSON();

    if (body == null) {
      return ResponseHelper.badRequest(message: 'Request format not JSON');
    }

    final repositories = UserRepositories();

    final user = UserModel.fromJson(body);

    final response = await repositories.insertUser(user: user);

    return ResponseHelper.success(body: response.data);
  }
}

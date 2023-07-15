import 'package:dart_frog/dart_frog.dart';
import 'package:learning_frog_be/core/extensions/request_method_x.dart';
import 'package:learning_frog_be/core/helpers/response_helper.dart';
import 'package:learning_frog_be/feature/auth/controller/auth_controller.dart';

Future<Response> onRequest(RequestContext context) async{
  if(!context.isMethodPost){
    return ResponseHelper.methodNotAllowed();
  }

  return  AuthController.login(context);
}

import 'package:dart_frog/dart_frog.dart';
import 'package:learning_frog_be/core/jwt/jwt.dart';

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(
        provider<JwtService>(
          (context) => JwtServiceImpl(),
        ),
      );
}

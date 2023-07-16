import 'package:dart_frog/dart_frog.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class JwtResponse {
  JwtResponse({
    required this.success,
    required this.message,
  });

  final bool success;
  final String message;
}

abstract class JwtService {
  Future<String> generateToken(Map<String, dynamic> code);
  Future<JwtResponse> verifyToken(RequestContext context);
}

class JwtServiceImpl extends JwtService {
  final secret = SecretKey('jwtSecret');

  @override
  Future<String> generateToken(Map<String, dynamic> code) async {
    final jwt = JWT(code);
    final token = jwt.sign(secret);

    return token;
  }

  @override
  Future<JwtResponse> verifyToken(RequestContext context) async {
    try {
      final header = context.request.headers;

      final token = await _validateHeadersAndGetToken(header);

      if (token == null) {
        return JwtResponse(
          success: false,
          message: 'no token',
        );
      }

      final jwt = JWT.verify(token, secret);

      return JwtResponse(success: true, message: jwt.payload.toString());
    } on JWTExpiredException {
      return JwtResponse(success: false, message: 'expired');
    } on JWTException catch (ex) {
      return JwtResponse(success: false, message: ex.message);
    }
  }

  Future<String?> _validateHeadersAndGetToken(
    Map<String, dynamic> headers,
  ) async {
    String? token;
    if (headers.containsKey('authorization')) {
      final header = headers['authorization'].toString().split(' ');
      if (header[0].contains('Bearer')) {
        token = header[1];
      }
    }
    return token;
  }
}

import 'package:dart_frog/dart_frog.dart';
import 'package:learning_frog_be/core/helpers/constant_helper.dart';

extension RequestContentTypeX on RequestContext {
bool get isContentTypeJson =>
      request.headers['content-type'] == ConstantHelper.contentTypeJSON;
  bool get isContentTypeFormData =>
      request.headers['content-type'] == ConstantHelper.contentTypeFormData;
  bool get isContentTypeUrlEncoded =>
      request.headers['content-type'] == ConstantHelper.contentTypeUrlEncoded;
}

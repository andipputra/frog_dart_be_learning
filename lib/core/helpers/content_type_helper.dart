import 'package:dart_frog/dart_frog.dart';
import 'package:learning_frog_be/core/helpers/constant_helper.dart';

enum ContentType { json, formData, formUrlEncoded, text }

class ContentTypeHelper {
  const ContentTypeHelper._();

  static ContentType identify(RequestContext context) {
    final contentType = context.request.headers['content-type'];

    switch (contentType) {
      case ConstantHelper.contentTypeJSON:
        return ContentType.json;
      case ConstantHelper.contentTypeFormData:
        return ContentType.formData;
      case ConstantHelper.contentTypeUrlEncoded:
        return ContentType.formUrlEncoded;
      default:
        return ContentType.text;
    }
  }
}

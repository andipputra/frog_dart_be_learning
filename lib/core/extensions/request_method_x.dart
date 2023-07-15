import 'package:dart_frog/dart_frog.dart';

extension RequestMethodX on RequestContext {
  
  bool get isMethodGet => request.method == HttpMethod.get;
  bool get isMethodPost => request.method == HttpMethod.post;
  bool get isMethodPut => request.method == HttpMethod.put;
  bool get isMethodPatch => request.method == HttpMethod.patch;
  bool get isMethodDelete => request.method == HttpMethod.delete;
  bool get isMethodOptions => request.method == HttpMethod.options;
}

class RepositorieResponse<T> {

  RepositorieResponse({required this.data, required this.isSuccess});
  final T data;
  final bool isSuccess;
}

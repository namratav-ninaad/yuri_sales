import 'package:dio/dio.dart';

String getErrorMessage(DioException e) {
  if (e.response?.data is Map<String, dynamic>) {
    return e.response?.data['message'] ?? 'Something went wrong';
  }

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return 'Connection timeout';

    case DioExceptionType.sendTimeout:
      return 'Request timeout';

    case DioExceptionType.receiveTimeout:
      return 'Response timeout';

    case DioExceptionType.connectionError:
      return 'No internet connection';

    case DioExceptionType.badResponse:
      return 'Server error';

    case DioExceptionType.cancel:
      return 'Request cancelled';

    default:
      return 'Unexpected error';
  }
}
import 'package:dio/dio.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/error/exception.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/core/model/common_response.dart';
import 'package:yuri_sale/features/log_note/data/model/log_note.dart';
import 'package:yuri_sale/features/log_note/domain/entities/create_log_note_data.dart';

abstract class LogNoteRemoteDataSource {
  Future<List<LogNoteModel>> fetchLogNotes({required int partnerId});

  Future<String> createLogNote({required CreateLogNoteData data});

  Future<String> updateLogNote({required CreateLogNoteData data});

  Future<String> deleteLogNote({required int messageId});
}

class LogNoteRemoteDataSourceImpl implements LogNoteRemoteDataSource {
  final Dio dio;

  LogNoteRemoteDataSourceImpl(this.dio);

  @override
  Future<List<LogNoteModel>> fetchLogNotes({required int partnerId}) async {
    try {
      final response = await dio.get(
        AppStringsConstants.messagesURl,
        queryParameters: {'partner_id': partnerId},
      );

      final result = CommonResponse<List<LogNoteModel>>.fromJson(
        response.data,
        (json) {
          if (json is Map<String, dynamic> && json['messages'] != null) {
            return (json['messages'] as List)
                .map((e) => LogNoteModel.fromJson(e as Map<String, dynamic>))
                .toList();
          }

          return <LogNoteModel>[];
        },
      );

      return result.data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<String> createLogNote({required CreateLogNoteData data}) async {
    try {
      final response = await dio.post(
        AppStringsConstants.messagesURl,
        data: data.toMap(),
      );

      return CommonResponse.fromJson(response.data, (json) => json).message;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<String> updateLogNote({required CreateLogNoteData data}) async {
    try {
      final response = await dio.put(
        AppStringsConstants.messagesURl,
        data: data.toMap(),
      );

      return CommonResponse.fromJson(response.data, (json) => json).message;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<String> deleteLogNote({required int messageId}) async {
    try {
      final response = await dio.delete(
        AppStringsConstants.messagesURl,
        data: {"message_id": messageId},
      );

      return CommonResponse.fromJson(response.data, (json) => json).message;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }
}

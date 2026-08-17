import 'package:dio/dio.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/error/exception.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/core/model/common_response.dart';
import 'package:yuri_sale/features/send_message/data/model/send_message.dart';
import 'package:yuri_sale/features/send_message/domain/entities/create_send_message_data.dart';

abstract class SendMessageRemoteDataSource {
  Future<List<SendMessageModel>> fetchSendMessages({required int partnerId});

  Future<String> createSendMessage({required CreateSendMessageData data});

  Future<String> updateSendMessage({required CreateSendMessageData data});

  Future<String> deleteSendMessage({required int messageId});
}

class SendMessageRemoteDataSourceImpl implements SendMessageRemoteDataSource {
  final Dio dio;

  SendMessageRemoteDataSourceImpl(this.dio);

  @override
  Future<List<SendMessageModel>> fetchSendMessages({required int partnerId}) async {
    try {
      final response = await dio.get(
        AppStringsConstants.messagesURl,
        queryParameters: {'partner_id': partnerId},
      );

      final result = CommonResponse<List<SendMessageModel>>.fromJson(
        response.data,
        (json) {
          if (json is Map<String, dynamic> && json['messages'] != null) {
            return (json['messages'] as List)
                .map((e) => SendMessageModel.fromJson(e as Map<String, dynamic>))
                .toList();
          }

          return <SendMessageModel>[];
        },
      );

      return result.data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<String> createSendMessage({required CreateSendMessageData data}) async {
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
  Future<String> updateSendMessage({required CreateSendMessageData data}) async {
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
  Future<String> deleteSendMessage({required int messageId}) async {
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

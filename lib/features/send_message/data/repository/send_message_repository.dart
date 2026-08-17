import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/send_message/data/datasource/send_message_remote_data_source.dart';
import 'package:yuri_sale/features/send_message/data/model/send_message.dart';
import 'package:yuri_sale/features/send_message/domain/entities/create_send_message_data.dart';

abstract class SendMessageRepository {
  Future<Either<Failure, List<SendMessageModel>>> fetchSendMessages({
    required int partnerId,
  });

  Future<Either<Failure, String>> createSendMessage({
    required CreateSendMessageData data,
  });

  Future<Either<Failure, String>> updateSendMessage({
    required CreateSendMessageData data,
  });

  Future<Either<Failure, String>> deleteSendMessage({required int messageId});
}

class SendMessageRepositoryImpl implements SendMessageRepository {
  final SendMessageRemoteDataSource remoteDataSource;

  SendMessageRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<SendMessageModel>>> fetchSendMessages({
    required int partnerId,
  }) async {
    try {
      final model = await remoteDataSource.fetchSendMessages(partnerId: partnerId);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> createSendMessage({
    required CreateSendMessageData data,
  }) async {
    try {
      final model = await remoteDataSource.createSendMessage(data: data);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> updateSendMessage({
    required CreateSendMessageData data,
  }) async {
    try {
      final model = await remoteDataSource.updateSendMessage(data: data);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deleteSendMessage({
    required int messageId,
  }) async {
    try {
      final model = await remoteDataSource.deleteSendMessage(messageId: messageId);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

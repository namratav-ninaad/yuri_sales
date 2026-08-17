import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/send_message/data/model/send_message.dart';
import 'package:yuri_sale/features/send_message/data/repository/send_message_repository.dart';
import 'package:yuri_sale/features/send_message/domain/entities/create_send_message_data.dart';

class FetchSendMessagesUseCase {
  final SendMessageRepository repository;

  FetchSendMessagesUseCase(this.repository);

  Future<Either<Failure, List<SendMessageModel>>> call({required int partnerId}) {
    return repository.fetchSendMessages(partnerId: partnerId);
  }
}

class CreateSendMessageUseCase {
  final SendMessageRepository repository;

  CreateSendMessageUseCase(this.repository);

  Future<Either<Failure, String>> call({required CreateSendMessageData data}) {
    return repository.createSendMessage(data: data);
  }
}

class UpdateSendMessageUseCase {
  final SendMessageRepository repository;

  UpdateSendMessageUseCase(this.repository);

  Future<Either<Failure, String>> call({required CreateSendMessageData data}) {
    return repository.updateSendMessage(data: data);
  }
}

class DeleteSendMessageUseCase {
  final SendMessageRepository repository;

  DeleteSendMessageUseCase(this.repository);

  Future<Either<Failure, String>> call({required int messageId}) {
    return repository.deleteSendMessage(messageId: messageId);
  }
}

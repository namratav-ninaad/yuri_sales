import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/log_note/data/model/log_note.dart';
import 'package:yuri_sale/features/log_note/data/repository/log_note_repository.dart';
import 'package:yuri_sale/features/log_note/domain/entities/create_log_note_data.dart';

class FetchLogNotesUseCase {
  final LogNoteRepository repository;

  FetchLogNotesUseCase(this.repository);

  Future<Either<Failure, List<LogNoteModel>>> call({required int partnerId}) {
    return repository.fetchLogNotes(partnerId: partnerId);
  }
}

class CreateLogNoteUseCase {
  final LogNoteRepository repository;

  CreateLogNoteUseCase(this.repository);

  Future<Either<Failure, String>> call({required CreateLogNoteData data}) {
    return repository.createLogNote(data: data);
  }
}

class UpdateLogNoteUseCase {
  final LogNoteRepository repository;

  UpdateLogNoteUseCase(this.repository);

  Future<Either<Failure, String>> call({required CreateLogNoteData data}) {
    return repository.updateLogNote(data: data);
  }
}

class DeleteLogNoteUseCase {
  final LogNoteRepository repository;

  DeleteLogNoteUseCase(this.repository);

  Future<Either<Failure, String>> call({required int messageId}) {
    return repository.deleteLogNote(messageId: messageId);
  }
}

import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/log_note/data/datasource/log_note_remote_data_source.dart';
import 'package:yuri_sale/features/log_note/data/model/log_note.dart';
import 'package:yuri_sale/features/log_note/domain/entities/create_log_note_data.dart';

abstract class LogNoteRepository {
  Future<Either<Failure, List<LogNoteModel>>> fetchLogNotes({
    required int partnerId,
  });

  Future<Either<Failure, String>> createLogNote({
    required CreateLogNoteData data,
  });

  Future<Either<Failure, String>> updateLogNote({
    required CreateLogNoteData data,
  });

  Future<Either<Failure, String>> deleteLogNote({required int messageId});
}

class LogNoteRepositoryImpl implements LogNoteRepository {
  final LogNoteRemoteDataSource remoteDataSource;

  LogNoteRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<LogNoteModel>>> fetchLogNotes({
    required int partnerId,
  }) async {
    try {
      final model = await remoteDataSource.fetchLogNotes(partnerId: partnerId);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> createLogNote({
    required CreateLogNoteData data,
  }) async {
    try {
      final model = await remoteDataSource.createLogNote(data: data);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> updateLogNote({
    required CreateLogNoteData data,
  }) async {
    try {
      final model = await remoteDataSource.updateLogNote(data: data);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deleteLogNote({
    required int messageId,
  }) async {
    try {
      final model = await remoteDataSource.deleteLogNote(messageId: messageId);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

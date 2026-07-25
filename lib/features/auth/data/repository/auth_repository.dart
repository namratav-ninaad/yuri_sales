import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:yuri_sale/features/auth/data/model/login_response_model.dart';
import 'package:yuri_sale/features/auth/domain/entities/login_data.dart';
import 'package:yuri_sale/features/auth/domain/entities/reset_password_submitted.dart';
import 'package:yuri_sale/features/auth/domain/entities/verify_otp_submitted.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginModel>> login({required LoginData data});

  Future<Either<Failure, String>> forgotPassword({required String email});

  Future<Either<Failure, String>> verifyOtp({required VerifyOtpData data});

  Future<Either<Failure, String>> resetPassword({
    required ResetPasswordData data,
  });
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, LoginModel>> login({required LoginData data}) async {
    try {
      final model = await remoteDataSource.login(data: data);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword({
    required String email,
  }) async {
    try {
      final message = await remoteDataSource.forgotPassword(email: email);

      return Right(message);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> verifyOtp({
    required VerifyOtpData data,
  }) async {
    try {
      final result = await remoteDataSource.verifyOtp(data: data);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword({
    required ResetPasswordData data,
  }) async {
    try {
      final message = await remoteDataSource.resetPassword(data: data);

      return Right(message);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

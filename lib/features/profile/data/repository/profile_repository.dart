import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/profile/data/datasource/profile_remote_data_source.dart';
import 'package:yuri_sale/features/profile/data/model/profile_model.dart';
import 'package:yuri_sale/features/profile/domain/entities/change_password_data.dart';
import 'package:yuri_sale/features/profile/domain/entities/update_profile_data.dart';

abstract class ProfileRepository {
  Future<Either<Failure, String>> changePassword({
    required ChangePasswordData data,
  });

  Future<Either<Failure, String>> updateProfile({
    required UpdateProfileData data,
  });

  Future<Either<Failure, String>> logout();

  Future<Either<Failure, ProfileModel>> getProfile();
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> changePassword({
    required ChangePasswordData data,
  }) async {
    try {
      final message = await remoteDataSource.changePassword(data: data);

      return Right(message);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }


  @override
  Future<Either<Failure, String>> logout() async {
    try {
      final message = await remoteDataSource.logout();

      return Right(message);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
  @override
  Future<Either<Failure, String>> updateProfile({
    required UpdateProfileData data,
  }) async {
    try {
      final message = await remoteDataSource.updateProfile(data: data);

      return Right(message);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> getProfile() async {
    try {
      final message = await remoteDataSource.getProfile();

      return Right(message);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

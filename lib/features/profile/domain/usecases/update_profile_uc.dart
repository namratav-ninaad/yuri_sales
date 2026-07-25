import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/profile/data/repository/profile_repository.dart';
import 'package:yuri_sale/features/profile/domain/entities/update_profile_data.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<Failure, String>> call({required UpdateProfileData data}) {
    return repository.updateProfile(data: data);
  }
}

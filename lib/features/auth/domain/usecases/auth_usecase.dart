import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/auth/data/model/login_response_model.dart';
import 'package:yuri_sale/features/auth/data/repository/auth_repository.dart';
import 'package:yuri_sale/features/auth/domain/entities/login_data.dart';
import 'package:yuri_sale/features/auth/domain/entities/reset_password_submitted.dart';
import 'package:yuri_sale/features/auth/domain/entities/verify_otp_submitted.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, LoginModel>> call({
    required LoginData data
  }) async {
    return await repository.login(data:data);
  }
}

class ForgotPasswordUseCase {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future<Either<Failure, String>> call({required String email}) {
    return repository.forgotPassword(email: email);
  }
}

class VerifyOtpUseCase {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required VerifyOtpData data
  }) {
    return repository.verifyOtp(data: data);
  }
}

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required ResetPasswordData data
  }) {
    return repository.resetPassword(
    data: data
    );
  }
}

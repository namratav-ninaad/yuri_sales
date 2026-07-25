import 'package:dartz/dartz.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/features/customer/data/datasource/customer_remote_datasource.dart';
import 'package:yuri_sale/features/customer/data/model/company_model.dart';
import 'package:yuri_sale/features/customer/data/model/contact_tag.dart';
import 'package:yuri_sale/features/customer/data/model/country.dart';
import 'package:yuri_sale/features/customer/data/model/customer.dart';
import 'package:yuri_sale/features/customer/data/model/payment_terms.dart';
import 'package:yuri_sale/features/customer/data/model/state.dart';
import 'package:yuri_sale/features/customer/domain/entities/create_customer_data.dart';
import 'package:yuri_sale/features/customer/domain/entities/customer_filter_data.dart';

abstract class CustomerRepository {
  Future<Either<Failure, List<CustomerModel>>> fetchCustomers({
    required CustomerFilterData data,
  });

  Future<Either<Failure, List<CompanyModel>>> fetchCompanies();

  Future<Either<Failure, List<ContactTagModel>>> fetchContactTags();

  Future<Either<Failure, List<PaymentTermsModel>>> fetchPaymentTerms();

  Future<Either<Failure, List<StateModel>>> fetchStates({
    required int countryId,
  });

  Future<Either<Failure, List<CountryModel>>> fetchCountries();

  Future<Either<Failure, String>> createCustomers({
    required CreateCustomerData data,
  });
}

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDatasource remoteDataSource;

  CustomerRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CustomerModel>>> fetchCustomers({
    required CustomerFilterData data,
  }) async {
    try {
      final model = await remoteDataSource.fetchCustomers(data: data);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<CompanyModel>>> fetchCompanies() async {
    try {
      final model = await remoteDataSource.fetchCompanies();
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<StateModel>>> fetchStates({
    required int countryId,
  }) async {
    try {
      final model = await remoteDataSource.fetchStates(countryId: countryId);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<CountryModel>>> fetchCountries() async {
    try {
      final model = await remoteDataSource.fetchCountries();
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ContactTagModel>>> fetchContactTags() async {
    try {
      final model = await remoteDataSource.fetchContactTags();
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PaymentTermsModel>>> fetchPaymentTerms() async {
    try {
      final model = await remoteDataSource.fetchPaymentTerms();
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> createCustomers({
    required CreateCustomerData data,
  }) async {
    try {
      final model = await remoteDataSource.createCustomers(data: data);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

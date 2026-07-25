import 'package:dio/dio.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/error/exeptions.dart';
import 'package:yuri_sale/core/error/failures.dart';
import 'package:yuri_sale/core/model/common_response.dart';
import 'package:yuri_sale/features/customer/data/model/company_model.dart';
import 'package:yuri_sale/features/customer/data/model/contact_tag.dart';
import 'package:yuri_sale/features/customer/data/model/country.dart';
import 'package:yuri_sale/features/customer/data/model/customer.dart';
import 'package:yuri_sale/features/customer/data/model/payment_terms.dart';
import 'package:yuri_sale/features/customer/data/model/state.dart';
import 'package:yuri_sale/features/customer/domain/entities/create_customer_data.dart';
import 'package:yuri_sale/features/customer/domain/entities/customer_filter_data.dart';

abstract class CustomerRemoteDatasource {
  Future<List<CustomerModel>> fetchCustomers({
    required CustomerFilterData data,
  });

  Future<List<CompanyModel>> fetchCompanies();

  Future<List<ContactTagModel>> fetchContactTags();

  Future<List<StateModel>> fetchStates({required int countryId});

  Future<List<CountryModel>> fetchCountries();

  Future<List<PaymentTermsModel>> fetchPaymentTerms();

  Future<String> createCustomers({required CreateCustomerData data});
}

class CustomerRemoteDatasourceImpl implements CustomerRemoteDatasource {
  final Dio dio;

  CustomerRemoteDatasourceImpl(this.dio);

  @override
  Future<List<CustomerModel>> fetchCustomers({
    required CustomerFilterData data,
  }) async {
    try {
      final res = await dio.get(
        AppStringsConstants.customersURl,
        queryParameters: data.toQuery(),
      );

      return CommonResponse<List<CustomerModel>>.fromJson(res.data, (json) {
        if (json is Map<String, dynamic> && json['contacts'] != null) {
          return (json['contacts'] as List)
              .map((e) => CustomerModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return [];
      }).data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<List<CompanyModel>> fetchCompanies() async {
    try {
      final res = await dio.get(AppStringsConstants.companyURl);

      return CommonResponse<List<CompanyModel>>.fromJson(res.data, (json) {
        if (json is Map<String, dynamic> && json['companies'] != null) {
          return (json['companies'] as List)
              .map((e) => CompanyModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return [];
      }).data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<List<CountryModel>> fetchCountries() async {
    try {
      final res = await dio.get(AppStringsConstants.countryURl);

      return CommonResponse<List<CountryModel>>.fromJson(res.data, (json) {
        if (json is Map<String, dynamic> && json['countries'] != null) {
          return (json['countries'] as List)
              .map((e) => CountryModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return [];
      }).data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<List<StateModel>> fetchStates({required int countryId}) async {
    try {
      final res = await dio.get(AppStringsConstants.stateURl);

      return CommonResponse<List<StateModel>>.fromJson(res.data, (json) {
        if (json is Map<String, dynamic> && json['states'] != null) {
          return (json['states'] as List)
              .map((e) => StateModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return [];
      }).data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<List<ContactTagModel>> fetchContactTags() async {
    try {
      final res = await dio.get(AppStringsConstants.contactTagURl);

      return CommonResponse<List<ContactTagModel>>.fromJson(res.data, (json) {
        if (json is Map<String, dynamic> && json['contact_tags'] != null) {
          return (json['contact_tags'] as List)
              .map((e) => ContactTagModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return [];
      }).data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<List<PaymentTermsModel>> fetchPaymentTerms() async {
    try {
      final res = await dio.get(AppStringsConstants.paymentTermsURl);

      return CommonResponse<List<PaymentTermsModel>>.fromJson(res.data, (json) {
        if (json is Map<String, dynamic> && json['payment_terms'] != null) {
          return (json['payment_terms'] as List)
              .map((e) => PaymentTermsModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return [];
      }).data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<String> createCustomers({required CreateCustomerData data}) async {
    try {
      final formData = data.toMap();

      final response = await dio.post(
        AppStringsConstants.createCustomerURl,
        data: formData,
      );

      return CommonResponse.fromJson(response.data, (json) => json).message;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }
}

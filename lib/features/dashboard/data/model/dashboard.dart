import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';

part 'dashboard.g.dart';

/// Dashboard Model
@JsonSerializable()
class DashboardModel {
  final bool success;

  final Salesperson? salesperson;

  final Company? company;

  final Period? period;

  final Cards? cards;

  final Charts? charts;

  DashboardModel({
    required this.success,
    this.salesperson,
    this.company,
    this.period,
    this.cards,
    this.charts,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardModelToJson(this);
}

/// ===============================================================
/// Salesperson
/// ===============================================================

@JsonSerializable()
class Salesperson {
  final int id;
  final String name;

  Salesperson({required this.id, required this.name});

  factory Salesperson.fromJson(Map<String, dynamic> json) =>
      _$SalespersonFromJson(json);

  Map<String, dynamic> toJson() => _$SalespersonToJson(this);
}

/// ===============================================================
/// Company
/// ===============================================================

@JsonSerializable()
class Company {
  final int id;
  final String name;
  final int currency;

  @JsonKey(name: 'currency_name')
  final String currencyName;

  Company({
    required this.id,
    required this.name,
    required this.currency,
    required this.currencyName,
  });

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}

/// ===============================================================
/// Period
/// ===============================================================

@JsonSerializable()
class Period {
  final String type;
  final String start;
  final String end;

  Period({required this.type, required this.start, required this.end});

  factory Period.fromJson(Map<String, dynamic> json) => _$PeriodFromJson(json);

  Map<String, dynamic> toJson() => _$PeriodToJson(this);
}

/// ===============================================================
/// Cards
/// ===============================================================

@JsonSerializable()
class Cards {
  @JsonKey(name: 'total_revenue')
  final AmountCard? totalRevenue;

  @JsonKey(name: 'total_gross_profit')
  final AmountCard? totalGrossProfit;

  @JsonKey(name: 'average_order_value')
  final AmountCard? averageOrderValue;

  @JsonKey(name: 'average_sale_per_customer')
  final AmountCard? averageSalePerCustomer;

  @JsonKey(name: 'new_customers')
  final CountCard? newCustomers;

  @JsonKey(name: 'customers_invoiced')
  final CountCard? customersInvoiced;

  @JsonKey(name: 'customers_not_invoiced')
  final CountCard? customersNotInvoiced;

  @JsonKey(name: 'total_orders')
  final CountCard? totalOrders;

  @JsonKey(name: 'total_invoices')
  final CountCard? totalInvoices;

  @JsonKey(name: 'total_customers')
  final CountCard? totalCustomers;

  @JsonKey(name: 'total_receivable')
  final AmountOnlyCard? totalReceivable;

  Cards({
    this.totalRevenue,
    this.totalGrossProfit,
    this.averageOrderValue,
    this.averageSalePerCustomer,
    this.newCustomers,
    this.customersInvoiced,
    this.customersNotInvoiced,
    this.totalOrders,
    this.totalInvoices,
    this.totalCustomers,
    this.totalReceivable,
  });

  factory Cards.fromJson(Map<String, dynamic> json) => _$CardsFromJson(json);

  Map<String, dynamic> toJson() => _$CardsToJson(this);
}

/// ===============================================================
/// Amount Card
/// ===============================================================

@JsonSerializable()
class AmountCard {
  final num amount;

  @JsonKey(name: 'order_ids')
  final List<int>? orderIds;

  @JsonKey(name: 'customer_ids')
  final List<int>? customerIds;

  AmountCard({required this.amount, this.orderIds, this.customerIds});

  factory AmountCard.fromJson(Map<String, dynamic> json) =>
      _$AmountCardFromJson(json);

  Map<String, dynamic> toJson() => _$AmountCardToJson(this);
}

/// ===============================================================
/// Count Card
/// ===============================================================

@JsonSerializable()
class CountCard {
  final int count;

  @JsonKey(name: 'order_ids')
  final List<int>? orderIds;

  @JsonKey(name: 'customer_ids')
  final List<int>? customerIds;

  @JsonKey(name: 'invoice_ids')
  final List<int>? invoiceIds;

  CountCard({
    required this.count,
    this.orderIds,
    this.customerIds,
    this.invoiceIds,
  });

  factory CountCard.fromJson(Map<String, dynamic> json) =>
      _$CountCardFromJson(json);

  Map<String, dynamic> toJson() => _$CountCardToJson(this);
}

/// ===============================================================
/// Amount Only Card
/// ===============================================================

@JsonSerializable()
class AmountOnlyCard {
  final num amount;

  AmountOnlyCard({required this.amount});

  factory AmountOnlyCard.fromJson(Map<String, dynamic> json) =>
      _$AmountOnlyCardFromJson(json);

  Map<String, dynamic> toJson() => _$AmountOnlyCardToJson(this);
}

/// ===============================================================
/// Charts
/// ===============================================================

@JsonSerializable()
class Charts {
  @JsonKey(name: 'revenue_trend')
  final List<RevenueTrend>? revenueTrend;

  @JsonKey(name: 'top_products')
  final List<Product>? topProducts;

  @JsonKey(name: 'least_products')
  final List<Product>? leastProducts;

  @JsonKey(name: 'top_customers')
  final List<TopCustomer>? topCustomers;

  @JsonKey(name: 'sales_by_category')
  final List<SalesByCategory>? salesByCategory;

  @JsonKey(name: 'sales_by_country')
  final List<SalesByLocation>? salesByCountry;

  @JsonKey(name: 'sales_by_state')
  final List<SalesByLocation>? salesByState;

  Charts({
    this.revenueTrend,
    this.topProducts,
    this.leastProducts,
    this.topCustomers,
    this.salesByCategory,
    this.salesByCountry,
    this.salesByState,
  });

  factory Charts.fromJson(Map<String, dynamic> json) => _$ChartsFromJson(json);

  Map<String, dynamic> toJson() => _$ChartsToJson(this);
}

/// ===============================================================
/// Revenue Trend
/// ===============================================================

@JsonSerializable()
class RevenueTrend {
  final String date;
  final num revenue;

  RevenueTrend({required this.date, required this.revenue});

  factory RevenueTrend.fromJson(Map<String, dynamic> json) =>
      _$RevenueTrendFromJson(json);

  Map<String, dynamic> toJson() => _$RevenueTrendToJson(this);
}

/// ===============================================================
/// Product
/// ===============================================================

@JsonSerializable()
class Product {
  @JsonKey(name: 'product_id')
  final int productId;

  final String name;

  final num quantity;

  final num revenue;

  final String? brand;

  Product({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.revenue,
    this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

/// ===============================================================
/// Top Customer
/// ===============================================================

@JsonSerializable()
class TopCustomer {
  @JsonKey(name: 'customer_id')
  final int customerId;

  final String name;

  final int orders;

  final num revenue;

  TopCustomer({
    required this.customerId,
    required this.name,
    required this.orders,
    required this.revenue,
  });

  factory TopCustomer.fromJson(Map<String, dynamic> json) =>
      _$TopCustomerFromJson(json);

  Map<String, dynamic> toJson() => _$TopCustomerToJson(this);
}

/// ===============================================================
/// Sales By Category
/// ===============================================================

@JsonSerializable()
class SalesByCategory {
  @JsonKey(name: 'category_id')
  final int categoryId;

  @JsonKey(name: 'category_name')
  final String categoryName;

  final num amount;

  final num quantity;

  final num percentage;

  SalesByCategory({
    required this.categoryId,
    required this.categoryName,
    required this.amount,
    required this.quantity,
    required this.percentage,
  });

  factory SalesByCategory.fromJson(Map<String, dynamic> json) =>
      _$SalesByCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SalesByCategoryToJson(this);
}

/// ===============================================================
/// Sales By Location
/// ===============================================================

@JsonSerializable()
class SalesByLocation {
  final int id;

  final String name;

  final String? code;

  @JsonKey(name: 'order_ids')
  final List<int>? orderIds;

  final num amount;

  final num percentage;

  SalesByLocation({
    required this.id,
    required this.name,
    this.code,
    this.orderIds,
    required this.amount,
    required this.percentage,
  });

  factory SalesByLocation.fromJson(Map<String, dynamic> json) =>
      _$SalesByLocationFromJson(json);

  Map<String, dynamic> toJson() => _$SalesByLocationToJson(this);
}

class DashboardMetric {
  final IconData icon;
  final String title;
  final String value;
  final String change;
  final String subtitle;
  final String? secondary;
  final bool negative;

  const DashboardMetric({
    required this.icon,
    required this.title,
    required this.value,
    required this.change,
    required this.subtitle,
    this.secondary,
    this.negative = false,
  });
}

extension DashboardModelExtension on DashboardModel {
  List<DashboardMetric> get metrics {
    final cards = this.cards;
    final currency = company?.currencyName ?? '';

    if (cards == null) {
      return [];
    }

    /*debugPrint('================ DASHBOARD CARDS ================');

    debugPrint('currency: $currency');
    debugPrint('totalRevenue: ${cards.totalRevenue?.amount}');
    debugPrint(
      'averageOrderValue: ${cards.averageOrderValue?.amount}',
    );
    debugPrint(
      'averageSalePerCustomer: ${cards.averageSalePerCustomer?.amount}',
    );
    debugPrint('newCustomers: ${cards.newCustomers?.count}');
    debugPrint('customersInvoiced: ${cards.customersInvoiced?.count}');
    debugPrint(
      'customersNotInvoiced: ${cards.customersNotInvoiced?.count}',
    );
    debugPrint('totalOrders: ${cards.totalOrders?.count}');
    debugPrint('totalInvoices: ${cards.totalInvoices?.count}');
    debugPrint('totalCustomers: ${cards.totalCustomers?.count}');
    debugPrint('totalReceivable: ${cards.totalReceivable?.amount}');

    debugPrint('==================================================');*/

    return [
      DashboardMetric(
        icon: Icons.currency_exchange_rounded,
        title: AppStringsConstants.totalRevenue,
        value:
        '$currency ${cards.totalRevenue?.amount ?? 0}',
        change: '',
        subtitle:
        '${cards.totalRevenue?.orderIds?.length ?? 0} '
            '${AppStringsConstants.orders}',
      ),

      DashboardMetric(
        icon: Icons.shopping_cart_outlined,
        title: AppStringsConstants.averageOrderValue,
        value:
        '$currency ${cards.averageOrderValue?.amount ?? 0}',
        change: '',
        subtitle: AppStringsConstants.perOrder,
      ),

      DashboardMetric(
        icon: Icons.person_outline_rounded,
        title: AppStringsConstants.avgSaleCustomer,
        value:
        '$currency ${cards.averageSalePerCustomer?.amount ?? 0}',
        change: '',
        subtitle: AppStringsConstants.perCustomer,
      ),

      DashboardMetric(
        icon: Icons.person_add_alt_1_rounded,
        title: AppStringsConstants.newCustomers,
        value:
        '${cards.newCustomers?.count ?? 0}',
        change: '',
        subtitle: AppStringsConstants.newCustomers,
      ),

      DashboardMetric(
        icon: Icons.receipt_long_outlined,
        title: AppStringsConstants.customersInvoiced,
        value:
        '${cards.customersInvoiced?.count ?? 0}',
        change: '',
        subtitle: AppStringsConstants.customers,
      ),

      DashboardMetric(
        icon: Icons.person_off_outlined,
        title: AppStringsConstants.customerNotInvoiced,
        value:
        '${cards.customersNotInvoiced?.count ?? 0}',
        change: '',
        subtitle: AppStringsConstants.customers,
      ),

      DashboardMetric(
        icon: Icons.shopping_bag_outlined,
        title: AppStringsConstants.totalOrders,
        value:
        '${cards.totalOrders?.count ?? 0}',
        change: '',
        subtitle: AppStringsConstants.orders,
      ),

      DashboardMetric(
        icon: Icons.receipt_outlined,
        title: AppStringsConstants.totalInvoices,
        value:
        '${cards.totalInvoices?.count ?? 0}',
        change: '',
        subtitle: AppStringsConstants.invoices,
      ),

      DashboardMetric(
        icon: Icons.groups_outlined,
        title: AppStringsConstants.totalCustomers,
        value:
        '${cards.totalCustomers?.count ?? 0}',
        change: '',
        subtitle: AppStringsConstants.customers,
      ),

      DashboardMetric(
        icon: Icons.account_balance_wallet_outlined,
        title: AppStringsConstants.totalReceivable,
        value:
        '$currency ${cards.totalReceivable?.amount ?? 0}',
        change: '',
        subtitle: AppStringsConstants.receivable,
      ),
    ];
  }
}
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardModel _$DashboardModelFromJson(Map<String, dynamic> json) =>
    DashboardModel(
      success: json['success'] as bool,
      salesperson: json['salesperson'] == null
          ? null
          : Salesperson.fromJson(json['salesperson'] as Map<String, dynamic>),
      company: json['company'] == null
          ? null
          : Company.fromJson(json['company'] as Map<String, dynamic>),
      period: json['period'] == null
          ? null
          : Period.fromJson(json['period'] as Map<String, dynamic>),
      cards: json['cards'] == null
          ? null
          : Cards.fromJson(json['cards'] as Map<String, dynamic>),
      charts: json['charts'] == null
          ? null
          : Charts.fromJson(json['charts'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DashboardModelToJson(DashboardModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'salesperson': instance.salesperson,
      'company': instance.company,
      'period': instance.period,
      'cards': instance.cards,
      'charts': instance.charts,
    };

Salesperson _$SalespersonFromJson(Map<String, dynamic> json) =>
    Salesperson(id: (json['id'] as num).toInt(), name: json['name'] as String);

Map<String, dynamic> _$SalespersonToJson(Salesperson instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  currency: (json['currency'] as num).toInt(),
  currencyName: json['currency_name'] as String,
);

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'currency': instance.currency,
  'currency_name': instance.currencyName,
};

Period _$PeriodFromJson(Map<String, dynamic> json) => Period(
  type: json['type'] as String,
  start: json['start'] as String,
  end: json['end'] as String,
);

Map<String, dynamic> _$PeriodToJson(Period instance) => <String, dynamic>{
  'type': instance.type,
  'start': instance.start,
  'end': instance.end,
};

Cards _$CardsFromJson(Map<String, dynamic> json) => Cards(
  totalRevenue: json['total_revenue'] == null
      ? null
      : AmountCard.fromJson(json['total_revenue'] as Map<String, dynamic>),
  totalGrossProfit: json['total_gross_profit'] == null
      ? null
      : AmountCard.fromJson(json['total_gross_profit'] as Map<String, dynamic>),
  averageOrderValue: json['average_order_value'] == null
      ? null
      : AmountCard.fromJson(
          json['average_order_value'] as Map<String, dynamic>,
        ),
  averageSalePerCustomer: json['average_sale_per_customer'] == null
      ? null
      : AmountCard.fromJson(
          json['average_sale_per_customer'] as Map<String, dynamic>,
        ),
  newCustomers: json['new_customers'] == null
      ? null
      : CountCard.fromJson(json['new_customers'] as Map<String, dynamic>),
  customersInvoiced: json['customers_invoiced'] == null
      ? null
      : CountCard.fromJson(json['customers_invoiced'] as Map<String, dynamic>),
  customersNotInvoiced: json['customers_not_invoiced'] == null
      ? null
      : CountCard.fromJson(
          json['customers_not_invoiced'] as Map<String, dynamic>,
        ),
  totalOrders: json['total_orders'] == null
      ? null
      : CountCard.fromJson(json['total_orders'] as Map<String, dynamic>),
  totalInvoices: json['total_invoices'] == null
      ? null
      : CountCard.fromJson(json['total_invoices'] as Map<String, dynamic>),
  totalCustomers: json['total_customers'] == null
      ? null
      : CountCard.fromJson(json['total_customers'] as Map<String, dynamic>),
  totalReceivable: json['total_receivable'] == null
      ? null
      : AmountOnlyCard.fromJson(
          json['total_receivable'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$CardsToJson(Cards instance) => <String, dynamic>{
  'total_revenue': instance.totalRevenue,
  'total_gross_profit': instance.totalGrossProfit,
  'average_order_value': instance.averageOrderValue,
  'average_sale_per_customer': instance.averageSalePerCustomer,
  'new_customers': instance.newCustomers,
  'customers_invoiced': instance.customersInvoiced,
  'customers_not_invoiced': instance.customersNotInvoiced,
  'total_orders': instance.totalOrders,
  'total_invoices': instance.totalInvoices,
  'total_customers': instance.totalCustomers,
  'total_receivable': instance.totalReceivable,
};

AmountCard _$AmountCardFromJson(Map<String, dynamic> json) => AmountCard(
  amount: json['amount'] as num,
  orderIds: (json['order_ids'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  customerIds: (json['customer_ids'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$AmountCardToJson(AmountCard instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'order_ids': instance.orderIds,
      'customer_ids': instance.customerIds,
    };

CountCard _$CountCardFromJson(Map<String, dynamic> json) => CountCard(
  count: (json['count'] as num).toInt(),
  orderIds: (json['order_ids'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  customerIds: (json['customer_ids'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  invoiceIds: (json['invoice_ids'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$CountCardToJson(CountCard instance) => <String, dynamic>{
  'count': instance.count,
  'order_ids': instance.orderIds,
  'customer_ids': instance.customerIds,
  'invoice_ids': instance.invoiceIds,
};

AmountOnlyCard _$AmountOnlyCardFromJson(Map<String, dynamic> json) =>
    AmountOnlyCard(amount: json['amount'] as num);

Map<String, dynamic> _$AmountOnlyCardToJson(AmountOnlyCard instance) =>
    <String, dynamic>{'amount': instance.amount};

Charts _$ChartsFromJson(Map<String, dynamic> json) => Charts(
  revenueTrend: (json['revenue_trend'] as List<dynamic>?)
      ?.map((e) => RevenueTrend.fromJson(e as Map<String, dynamic>))
      .toList(),
  topProducts: (json['top_products'] as List<dynamic>?)
      ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
      .toList(),
  leastProducts: (json['least_products'] as List<dynamic>?)
      ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
      .toList(),
  topCustomers: (json['top_customers'] as List<dynamic>?)
      ?.map((e) => TopCustomer.fromJson(e as Map<String, dynamic>))
      .toList(),
  salesByCategory: (json['sales_by_category'] as List<dynamic>?)
      ?.map((e) => SalesByCategory.fromJson(e as Map<String, dynamic>))
      .toList(),
  salesByCountry: (json['sales_by_country'] as List<dynamic>?)
      ?.map((e) => SalesByLocation.fromJson(e as Map<String, dynamic>))
      .toList(),
  salesByState: (json['sales_by_state'] as List<dynamic>?)
      ?.map((e) => SalesByLocation.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ChartsToJson(Charts instance) => <String, dynamic>{
  'revenue_trend': instance.revenueTrend,
  'top_products': instance.topProducts,
  'least_products': instance.leastProducts,
  'top_customers': instance.topCustomers,
  'sales_by_category': instance.salesByCategory,
  'sales_by_country': instance.salesByCountry,
  'sales_by_state': instance.salesByState,
};

RevenueTrend _$RevenueTrendFromJson(Map<String, dynamic> json) =>
    RevenueTrend(date: json['date'] as String, revenue: json['revenue'] as num);

Map<String, dynamic> _$RevenueTrendToJson(RevenueTrend instance) =>
    <String, dynamic>{'date': instance.date, 'revenue': instance.revenue};

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  productId: (json['product_id'] as num).toInt(),
  name: json['name'] as String,
  quantity: json['quantity'] as num,
  revenue: json['revenue'] as num,
  brand: json['brand'] as String?,
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'product_id': instance.productId,
  'name': instance.name,
  'quantity': instance.quantity,
  'revenue': instance.revenue,
  'brand': instance.brand,
};

TopCustomer _$TopCustomerFromJson(Map<String, dynamic> json) => TopCustomer(
  customerId: (json['customer_id'] as num).toInt(),
  name: json['name'] as String,
  orders: (json['orders'] as num).toInt(),
  revenue: json['revenue'] as num,
);

Map<String, dynamic> _$TopCustomerToJson(TopCustomer instance) =>
    <String, dynamic>{
      'customer_id': instance.customerId,
      'name': instance.name,
      'orders': instance.orders,
      'revenue': instance.revenue,
    };

SalesByCategory _$SalesByCategoryFromJson(Map<String, dynamic> json) =>
    SalesByCategory(
      categoryId: (json['category_id'] as num).toInt(),
      categoryName: json['category_name'] as String,
      amount: json['amount'] as num,
      quantity: json['quantity'] as num,
      percentage: json['percentage'] as num,
    );

Map<String, dynamic> _$SalesByCategoryToJson(SalesByCategory instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'amount': instance.amount,
      'quantity': instance.quantity,
      'percentage': instance.percentage,
    };

SalesByLocation _$SalesByLocationFromJson(Map<String, dynamic> json) =>
    SalesByLocation(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      code: json['code'] as String?,
      orderIds: (json['order_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      amount: json['amount'] as num,
      percentage: json['percentage'] as num,
    );

Map<String, dynamic> _$SalesByLocationToJson(SalesByLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'order_ids': instance.orderIds,
      'amount': instance.amount,
      'percentage': instance.percentage,
    };

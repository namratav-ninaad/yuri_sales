import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_divider.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/order/data/model/order.dart';
import 'package:yuri_sale/features/order/presentation/widget/order_product_item.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({
    super.key,
    required this.orderLines,
    required this.currency,
  });

  final List<OrderLineModel> orderLines;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextWidget(
          title: AppStringsConstants.orderItems,
          fontSize: AppSizes.f16,
          fontWeight: FontWeight.w700,
        ),
        AppSizes.h12,
        Container(
          decoration: BoxDecoration(
            color: context.greyFA,
            // color: context.white,
            // border: Border.all(color: context.greyC8),
            borderRadius: BorderRadius.circular(AppSizes.r12),
          ),
          child: /*ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.r12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child:*/ Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.p16,
                  vertical: AppSizes.p12,
                ),
                decoration: BoxDecoration(
                  color: context.greyC8,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSizes.r12),
                    topRight: Radius.circular(AppSizes.r12),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: CommonTextWidget(
                        textAlign: TextAlign.center,
                        title: AppStringsConstants.product,
                        fontSize: AppSizes.f12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: CommonTextWidget(
                        textAlign: TextAlign.center,
                        title: AppStringsConstants.price,
                        fontSize: AppSizes.f12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CommonTextWidget(
                        textAlign: TextAlign.center,
                        title: AppStringsConstants.qty,
                        fontSize: AppSizes.f12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: CommonTextWidget(
                        textAlign: TextAlign.center,
                        title: AppStringsConstants.discount,
                        fontSize: AppSizes.f12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: CommonTextWidget(
                        textAlign: TextAlign.center,
                        title: AppStringsConstants.total,
                        fontSize: AppSizes.f12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => OrderProductItem(
                  orderLine: orderLines[index],
                  currency: currency,
                ),
                separatorBuilder: (context, index) =>
                    CommonDivider(color: context.white),
                itemCount: orderLines.length,
              ),
            ],
          ),
          /*  ),
            ),
          ),*/
        ),
      ],
    );
  }
}

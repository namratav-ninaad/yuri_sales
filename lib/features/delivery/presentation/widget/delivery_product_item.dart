import 'package:flutter/material.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_divider.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/delivery/data/model/delivery.dart';
import 'package:yuri_sale/features/delivery/presentation/widget/delivery_product_row_data.dart';

class DeliveryProductItem extends StatelessWidget {
  const DeliveryProductItem({super.key, required this.deliveryProducts});

  final List<DeliveryProductModel> deliveryProducts;

  @override
  Widget build(BuildContext context) {
    return deliveryProducts.isEmpty
        ? AppSizes.h0
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextWidget(
                title: AppStringsConstants.invoiceItems,
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
                child: */ Column(
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
                              title: AppStringsConstants.demand,
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
                              title: AppStringsConstants.unit,
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
                      itemBuilder: (context, index) => DeliveryProductRowData(
                        deliveryProduct: deliveryProducts[index],
                      ),
                      separatorBuilder: (context, index) =>
                          CommonDivider(color: context.white),
                      itemCount: deliveryProducts.length,
                    ),
                  ],
                ),
                /* ),
            ),
          ),*/
              ),
            ],
          );
  }
}

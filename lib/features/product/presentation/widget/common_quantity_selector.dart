import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/theme/theme_color_extension.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_text_field.dart';

class CommonQuantitySelector extends StatefulWidget {
  final int quantity;

  final VoidCallback? onDecrease;
  final VoidCallback? onIncrease;

  final ValueChanged<int>? onQuantityChanged;

  final double? height;
  final double? padding;
  final double? radius;

  /// Minimum quantity.
  /// 0 means user can enter 0.
  final int minQuantity;

  /// Maximum quantity.
  final int? maxQuantity;

  const CommonQuantitySelector({
    super.key,
    required this.quantity,
    this.onDecrease,
    this.onIncrease,
    this.onQuantityChanged,
    this.height,
    this.padding,
    this.radius,
    this.minQuantity = 0,
    this.maxQuantity,
  });

  @override
  State<CommonQuantitySelector> createState() =>
      _CommonQuantitySelectorState();
}

class _CommonQuantitySelectorState
    extends State<CommonQuantitySelector> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    // ==========================================================
    // INITIAL VALUE
    // ==========================================================

    _controller = TextEditingController(
      text: widget.quantity.toString(),
    );

    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(
      covariant CommonQuantitySelector oldWidget,
      ) {
    super.didUpdateWidget(oldWidget);

    // ==========================================================
    // UPDATE TEXT FIELD FROM PARENT
    // ==========================================================

    if (!_focusNode.hasFocus &&
        oldWidget.quantity != widget.quantity) {
      _controller.text = widget.quantity.toString();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // ============================================================
  // UPDATE QUANTITY
  // ============================================================

  void _updateQuantity(String value) {
    if (value.isEmpty) {
      return;
    }

    final int? parsedQuantity = int.tryParse(value);

    if (parsedQuantity == null) {
      return;
    }


    int newQuantity = parsedQuantity;

    // ==========================================================
    // MINIMUM
    // ==========================================================

    if (newQuantity <= widget.minQuantity) {
      newQuantity = widget.minQuantity;
    }

    // ==========================================================
    // MAXIMUM
    // ==========================================================

    if (widget.maxQuantity != null &&
        newQuantity > widget.maxQuantity!) {
      newQuantity = widget.maxQuantity!;
    }

    // ==========================================================
    // UPDATE CONTROLLER
    // ==========================================================

    final String newText = newQuantity.toString();

    if (_controller.text != newText) {
      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: newText.length,
        ),
      );
    }

    // ==========================================================
    // SEND TO PARENT
    // ==========================================================

    widget.onQuantityChanged?.call(newQuantity);
  }

  // ============================================================
  // SUBMIT
  // ============================================================

  void _submitQuantity() {
    final String value = _controller.text.trim();

    // Empty value
    if (value.isEmpty) {
      _controller.text = widget.quantity.toString();

      _focusNode.unfocus();
      return;
    }

    _updateQuantity(value);

    _focusNode.unfocus();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final bool isMinQuantity =
        widget.quantity <= widget.minQuantity;

    final bool isMaxQuantity =
        widget.maxQuantity != null &&
            widget.quantity >= widget.maxQuantity!;

    return Container(
      height: widget.height ?? AppSizes.s32,
      padding: EdgeInsets.all(
        widget.padding ?? AppSizes.p4,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          widget.radius ?? AppSizes.r8,
        ),
        border: Border.all(
          color: context.greyC8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          // ======================================================
          // MINUS
          // ======================================================

          CommonIconWidget(
            onTap: isMinQuantity
                ? null
                : widget.onDecrease,
            icon: Icons.remove,
            size: AppSizes.icon24,
            color: isMinQuantity
                ? context.greyC8
                : context.black,
          ),

          // ======================================================
          // QUANTITY TEXT FIELD
          // ======================================================

          Expanded(
            child: CommonTextFormField(
              controller: _controller,
              focusNode: _focusNode,

              filled: false,

              textAlign: TextAlign.center,

              keyboardType: TextInputType.number,

              textInputAction:
              TextInputAction.done,

              contentPadding: EdgeInsets.zero,

              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],

              // ==================================================
              // SUBMIT
              // ==================================================

              onFieldSubmitted: (_) {
                _submitQuantity();
              },

              // ==================================================
              // TAP
              // ==================================================

              onTap: () {
                _controller.selection =
                    TextSelection(
                      baseOffset: 0,
                      extentOffset:
                      _controller.text.length,
                    );
              },

              labelText: '',
            ),
          ),

          // ======================================================
          // PLUS
          // ======================================================

          CommonIconWidget(
            onTap: isMaxQuantity
                ? null
                : widget.onIncrease,

            icon: Icons.add,

            size: AppSizes.icon24,

            color: isMaxQuantity
                ? context.greyC8
                : context.black,
          ),
        ],
      ),
    );
  }
}
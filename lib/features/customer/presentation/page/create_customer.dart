import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/core/constants/app_colors.dart';
import 'package:yuri_sale/core/constants/app_sizes.dart';
import 'package:yuri_sale/core/constants/app_strings.dart';
import 'package:yuri_sale/core/constants/app_validators.dart';
import 'package:yuri_sale/core/routes/app_routes.dart';
import 'package:yuri_sale/core/toast/toast_helper.dart';
import 'package:yuri_sale/core/widgets/common_appbar_widget.dart';
import 'package:yuri_sale/core/widgets/common_button.dart';
import 'package:yuri_sale/core/widgets/common_drop_down.dart';
import 'package:yuri_sale/core/widgets/common_icon_widget.dart';
import 'package:yuri_sale/core/widgets/common_outline_button.dart';
import 'package:yuri_sale/core/widgets/common_text_field.dart';
import 'package:yuri_sale/core/widgets/common_text_widget.dart';
import 'package:yuri_sale/features/customer/data/model/company_model.dart';
import 'package:yuri_sale/features/customer/data/model/contact_tag.dart';
import 'package:yuri_sale/features/customer/data/model/country.dart';
import 'package:yuri_sale/features/customer/data/model/note.dart';
import 'package:yuri_sale/features/customer/data/model/payment_terms.dart';
import 'package:yuri_sale/features/customer/data/model/state.dart';
import 'package:yuri_sale/features/customer/domain/entities/create_customer_data.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/create_customer_bloc/create_customer_bloc.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/create_customer_bloc/create_customer_event.dart';
import 'package:yuri_sale/features/customer/presentation/bloc/create_customer_bloc/create_customer_state.dart';
import 'package:yuri_sale/features/customer/presentation/widget/add_attachment_bs.dart';
import 'package:yuri_sale/features/customer/presentation/widget/add_note_bs.dart';
import 'package:yuri_sale/features/customer/presentation/widget/address_selection_widget.dart';
import 'package:yuri_sale/features/customer/presentation/widget/build_attachment_item.dart';
import 'package:yuri_sale/features/customer/presentation/widget/note_card.dart';

class CreateCustomerPage extends StatefulWidget {
  const CreateCustomerPage({super.key});

  @override
  State<CreateCustomerPage> createState() => _CreateCustomerPageState();
}

class _CreateCustomerPageState extends State<CreateCustomerPage>
    with TickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  late AnimationController _addButtonController;

  // Controllers
  final nameController = TextEditingController();

  final companyController = TextEditingController();

  final contactPersonController = TextEditingController();

  final mobileController = TextEditingController();

  final emailController = TextEditingController();

  final vatController = TextEditingController();

  final paymentTermsController = TextEditingController();

  final creditLimitController = TextEditingController();

  final cityController = TextEditingController();
  final zipController = TextEditingController();
  final addressController = TextEditingController();

  void _showAttachmentPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.r24)),
      ),
      builder: (context) => AddAttachmentBottomSheet(
        title: "Attachment",
        onFilesSelected: (files) async {
          for (var path in files) {
            final file = File(path);
            final bytes = await file.readAsBytes();
            final base64Content = base64Encode(bytes);
            final mimeType = _getMimeType(path);

            final attachment = AttachmentData(
              filename: path.split('/').last,
              mimetype: mimeType,
              content: base64Content,
            );

            context.read<CreateCustomerBloc>().add(
              AddAttachmentEvent(attachment),
            );
          }
        },
      ),
    );
  }

  String _getMimeType(String path) {
    final ext = path.split('.').last.toLowerCase();
    switch (ext) {
      case 'pdf':
        return 'application/pdf';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      default:
        return 'application/octet-stream';
    }
  }

  void _showAddNoteBottomSheet() {
    _addButtonController.forward().then((_) => _addButtonController.reverse());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.r24)),
      ),
      builder: (context) => AddNoteBottomSheet(onNoteAdded: _addNewNote),
    );
  }

  void _addNewNote(Note newNote) {
    context.read<CreateCustomerBloc>().add(AddNoteEvent(note: newNote));
    AppRoutes.pop();
    ToastHelper.success(AppStringsConstants.noteAddSuccessfully);
  }

  @override
  void initState() {
    super.initState();
    _addButtonController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<CreateCustomerBloc>().add(ResetCreateDataEvent());
      context.read<CreateCustomerBloc>().add(LoadCustomerDropDownDataEvent());
    });
  }

  @override
  void dispose() {
    _addButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<CreateCustomerBloc>();
    return Scaffold(
      backgroundColor: AppColorsConstants.white,
      appBar: CommonAppbarWidget(title: AppStringsConstants.createCustomer),
      body: BlocConsumer<CreateCustomerBloc, CreateCustomerState>(
        listenWhen: (prev, curr) =>
            prev.isSuccess != curr.isSuccess ||
            prev.errorMessage != curr.errorMessage,
        listener: (context, state) {
          if (state.isSuccess) {
            ToastHelper.success(AppStringsConstants.createCustomerMsg);
            AppRoutes.pop();
          }
          if (state.errorMessage?.isNotEmpty == true) {
            ToastHelper.error(state.errorMessage!);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(AppSizes.p24),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonTextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      labelText: AppStringsConstants.customerName,
                      prefixIcon: Icons.person,
                      validator: (value) => AppValidators.requiredField(
                        value,
                        AppStringsConstants.customerName,
                      ),
                    ),
                    AppSizes.h12,
                    CommonDropdown<CompanyModel>(
                      enabled: state.companies.isEmpty ? false : true,
                      hintText: AppStringsConstants.selectCompany,
                      initialValue: state.selectedCompany,
                      items: state.companies,
                      itemLabel: (company) => company.name,
                      onChanged: (company) {
                        if (company != null) {
                          bloc.add(SelectCompanyEvent(company));
                        }
                      },
                      validator: (value) {
                        if (value == null) {
                          return AppStringsConstants.selectCompanyMsg;
                        }
                        return null;
                      },
                    ),
                    AppSizes.h12,
                    CommonTextFormField(
                      keyboardType: TextInputType.text,
                      controller: contactPersonController,
                      labelText: AppStringsConstants.contactPerson,
                      prefixIcon: Icons.person,
                      validator: (value) => AppValidators.requiredField(
                        value,
                        AppStringsConstants.contactPerson,
                      ),
                    ),
                    AppSizes.h12,
                    CommonTextFormField(
                      keyboardType: TextInputType.phone,
                      controller: mobileController,
                      maxLength: 10,
                      labelText: AppStringsConstants.mobileNumber,
                      prefixIcon: Icons.call,
                      validator: (value) => AppValidators.phone(value),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    AppSizes.h12,
                    CommonTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      labelText: AppStringsConstants.email,
                      prefixIcon: Icons.email,
                      validator: (value) => AppValidators.email(value),
                    ),
                    AppSizes.h12,
                    CommonTextFormField(
                      keyboardType: TextInputType.text,
                      controller: vatController,
                      labelText: AppStringsConstants.vatName,
                      prefixIcon: Icons.description_outlined,
                      validator: (value) => AppValidators.requiredField(
                        value,
                        AppStringsConstants.vatName,
                      ),
                    ),
                    AppSizes.h12,
                    CommonDropdown<PaymentTermsModel>(
                      enabled: state.paymentTerms.isEmpty ? false : true,
                      hintText: AppStringsConstants.selectPaymentTerms,
                      initialValue: state.selectedPaymentTerms,
                      items: state.paymentTerms,
                      itemLabel: (paymentTerms) => paymentTerms.name,
                      onChanged: (paymentTerms) {
                        if (paymentTerms != null) {
                          bloc.add(SelectPaymentTermsEvent(paymentTerms));
                        }
                      },
                      validator: (value) {
                        if (value == null) {
                          return AppStringsConstants.selectPaymentTermsMsg;
                        }
                        return null;
                      },
                    ),
                    AppSizes.h12,
                    CommonTextFormField(
                      keyboardType: TextInputType.number,
                      controller: creditLimitController,
                      labelText: AppStringsConstants.creditLimit,
                      prefixIcon: Icons.credit_card_rounded,
                      validator: (value) => AppValidators.requiredField(
                        value,
                        AppStringsConstants.creditLimit,
                      ),
                    ),
                    AppSizes.h12,
                    //Address
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(AppSizes.p12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizes.r12),
                        border: Border.all(color: AppColorsConstants.greyC8),
                      ),
                      child: Column(
                        children: [
                          AddressSelectionWidget(
                            groupValue: state.selectedAddressType,
                            onChanged: (value) {
                              if (value != null) {
                                bloc.add(SelectAddressTypeEvent(value));
                                cityController.clear();
                                zipController.clear();
                                addressController.clear();
                              }
                            },
                          ),
                          AppSizes.h12,
                          Row(
                            children: [
                              Expanded(
                                child: CommonDropdown<CountryModel>(
                                  enabled: state.countries.isEmpty
                                      ? false
                                      : true,
                                  hintText: AppStringsConstants.selectCountry,
                                  initialValue: state.selectedCountry,
                                  items: state.countries,
                                  itemLabel: (country) => country.name,
                                  onChanged: (country) {
                                    if (country != null) {
                                      bloc.add(SelectCountryEvent(country));
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return AppStringsConstants
                                          .selectCountryMsg;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              AppSizes.w12,
                              Expanded(
                                child: CommonDropdown<StateModel>(
                                  enabled:
                                      state.selectedCountry == null &&
                                          state.states.isEmpty
                                      ? false
                                      : true,
                                  hintText: AppStringsConstants.selectState,
                                  initialValue: state.selectedState,
                                  items: state.states,
                                  itemLabel: (state) => state.name,
                                  onChanged: state.selectedCountry == null
                                      ? null
                                      : (state) {
                                          if (state != null) {
                                            bloc.add(SelectStateEvent(state));
                                          }
                                        },
                                  validator: (value) {
                                    if (value == null) {
                                      return AppStringsConstants.selectStateMsg;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          AppSizes.h12,
                          Row(
                            children: [
                              Expanded(
                                child: CommonTextFormField(
                                  keyboardType: TextInputType.streetAddress,
                                  controller: cityController,
                                  labelText: AppStringsConstants.city,
                                  prefixIcon: Icons.location_city,
                                  validator: (value) =>
                                      AppValidators.requiredField(
                                        value,
                                        AppStringsConstants.city,
                                      ),
                                ),
                              ),
                              AppSizes.w12,
                              Expanded(
                                child: CommonTextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: zipController,
                                  labelText: AppStringsConstants.zip,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  prefixIcon: Icons.pin,
                                  validator: (value) =>
                                      AppValidators.requiredField(
                                        value,
                                        AppStringsConstants.zip,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          AppSizes.h12,
                          CommonTextFormField(
                            keyboardType: TextInputType.multiline,
                            controller: addressController,
                            labelText: AppStringsConstants.address,
                            prefixIcon: Icons.location_on_outlined,
                            validator: (value) => AppValidators.requiredField(
                              value,
                              AppStringsConstants.address,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppSizes.h24,
                    // Attachments Section
                    BuildAttachmentItem(
                      title: AppStringsConstants.attachments,
                      icon: Icons.attach_file,
                      onTap: _showAttachmentPicker,
                      attachments: state.attachments,
                      onRemove: (attachment) {
                        bloc.add(RemoveAttachmentEvent(attachment));
                      },
                    ),

                    AppSizes.h24,
                    //Notes Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(AppSizes.p12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizes.r12),
                        border: Border.all(color: AppColorsConstants.greyC8),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonTextWidget(
                                title: AppStringsConstants.notes,
                                color: AppColorsConstants.black,
                                fontSize: AppSizes.f16,
                                fontWeight: FontWeight.w700,
                              ),

                              CommonOutlineButton(
                                onTap: _showAddNoteBottomSheet,
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppSizes.p8,
                                ),
                                title: state.note != null
                                    ? AppStringsConstants.editNotePlus
                                    : AppStringsConstants.addNotePlus,
                                textColor: AppColorsConstants.primaryRedColor,
                                borderColor: AppColorsConstants.primaryRedColor,
                                fontWeight: FontWeight.w400,
                                fontSize: AppSizes.f10,
                                height: AppSizes.hS24,
                                borderRadius: AppSizes.r8,
                              ),
                            ],
                          ),
                          if (state.note != null) AppSizes.h12,
                          if (state.note != null) NoteCard(note: state.note!),
                        ],
                      ),
                    ),
                    AppSizes.h24,

                    // Tags Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(AppSizes.p12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizes.r12),
                        border: Border.all(color: AppColorsConstants.greyC8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CommonTextWidget(
                            title: AppStringsConstants.tag,
                            color: AppColorsConstants.black,
                            fontSize: AppSizes.f16,
                            fontWeight: FontWeight.w700,
                          ),
                          AppSizes.h12,
                          Wrap(
                            spacing: AppSizes.p8,
                            runSpacing: AppSizes.p8,
                            children: [
                              ...state.selectedContactTags.map((tag) {
                                return FilterChip(
                                  showCheckmark: false,
                                  label: CommonTextWidget(
                                    title: tag.name,
                                    color: AppColorsConstants.primaryRedColor,
                                    fontSize: AppSizes.f12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  selected: true,
                                  side: BorderSide(
                                    color: AppColorsConstants.primaryRedColor,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppSizes.r8,
                                    ),
                                  ),
                                  deleteIcon: const CommonIconWidget(
                                    icon: Icons.close,
                                    size: AppSizes.icon20,
                                    color: AppColorsConstants.primaryRedColor,
                                  ),

                                  onDeleted: () {
                                    bloc.add(RemoveSelectedTagEvent(tag: tag));
                                  },

                                  backgroundColor: AppColorsConstants.white,
                                  selectedColor: AppColorsConstants
                                      .primaryRedColor
                                      .withValues(alpha: 0.1),
                                  onSelected: (bool value) {},
                                );
                              }),
                              IntrinsicWidth(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  child: CommonDropdown<ContactTagModel>(
                                    enabled: state.contactTags.isEmpty
                                        ? false
                                        : true,
                                    key: UniqueKey(),
                                    hintText:
                                        AppStringsConstants.selectContactTag,
                                    items: state.contactTags,
                                    itemLabel: (contactTag) => contactTag.name,
                                    onChanged: (contactTag) {
                                      if (contactTag != null) {
                                        bloc.add(
                                          AddNewTagEvent(tag: contactTag),
                                        );
                                      }
                                    },
                                    validator: (value) {
                                      /* if (value == null) {
                                      return AppStringsConstants
                                          .selectContactTagMsg;
                                    }*/
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    AppSizes.h32,

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: CommonButton(
                            isLoading: state.isLoading,
                            title: AppStringsConstants.save,
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                bloc.add(
                                  CreateCustomerDataEvent(
                                    CreateCustomerData(
                                      name: nameController.text
                                          .trim()
                                          .toString(),
                                      companyId: state.selectedCompany!.id
                                          .toInt(),
                                      userId: 2,
                                      email: emailController.text
                                          .trim()
                                          .toString(),
                                      phone: mobileController.text
                                          .trim()
                                          .toString(),
                                      mobile: mobileController.text
                                          .trim()
                                          .toString(),
                                      vat: vatController.text.trim().toString(),
                                      paymentTermId:
                                          state.selectedPaymentTerms != null
                                          ? state.selectedPaymentTerms!.id
                                                .toInt()
                                          : 0,
                                      creditLimit: double.parse(
                                        creditLimitController.text
                                            .trim()
                                            .toString(),
                                      ),
                                      tagIds: state.selectedContactTags
                                          .map((e) => e.id.toInt())
                                          .toList(),
                                      street:
                                          state
                                              .selectedAddressType
                                              .isGpsLocation
                                          ? addressController.text
                                                .trim()
                                                .toString()
                                          : null,
                                      city:
                                          state
                                              .selectedAddressType
                                              .isGpsLocation
                                          ? cityController.text
                                                .trim()
                                                .toString()
                                          : null,
                                      zip:
                                          state
                                              .selectedAddressType
                                              .isGpsLocation
                                          ? zipController.text.trim().toString()
                                          : null,
                                      stateId:
                                          state
                                              .selectedAddressType
                                              .isGpsLocation
                                          ? state.selectedState?.id.toInt()
                                          : null,
                                      countryId:
                                          state
                                              .selectedAddressType
                                              .isGpsLocation
                                          ? state.selectedCountry?.id.toInt()
                                          : null,

                                      invoiceStreet:
                                          state
                                              .selectedAddressType
                                              .isBillingAddress
                                          ? addressController.text
                                                .trim()
                                                .toString()
                                          : null,
                                      invoiceCity:
                                          state
                                              .selectedAddressType
                                              .isBillingAddress
                                          ? cityController.text
                                                .trim()
                                                .toString()
                                          : null,
                                      invoiceZip:
                                          state
                                              .selectedAddressType
                                              .isBillingAddress
                                          ? zipController.text.trim().toString()
                                          : null,
                                      invoiceStateId:
                                          state
                                              .selectedAddressType
                                              .isBillingAddress
                                          ? state.selectedState?.id.toInt()
                                          : null,
                                      invoiceCountryId:
                                          state
                                              .selectedAddressType
                                              .isBillingAddress
                                          ? state.selectedCountry?.id.toInt()
                                          : null,

                                      deliveryStreet:
                                          state
                                              .selectedAddressType
                                              .isShippingAddress
                                          ? addressController.text
                                                .trim()
                                                .toString()
                                          : null,
                                      deliveryCity:
                                          state
                                              .selectedAddressType
                                              .isShippingAddress
                                          ? cityController.text
                                                .trim()
                                                .toString()
                                          : null,
                                      deliveryZip:
                                          state
                                              .selectedAddressType
                                              .isShippingAddress
                                          ? zipController.text.trim().toString()
                                          : null,
                                      deliveryStateId:
                                          state
                                              .selectedAddressType
                                              .isShippingAddress
                                          ? state.selectedState?.id.toInt()
                                          : null,
                                      deliveryCountryId:
                                          state
                                              .selectedAddressType
                                              .isShippingAddress
                                          ? state.selectedCountry?.id.toInt()
                                          : null,

                                      notes: state.selectedNoteType.isText
                                          ? state.noteText
                                          : state.selectedNoteDate
                                                ?.toIso8601String(),

                                      attachments: state.attachments,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),

                        AppSizes.w12,
                        Expanded(
                          child: CommonOutlineButton(
                            title: AppStringsConstants.archive,
                            borderColor: AppColorsConstants.primaryRedColor,
                            textColor: AppColorsConstants.primaryRedColor,
                            fontSize: AppSizes.f16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    AppSizes.h32,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

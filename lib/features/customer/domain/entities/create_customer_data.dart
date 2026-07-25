class CreateCustomerData {
  final String name;
  final int companyId;
  final int? userId;
  final String? email;
  final String? phone;
  final String? mobile;
  final String? vat;
  final int? paymentTermId;
  final double? creditLimit;
  final List<int>? tagIds;

  // Main Address
  final String? street;
  final String? street2;
  final String? city;
  final String? zip;
  final int? stateId;
  final int? countryId;

  // Invoice Address
  final String? invoiceStreet;
  final String? invoiceStreet2;
  final String? invoiceCity;
  final String? invoiceZip;
  final int? invoiceStateId;
  final int? invoiceCountryId;

  // Delivery Address
  final String? deliveryStreet;
  final String? deliveryStreet2;
  final String? deliveryCity;
  final String? deliveryZip;
  final int? deliveryStateId;
  final int? deliveryCountryId;

  final String? notes;
  final String? image; // Base64 string

  final List<AttachmentData>? attachments;

  CreateCustomerData({
    required this.name,
    required this.companyId,
    this.userId,
    this.email,
    this.phone,
    this.mobile,
    this.vat,
    this.paymentTermId,
    this.creditLimit,
    this.tagIds,
    this.street,
    this.street2,
    this.city,
    this.zip,
    this.stateId,
    this.countryId,
    this.invoiceStreet,
    this.invoiceStreet2,
    this.invoiceCity,
    this.invoiceZip,
    this.invoiceStateId,
    this.invoiceCountryId,
    this.deliveryStreet,
    this.deliveryStreet2,
    this.deliveryCity,
    this.deliveryZip,
    this.deliveryStateId,
    this.deliveryCountryId,
    this.notes,
    this.image,
    this.attachments,
  });

  /// Convert to Map for API request
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'company_id': companyId,
      if (userId != null) 'user_id': userId,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (mobile != null) 'mobile': mobile,
      if (vat != null) 'vat': vat,
      if (paymentTermId != null) 'payment_term_id': paymentTermId,
      if (creditLimit != null) 'credit_limit': creditLimit,
      if (tagIds != null && tagIds!.isNotEmpty) 'tag_ids': tagIds,
      if (street != null) 'street': street,
      if (street2 != null) 'street2': street2,
      if (city != null) 'city': city,
      if (zip != null) 'zip': zip,
      if (stateId != null) 'state_id': stateId,
      if (countryId != null) 'country_id': countryId,

      // Invoice Address
      if (invoiceStreet != null) 'invoice_street': invoiceStreet,
      if (invoiceStreet2 != null) 'invoice_street2': invoiceStreet2,
      if (invoiceCity != null) 'invoice_city': invoiceCity,
      if (invoiceZip != null) 'invoice_zip': invoiceZip,
      if (invoiceStateId != null) 'invoice_state_id': invoiceStateId,
      if (invoiceCountryId != null) 'invoice_country_id': invoiceCountryId,

      // Delivery Address
      if (deliveryStreet != null) 'delivery_street': deliveryStreet,
      if (deliveryStreet2 != null) 'delivery_street2': deliveryStreet2,
      if (deliveryCity != null) 'delivery_city': deliveryCity,
      if (deliveryZip != null) 'delivery_zip': deliveryZip,
      if (deliveryStateId != null) 'delivery_state_id': deliveryStateId,
      if (deliveryCountryId != null) 'delivery_country_id': deliveryCountryId,

      if (notes != null) 'notes': notes,
      if (image != null) 'image': image,

      if (attachments != null && attachments!.isNotEmpty)
        'attachments': attachments!.map((e) => e.toMap()).toList(),
    };
  }
}

class AttachmentData {
  final String filename;
  final String mimetype;
  final String content;

  AttachmentData({
    required this.filename,
    required this.mimetype,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {'filename': filename, 'mimetype': mimetype, 'content': content};
  }
}

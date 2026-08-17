class CreateSendMessageData {
  final int partnerId;
  final String messageType;
  final String subject;
  final String body;
  final int? messageId;
  final List<AttachmentData>? attachments;

  CreateSendMessageData({
    required this.partnerId,
    required this.messageType,
    required this.subject,
    required this.body,
    this.messageId,
    this.attachments,
  });

  Map<String, dynamic> toMap() {
    return {
      if (messageId != null) 'message_id': messageId,
      'partner_id': partnerId,
      'message_type': messageType,
      'subject': subject,
      'body': body,
      if (attachments != null && attachments!.isNotEmpty)
        'attachments': attachments!.map((e) => e.toMap()).toList(),
    };
  }
}

class AttachmentData {
  final String name;
  final String mimetype;
  final String content;

  AttachmentData({
    required this.name,
    required this.mimetype,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'mimetype': mimetype, 'datas': content};
  }
}

import 'package:json_annotation/json_annotation.dart';

part 'log_note.g.dart';

@JsonSerializable()
class LogNoteModel {
  @JsonKey(name: 'message_id')
  final int messageId;

  final String subject;
  final String body;

  @JsonKey(name: 'message_type')
  final String messageType;

  final String author;

  @JsonKey(name: 'author_email')
  final String authorEmail;

  final String date;

  final List<AttachmentModel> attachments;

  @JsonKey(name: 'create_date')
  final String createDate;

  @JsonKey(name: 'write_date')
  final String writeDate;

  LogNoteModel({
    required this.messageId,
    required this.subject,
    required this.body,
    required this.messageType,
    required this.author,
    required this.authorEmail,
    required this.date,
    required this.attachments,
    required this.createDate,
    required this.writeDate,
  });

  factory LogNoteModel.fromJson(Map<String, dynamic> json) =>
      _$LogNoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$LogNoteModelToJson(this);

  String get bodyPlainText {
    if (body.isEmpty) return '';
    return body
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .trim();
  }

}

@JsonSerializable()
class AttachmentModel {
  final int id;
  final String name;
  final String mimetype;

  @JsonKey(name: 'download_url')
  final String downloadUrl;

  AttachmentModel({
    required this.id,
    required this.name,
    required this.mimetype,
    required this.downloadUrl,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$AttachmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentModelToJson(this);
}


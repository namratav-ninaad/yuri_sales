// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendMessageModel _$SendMessageModelFromJson(Map<String, dynamic> json) =>
    SendMessageModel(
      messageId: (json['message_id'] as num).toInt(),
      subject: json['subject'] as String,
      body: json['body'] as String,
      messageType: json['message_type'] as String,
      author: json['author'] as String,
      authorEmail: json['author_email'] as String,
      date: json['date'] as String,
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createDate: json['create_date'] as String,
      writeDate: json['write_date'] as String,
    );

Map<String, dynamic> _$SendMessageModelToJson(SendMessageModel instance) =>
    <String, dynamic>{
      'message_id': instance.messageId,
      'subject': instance.subject,
      'body': instance.body,
      'message_type': instance.messageType,
      'author': instance.author,
      'author_email': instance.authorEmail,
      'date': instance.date,
      'attachments': instance.attachments,
      'create_date': instance.createDate,
      'write_date': instance.writeDate,
    };

AttachmentModel _$AttachmentModelFromJson(Map<String, dynamic> json) =>
    AttachmentModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      mimetype: json['mimetype'] as String,
      downloadUrl: json['download_url'] as String,
    );

Map<String, dynamic> _$AttachmentModelToJson(AttachmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mimetype': instance.mimetype,
      'download_url': instance.downloadUrl,
    };

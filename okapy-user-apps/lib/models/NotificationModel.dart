import 'dart:convert';

class NotificationModel{
  String? txt;
  String? created_at;

  NotificationModel(this.txt, this.created_at);
  factory NotificationModel.fromJson(Map<String, dynamic>data)
  {
    return NotificationModel(data['text'], data['created_at']);
  }
  factory NotificationModel.fromJson2(Map<String, dynamic>data)
  {
    String text=data['text'];
    return NotificationModel(text.substring(12,text.length-2), data['created_at']);
  }
}
class NotificationModel{
  String? txt;
  String? created_at;

  NotificationModel(this.txt, this.created_at);
  factory NotificationModel.fromJson(Map<String, dynamic>data)
  {
    return NotificationModel(data['text'], data['created_at']);
  }
}
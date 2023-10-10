class ChatNotice {
  String? type;
  String? name;
  Message? message;


  ChatNotice({this.type, this.name, this.message});

  ChatNotice.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
  }
  ChatNotice.fromJson2(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    message =Message.fromJson(json);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['name'] = this.name;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Message {
  int? id;
  String? conversation;
  String? text;
  String? createdAt;
  bool? isRead;
  Sender? sender;
  Sender? receiver;

  Message(
      {this.id,
      this.conversation,
      this.text,
      this.createdAt,
      this.isRead,
      this.sender,
      this.receiver});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    conversation = json['conversation'];
    text = json['text'];
    createdAt = json['created_at'];
    isRead = json['is_read'];
    sender =
        json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
    receiver =
        json['receiver'] != null ? new Sender.fromJson(json['receiver']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['conversation'] = this.conversation;
    data['text'] = this.text;
    data['created_at'] = this.createdAt;
    data['is_read'] = this.isRead;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    if (this.receiver != null) {
      data['receiver'] = this.receiver!.toJson();
    }
    return data;
  }
}

class Sender {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? image;
  String? phonenumber;
  bool? isAdmin;
  bool? isDriver;
  bool? isSuperuser;
  bool? isActive;
  String? dateJoined;
  bool? isConfirmed;

  Sender(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.image,
      this.phonenumber,
      this.isAdmin,
      this.isDriver,
      this.isSuperuser,
      this.isActive,
      this.dateJoined,
      this.isConfirmed});

  Sender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
    phonenumber = json['phonenumber'];
    isAdmin = json['is_admin'];
    isDriver = json['is_driver'];
    isSuperuser = json['is_superuser'];
    isActive = json['is_active'];
    dateJoined = json['date_joined'];
    isConfirmed = json['is_confirmed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
    data['phonenumber'] = this.phonenumber;
    data['is_admin'] = this.isAdmin;
    data['is_driver'] = this.isDriver;
    data['is_superuser'] = this.isSuperuser;
    data['is_active'] = this.isActive;
    data['date_joined'] = this.dateJoined;
    data['is_confirmed'] = this.isConfirmed;
    return data;
  }
}

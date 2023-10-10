class ActiveModel{
   int? id,status,booking_id,order_id;
   String? amount,created_at;
   Driver? driver;
   bool? is_paid;

   ActiveModel({this.id, this.status, this.amount, this.created_at,this.driver,this.is_paid,this.booking_id,this.order_id});

  factory ActiveModel.fromJson(Map<String,dynamic> data){
    return ActiveModel(id: data['booking']['id'],
    status: data['status'],
        amount: data['amount'],
        booking_id: data['id'],
        is_paid: data['is_paid'],
        order_id: data['id'],
        driver:data['driver']==null?Driver(id: 0):Driver.fromJson(data['driver']),
        created_at: data['created_at'],

    );

  }
}
class Owner{
  int? id;
  String? email,
      first_name,
      last_name,
      image,
      phonenumber,
      date_joined;
  bool? is_admin,
      is_driver,
      is_superuser,
      is_active,
      is_confirmed;

  Owner({ this.id,
    this.email,
    this.first_name,
    this.last_name,
    this.image,
    this.phonenumber,
    this.date_joined,
    this.is_admin,
    this.is_driver,
    this.is_superuser,
    this.is_active,
    this.is_confirmed}
     );
  factory Owner.fromJson(Map<String,dynamic>data){
    return Owner(
      id: data['id'],
      email: data['email'],
      first_name: data['first_name'],
      last_name: data['last_name'],
      image: data['image'],
      phonenumber: data['phonenumber'],
      date_joined: data['date_joined'],
      is_admin: data['is_admin'],
      is_active: data['is_active'],
      is_confirmed: data['is_confirmed'],
      is_driver: data['is_driver'],
      is_superuser: data['is_superuser']
    );
  }
}
class Driver{
  int id;
  String? email,
      first_name,
      last_name,
      image,
      phone_number,
      date_joined;
  bool? is_admin,is_driver,is_superuser,is_active,is_confirmed;

  Driver({
      required this.id,
      this.email,
      this.first_name,
      this.last_name,
      this.image,
      this.phone_number,
      this.date_joined,
      this.is_admin,
      this.is_driver,
      this.is_superuser,
      this.is_active,
      this.is_confirmed});
  factory Driver.fromJson(Map<String,dynamic>data){
    return Driver(
        id: data['id'],
        email: data['email'],
        first_name: data['first_name'],
        last_name: data['last_name'],
        image: data['image'],
        phone_number: data['phonenumber'],
        date_joined: data['date_joined'],
        is_admin: data['is_admin'],
        is_active: data['is_active'],
        is_confirmed: data['is_confirmed'],
        is_driver: data['is_driver'],
        is_superuser: data['is_superuser']
    );
  }

  @override
  String toString() {
    return 'Driver{id: $id, email: $email, first_name: $first_name, last_name: $last_name, image: $image, phone_number: $phone_number, date_joined: $date_joined, is_admin: $is_admin, is_driver: $is_driver, is_superuser: $is_superuser, is_active: $is_active, is_confirmed: $is_confirmed}';
  }
}
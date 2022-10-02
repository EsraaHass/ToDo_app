class MyUser {
  static const routeName = 'myUsers';

  String? id;
  String? name;
  String? password;
  String? email;

  MyUser({this.id, this.name, this.password, this.email});

  MyUser.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'],
          name: data['name'],
          password: data['password'],
          email: data['email'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'email': email,
    };
  }
}

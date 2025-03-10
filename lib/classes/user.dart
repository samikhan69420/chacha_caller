class User {
  String? gmail;
  String? name;
  String? accountType;
  User({
    this.gmail,
    this.name,
    this.accountType,
  });

  Map<String, dynamic> toMap() {
    return {
      'gmail': gmail,
      'name': name,
      'accountType': accountType,
    };
  }

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      gmail: data['gmail'],
      name: data['name'],
      accountType: data['accountType'],
    );
  }
}

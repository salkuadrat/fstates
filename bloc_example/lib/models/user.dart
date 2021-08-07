class User {
  final int id;
  final String name;
  final String email;
  final String? gender;
  final String? status;

  bool get isActive => status == 'active';

  User({
    required this.id,
    required this.name,
    required this.email,
    this.gender,
    this.status,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = int.tryParse(json['id']?.toString() ?? '') ?? 0,
        name = json['name']?.toString() ?? '',
        email = json['email']?.toString() ?? '',
        gender = json['gender']?.toString(),
        status = json['status']?.toString();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'gender': gender,
        'status': status,
      };
}

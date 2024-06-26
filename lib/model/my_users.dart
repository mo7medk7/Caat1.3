class MyUser {
  static const String collectionName = 'users';

  String? id;
  String? name;
  String? email;
  String? role; // Add role property

  MyUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  MyUser.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data?['id'] as String?,
          name: data?['name'] as String?,
          email: data?['email'] as String?,
          role: data?['role'] as String?,
        );

  Map<String, dynamic> toFireStore() {
    return {'id': id, 'name': name, 'email': email, 'role': role};
  }
}

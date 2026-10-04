class DemoStudent {
  final String id;
  final String name;
  final String email;

  DemoStudent({
    required this.id,
    required this.name,
    required this.email,
  });

  factory DemoStudent.fromJson(Map<String, dynamic> json) {
    return DemoStudent(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
  };
}

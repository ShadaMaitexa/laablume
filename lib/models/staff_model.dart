class Staff {
  final String id;
  final String name;
  final String role; // technician, pathologist, etc.
  final String? email;
  final String? phone;
  final String labId;
  final bool isActive;

  Staff({
    required this.id,
    required this.name,
    required this.role,
    this.email,
    this.phone,
    required this.labId,
    this.isActive = true,
  });

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      email: json['email'],
      phone: json['phone'],
      labId: json['labId'] ?? '',
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'email': email,
      'phone': phone,
      'labId': labId,
      'isActive': isActive,
    };
  }
}

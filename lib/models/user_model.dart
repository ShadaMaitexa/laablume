class UserModel {
  final String id;
  final String name;
  final String email;
  final String? profileImageUrl;
  final String mobileNumber;
  final String role; // 'patient', 'doctor', 'lab', 'hospital', 'admin'
  final bool isApproved;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.role,
    this.isApproved = true, // Default to true for patients, false for labs/hospitals if needed
    this.profileImageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? json['_id'] ?? '',
      name: json['name'] ?? json['userName'] ?? '',
      email: json['email'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      role: json['role'] ?? 'patient',
      isApproved: json['isApproved'] ?? true,
      profileImageUrl: json['profileImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobileNumber': mobileNumber,
      'role': role,
      'isApproved': isApproved,
      'profileImageUrl': profileImageUrl,
    };
  }
}

class HospitalModel {
  final String id;
  final String hospitalName;
  final String location;
  final String email;
  final String mobileNumber;
  final bool isApproved;
  final List<String> doctorIds;

  HospitalModel({
    required this.id,
    required this.hospitalName,
    required this.location,
    required this.email,
    required this.mobileNumber,
    this.isApproved = false,
    this.doctorIds = const [],
  });

  factory HospitalModel.fromJson(Map<String, dynamic> json) {
    return HospitalModel(
      id: json['id'] ?? json['_id'] ?? '',
      hospitalName: json['hospitalName'] ?? json['userName'] ?? '',
      location: json['location'] ?? '',
      email: json['email'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      isApproved: json['isApproved'] ?? false,
      doctorIds: List<String>.from(json['doctorIds'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hospitalName': hospitalName,
      'location': location,
      'email': email,
      'mobileNumber': mobileNumber,
      'isApproved': isApproved,
      'doctorIds': doctorIds,
    };
  }
}

class DashboardData {
  final int upcomingAppointments;
  final int pendingReports;
  final int healthScore;

  DashboardData({
    required this.upcomingAppointments,
    required this.pendingReports,
    required this.healthScore,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      upcomingAppointments: json['upcoming_appointments'] ?? 0,
      pendingReports: json['pending_reports'] ?? 0,
      healthScore: json['health_score'] ?? 0,
    );
  }
}

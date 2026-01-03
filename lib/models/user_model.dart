class UserModel {
  final String id;
  final String name;
  final String email;
  final String? profileImageUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.profileImageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profileImageUrl: json['profileImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
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
